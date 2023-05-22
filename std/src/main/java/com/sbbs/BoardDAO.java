package com.sbbs;

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
		
		try {
			sql = " INSERT INTO sbbs (num, subject, content, userId, reg_date, "
					+ " hitCount, saveFilename, originalFilename, fileSize, category) "
					+ " VALUES (sbbs_seq.NEXTVAL,?,?,?,SYSDATE,0,?,?,?,?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getUserId());
			pstmt.setString(4, dto.getSaveFilename());
			pstmt.setString(5, dto.getOriginalFilename());
			pstmt.setLong(6, dto.getFileSize());
			pstmt.setInt(7, dto.getCategory());
			
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
	
	
	
	
	public int dataCount(int category) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		//조건에 category = ?와야함, category로 구분
		
		try {
			sql = " SELECT COUNT(*) FROM sbbs WHERE category = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, category);
			
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
	
	public int dataCount(int category, String condition, String keyword) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		//sbbs와 member1 조인(userName을 가져와야함)
		
		
		try {
			sql = " SELECT COUNT(*) FROM sbbs s JOIN member1 m ON s.userId = m.userId WHERE category = ? ";
			if(condition.equals("all")) {
				sql += " AND (INSTR(subject, ? ) >= 1 OR INSTR(content, ? ) >= 1) ";
			}else if(condition.equals("userName")) {
				sql += " AND userName = ?";
			}else if(condition.equals("reg_date")) {
				keyword = keyword.replaceAll("(\\-|\\.|\\/)", "");
				sql += " AND TO_CHAR(reg_date,'YYYYMMDD') = ? " ;
			}else {
				sql += " AND INSTR(" + condition + ", ? ) >= 1 ";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, category);
			pstmt.setString(2, keyword);
			if(condition.equals("all")) {
				pstmt.setString(3, keyword);
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
	
	public List<BoardDTO> listBoard(int category, int offset, int size){
		List<BoardDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		//가져와야할것 : num(article에 넘겨줘야함), userName, subject, hitCount, reg_date, saveFilename(첨부파일이 있으면 이미지띄어줘야함)
		//sbbs와 member1 조인
		
		try {
			sql = " SELECT num,userName,subject,hitCount,saveFilename, "
					+ " TO_CHAR(reg_date,'YYYY-MM-DD')reg_date "
					+ " FROM sbbs s "
					+ " JOIN member1 m ON s.userId = m.userId "
					+ " WHERE category = ? "
					+ " ORDER BY num DESC "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt= conn.prepareStatement(sql);
			
			pstmt.setInt(1, category);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setSaveFilename(rs.getString("saveFilename"));
				
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
	
	public List<BoardDTO> listBoard(int category, int offset, int size, String condition, String keyword){
		List<BoardDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		//num, userName, subject, hitCount, reg_date, saveFilename
		//sbbs와 member1 조인
		
		try {
			sql = " SELECT num,userName,subject,hitCount,saveFilename, "
					+ " TO_CHAR(reg_date,'YYYY-MM-DD')reg_date "
					+ " FROM sbbs s "
					+ " JOIN member1 m ON s.userId = m.userId "
					+ " WHERE category = ? ";
			if(condition.equals("all")) {
				sql += " AND (INSTR(subject, ? ) >= 1 OR INSTR(content, ? ) >= 1) ";
			}else if(condition.equals("userName")) {
				sql += " AND userName = ?";
			}else if(condition.equals("reg_date")) {
				keyword = keyword.replaceAll("(\\-|\\.|\\/)", "");
				sql += " AND TO_CHAR(reg_date,'YYYYMMDD') = ? " ;
			}else {
				sql += " AND INSTR(" + condition + ", ? ) >= 1 ";
			}
					
			sql += " ORDER BY num DESC ";
			sql += " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt= conn.prepareStatement(sql);
			
			pstmt.setInt(1, category);
			
			if(condition.equals("all")) {
				pstmt.setString(2, keyword);
				pstmt.setString(3, keyword);
				pstmt.setInt(4, offset);
				pstmt.setInt(5, size);
			}else {
				pstmt.setString(2, keyword);
				pstmt.setInt(3, offset);
				pstmt.setInt(4, size);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setSaveFilename(rs.getString("saveFilename"));
				
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
	
	
	// 조회수 증가하기
		public void updateHitCount(long num) throws SQLException {
			PreparedStatement pstmt = null;
			String sql;

			try {
				sql = "UPDATE sbbs SET hitCount=hitCount+1 WHERE num=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setLong(1, num);
				
				pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			} finally {
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException e2) {
					}
				}
			}
		}

		// 해당 게시물 보기
		public BoardDTO readBoard(long num) {
			BoardDTO dto = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;

			try {
				sql = "SELECT num, category, b.userId, userName, subject, content, "
						+ " saveFilename, originalFilename, filesize, reg_date, hitCount "
						+ " FROM sbbs b "
						+ " JOIN member1 m ON b.userId=m.userId "
						+ " WHERE num = ? ";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setLong(1, num);

				rs = pstmt.executeQuery();

				if (rs.next()) {
					dto = new BoardDTO();
					
					dto.setNum(rs.getLong("num"));
					dto.setCategory(rs.getInt("category"));
					dto.setUserId(rs.getString("userId"));
					dto.setUserName(rs.getString("userName"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setSaveFilename(rs.getString("saveFilename"));
					dto.setOriginalFilename(rs.getString("originalFilename"));
					dto.setFileSize(rs.getLong("filesize"));
					dto.setHitCount(rs.getInt("hitCount"));
					dto.setReg_date(rs.getString("reg_date"));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException e) {
					}
				}

				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException e) {
					}
				}
			}

			return dto;
		}

		// 이전글
		public BoardDTO preReadBoard(int category, long num, String condition, String keyword) {
			BoardDTO dto = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			StringBuilder sb = new StringBuilder();

			try {
				if (keyword != null && keyword.length() != 0) {
					sb.append(" SELECT num, subject ");
					sb.append(" FROM sbbs b ");
					sb.append(" JOIN member1 m ON b.userId = m.userId ");
					sb.append(" WHERE category = ? AND num > ? ");
					if (condition.equals("all")) {
						sb.append("   AND ( INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 ) ");
					} else if (condition.equals("reg_date")) {
						keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
						sb.append("   AND TO_CHAR(reg_date, 'YYYYMMDD') = ? ");
					} else {
						sb.append("   AND INSTR(" + condition + ", ?) >= 1 ");
					}
					sb.append(" ORDER BY num ASC ");
					sb.append(" FETCH FIRST 1 ROWS ONLY ");

					pstmt = conn.prepareStatement(sb.toString());
					
					pstmt.setInt(1, category);
					pstmt.setLong(2, num);
					pstmt.setString(3, keyword);
					if (condition.equals("all")) {
						pstmt.setString(4, keyword);
					}
				} else {
					sb.append(" SELECT num, subject FROM sbbs ");
					sb.append(" WHERE category = ? AND num > ? ");
					sb.append(" ORDER BY num ASC ");
					sb.append(" FETCH FIRST 1 ROWS ONLY ");

					pstmt = conn.prepareStatement(sb.toString());
					
					pstmt.setInt(1, category);
					pstmt.setLong(2, num);
				}

				rs = pstmt.executeQuery();

				if (rs.next()) {
					dto = new BoardDTO();
					
					dto.setNum(rs.getLong("num"));
					dto.setSubject(rs.getString("subject"));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException e) {
					}
				}

				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException e) {
					}
				}
			}

			return dto;
		}

		// 다음글
		public BoardDTO nextReadBoard(int category, long num, String condition, String keyword) {
			BoardDTO dto = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			StringBuilder sb = new StringBuilder();

			try {
				if (keyword != null && keyword.length() != 0) {
					sb.append(" SELECT num, subject ");
					sb.append(" FROM sbbs b ");
					sb.append(" JOIN member1 m ON b.userId = m.userId ");
					sb.append(" WHERE category = ? AND num < ? ");
					if (condition.equals("all")) {
						sb.append("   AND ( INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 ) ");
					} else if (condition.equals("reg_date")) {
						keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
						sb.append("   AND TO_CHAR(reg_date, 'YYYYMMDD') = ? ");
					} else {
						sb.append("   AND INSTR(" + condition + ", ?) >= 1 ");
					}
					sb.append(" ORDER BY num DESC ");
					sb.append(" FETCH FIRST 1 ROWS ONLY ");

					pstmt = conn.prepareStatement(sb.toString());
					
					pstmt.setInt(1, category);
					pstmt.setLong(2, num);
					pstmt.setString(3, keyword);
					if (condition.equals("all")) {
						pstmt.setString(4, keyword);
					}
				} else {
					sb.append(" SELECT num, subject FROM sbbs ");
					sb.append(" WHERE category = ? AND num < ? ");
					sb.append(" ORDER BY num DESC ");
					sb.append(" FETCH FIRST 1 ROWS ONLY ");

					pstmt = conn.prepareStatement(sb.toString());
					
					pstmt.setInt(1, category);
					pstmt.setLong(2, num);
				}

				rs = pstmt.executeQuery();

				if (rs.next()) {
					dto = new BoardDTO();
					
					dto.setNum(rs.getLong("num"));
					dto.setSubject(rs.getString("subject"));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException e) {
					}
				}

				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException e) {
					}
				}
			}

			return dto;
		}
		
		
		public void updateBoard(BoardDTO dto )throws SQLException{
			PreparedStatement pstmt = null;
			String sql;
			
			try {
				sql = " UPDATE sbbs SET subject = ? , content = ?, saveFilename= ? , originalFilename = ? , fileSize = ? "
						+ " WHERE num = ? AND userId = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, dto.getSubject());
				pstmt.setString(2, dto.getContent());
				pstmt.setString(3, dto.getSaveFilename());
				pstmt.setString(4, dto.getOriginalFilename());
				pstmt.setLong(5, dto.getFileSize());
				pstmt.setLong(6, dto.getNum());
				pstmt.setString(7, dto.getUserId());//게시글은 본인만 수정할수있어야 하기때문에 확실하게 설정
				
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
		
		
		public void deleteBoard(long num, String userId)throws SQLException{
			//삭제는 admin이나 userId가 할수있음
			PreparedStatement pstmt = null;
			String sql;
			
			try {
				sql = " DELETE FROM sbbs WHERE num = ? ";
				if(userId.equals("admin")) {
					pstmt = conn.prepareStatement(sql);
					pstmt.setLong(1, num);
				}else {
					sql += " AND userId = ? ";
					pstmt = conn.prepareStatement(sql);
					pstmt.setLong(1, num);
					pstmt.setString(2, userId);
				}
				
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
	
	
	
	
}
