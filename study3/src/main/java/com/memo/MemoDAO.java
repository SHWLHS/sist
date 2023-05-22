package com.memo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class MemoDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertMemo(MemoDTO dto) throws SQLException{
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO memo (num,content,saveFilename,originalFilename,reg_date ,update_date) "
					+ " VALUES (memo_seq.NEXTVAL, ? , ?, ? , SYSDATE, SYSDATE) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getContent());
			pstmt.setString(2, dto.getSaveFilename());
			pstmt.setString(3, dto.getOriginalFilename());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
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
	
	
	
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		
		try {
			sql = " SELECT COUNT(*) FROM memo ";
			
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
	
	
	
	
	public List<MemoDTO> listMemo(int offset, int size){
		List<MemoDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT num, content, "
					+ " TO_CHAR(reg_date,'YYYY-MM-DD')reg_date , "
					+ " TO_CHAR(update_date,'YYYY-MM-DD')update_date, "
					+ " originalFilename , saveFilename "
					+ " FROM memo  "
					+ " ORDER BY num DESC "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemoDTO dto = new MemoDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setUpdate_date(rs.getString("update_date"));
				dto.setOriginalFilename(rs.getString("originalFilename"));
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
	
	public MemoDTO readMemo(long num) {
		MemoDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT num, content,  "
					+ " reg_date, "
					+ " update_date, "
					+ " originalFilename , saveFilename "
					+ " FROM memo "
					+ " WHERE num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new MemoDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setUpdate_date(rs.getString("update_date"));
				dto.setOriginalFilename(rs.getString("originalFilename"));
				dto.setSaveFilename(rs.getString("saveFilename"));
				
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
	
	public void updateMemo(MemoDTO dto ) throws Exception{
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = " UPDATE memo SET content = ? , update_date = SYSDATE ,"
					+ " originalFilename=? , saveFilename = ?"
					+ " WHERE num = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getContent());
			pstmt.setString(2, dto.getOriginalFilename());
			pstmt.setString(3, dto.getSaveFilename());
			pstmt.setLong(4, dto.getNum());
			
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
	
	public void deleteMemo(long num) throws Exception {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = " DELETE FROM memo WHERE num = ? ";
			
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
