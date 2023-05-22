package com.bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class BoardDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertBoard(BoardDTO dto) throws SQLException{
		PreparedStatement pstmt = null;
		String sql;
		
		//INSERT INTO 테이블명 (컬럼,컬럼) VALUES(값, 값)
		
		try {
			sql = "INSERT INTO bbs(num,name,pwd,subject,content,ipAddr,hitCount,reg_date) "
					+ " VALUES (bbs_seq.NEXTVAL,?,?,?,?,?,0,SYSDATE) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getPwd());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getIpAddr());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;//예외던지기(까먹지마!!!)
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
	}
	

	//조건 없는 총데이터 개수
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT COUNT(*) FROM bbs ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
		}
		
		
		return result;
	}
	
	//조건 있는 데이터 개수
	public int dataCount(String condition, String keyword) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT COUNT(*) FROM bbs ";
			if(condition.equals("all")) { //오라클 INSTR 위치를 반환(없으면 0 있으면 1부터)
				sql += " WHERE INSTR(subject, ? ) >= 1 OR INSTR(content, ? ) >=1 ";
			}else if(condition.equals("reg_date")) {
				//20201010, 2020-10-10로도 검색가능하게끔 설정
				keyword = keyword.replaceAll("(\\-|\\.|\\/)", "");//- . / 를 입력한날짜에서 없앰
				//reg_date를 가져올때 년월일시분초가 같이 나오니깐 년월일만 뽑아주기
				sql += " WHERE TO_CHAR(reg_date,'YYYYMMDD') = ? ";
			}else { //subject, content, name
				sql += " WHERE INSTR(" + condition + ", ?) >= 1";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, keyword);
			if(condition.equals("all")) {//all일때는 ?가 두개여서 두번째 값 넣어주기
				pstmt.setString(2,keyword);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
		}
		
		return result;
	}
	
	//조건 없는 리스트
	public List<BoardDTO> listBoard(int offset, int size){
		List<BoardDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT num,name,subject,hitCount, "
					+ " TO_CHAR(reg_date,'YYYY-MM-DD')reg_date "
					+ " FROM bbs "
					+ " ORDER BY num DESC "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO dto  = new BoardDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setReg_date(rs.getString("reg_date"));
				
				list.add(dto);				
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
		}
		return list;
	}
	
	//조건 있는 리스트
	public List<BoardDTO> listBoard(int offset, int size, String condition, String keyword){
		List<BoardDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT num,name,subject,hitCount, "
					+ " TO_CHAR(reg_date,'YYYY-MM-DD')reg_date "
					+ " FROM bbs ";
			if(condition.equals("all")) { //오라클 INSTR 위치를 반환(없으면 0 있으면 1부터)
				sql += " WHERE INSTR(subject, ? ) >= 1 OR INSTR(content, ? ) >=1 ";
			}else if(condition.equals("reg_date")) {
				//20201010, 2020-10-10로도 검색가능하게끔 설정
				keyword = keyword.replaceAll("(\\-|\\.|\\/)", "");//- . / 를 입력한날짜에서 없앰
				//reg_date를 가져올때 년월일시분초가 같이 나오니깐 년월일만 뽑아주기
				sql += " WHERE TO_CHAR(reg_date,'YYYYMMDD') = ? ";
			}else { //subject, content, name
				sql += " WHERE INSTR(" + condition + ", ?) >= 1";
			}
			
			sql += " ORDER BY num DESC ";
			sql += "OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			if(condition.equals("all")) {
				pstmt.setString(1,keyword);
				pstmt.setString(2,keyword);
				pstmt.setInt(3,offset);
				pstmt.setInt(4, size);
			}else {
				pstmt.setString(1, keyword);
				pstmt.setInt(2, offset);
				pstmt.setInt(3, size);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO dto  = new BoardDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setReg_date(rs.getString("reg_date"));
				
				list.add(dto);				
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
		}
		return list;
	}
	
	//글보기
	public BoardDTO readBoard(long num) {
		BoardDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			//reg_date는 시분초까지 보이게 하려고 TO_CHAR안하고 가져옴
			sql = " SELECT num, name, subject, content, pwd, ipAddr, hitCount, reg_date "
					+ " FROM bbs "
					+ " WHERE num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new BoardDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setPwd(rs.getString("pwd"));
				dto.setIpAddr(rs.getString("ipAddr"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setReg_date(rs.getString("reg_date"));
				
			}
			
			
			
		} catch (Exception e) {
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
		}
		
		
		return dto;
	}
	
	
	//이전글 : 위에 있는것이 이전글 아래있는것이 다음글
	public BoardDTO preReadBoard(long num, String condition, String keyword) {
		BoardDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			
			if(keyword != null && keyword.length() != 0) {//검색
				sb.append("SELECT num, subject ");
				sb.append(" FROM bbs ");
				sb.append(" WHERE num > ? ");
				if(condition.equals("all")) {
					sb.append(" AND (INSTR(subject, ? ) >= 1 OR INSTR(content, ? ) >= 1 )");
				}else if(condition.equals("reg_date")) {
					keyword = keyword.replaceAll("(\\.|\\-|\\/)", "");
					sb.append(" AND (TO_CHAR(reg_date, 'YYYYMMDD' ) = ? ) ");
				}else {
					sb.append(" AND (INSTR(" + condition + " , ? ) >= 1");
				}
				sb.append(" ORDER BY num ASC");
				sb.append(" FETCH FIRST 1 ROWS ONLY");
				
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setLong(1, num);
				pstmt.setString(2, keyword);
				
				if(condition.equals("all")) {
					pstmt.setString(3, keyword);
				}
				
				
			}else {//검색이 아닐때
				sb.append("SELECT num, subject ");
				sb.append(" FROM bbs ");
				sb.append(" WHERE num > ? ");//큰것중에서
				sb.append(" ORDER BY num ASC ");//오름차순정렬(작은게 제일 위로)
				sb.append(" FETCH FIRST 1 ROWS ONLY");//첫번째꺼 가져오는것
				
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setLong(1, num);
				
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new BoardDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setSubject(rs.getString("subject"));
			}
			
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
		}
		
		
		return dto;
	}
	
	
	//다음글
	public BoardDTO nextReadBoard(long num, String condition, String keyword) {
		BoardDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			if(keyword != null && keyword.length() != 0) {//검색
				sb.append("SELECT num, subject ");
				sb.append(" FROM bbs ");
				sb.append(" WHERE num < ? ");
				if(condition.equals("all")) {
					sb.append(" AND (INSTR(subject, ? ) >= 1 OR INSTR(content, ? ) >= 1 )");
				}else if(condition.equals("reg_date")) {
					keyword = keyword.replaceAll("(\\.|\\-|\\/)", "");
					sb.append(" AND (TO_CHAR(reg_date, 'YYYYMMDD' ) = ? ) ");
				}else {
					sb.append(" AND (INSTR(" + condition + " , ? ) >= 1");
				}
				sb.append(" ORDER BY num DESC");
				sb.append(" FETCH FIRST 1 ROWS ONLY");
				
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setLong(1, num);
				pstmt.setString(2, keyword);
				
				if(condition.equals("all")) {
					pstmt.setString(3, keyword);
				}
				
				
			}else {//검색이 아닐때
				sb.append("SELECT num, subject ");
				sb.append(" FROM bbs ");
				sb.append(" WHERE num < ? ");//작은것중에서
				sb.append(" ORDER BY num DESC ");//내림차순정렬(큰것이 위로)
				sb.append(" FETCH FIRST 1 ROWS ONLY");//첫번째꺼 가져오는것
				
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setLong(1, num);
				
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new BoardDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setSubject(rs.getString("subject"));
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
		}
		
		
		return dto;
	}
	
	
	
	
	public void updateHitCount(long num) throws SQLException{
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			//조회수는 데이터를 수정해줌
			sql = " UPDATE bbs SET hitCount = hitCount + 1 WHERE num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		
		}
		
	}
	
	
	public void updateBoard(BoardDTO dto) throws Exception {
		PreparedStatement pstmt = null;
		String sql ;
		
		try {
			sql = " UPDATE bbs SET name= ?, subject= ?, content = ?, pwd = ?  "
					+ " WHERE num = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPwd());
			pstmt.setLong(5, dto.getNum());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(pstmt != null) {
				pstmt.close();
			}
		}
		
		
		
		
	}
	
	public void deleteBoard(long num) throws Exception {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = " DELETE FROM bbs WHERE num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			
			pstmt.executeUpdate();
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(pstmt != null) {
				pstmt.close();
			}
		}
		
	}
	
	
	
	
	
	
}
