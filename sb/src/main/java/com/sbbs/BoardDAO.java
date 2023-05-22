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

	// 데이터 추가
	public void insertBoard(BoardDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "INSERT INTO sbbs(num, category, userId, subject, content, "
					+ " saveFilename, originalFilename, filesize, hitCount, reg_date) "
					+ " VALUES (sbbs_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, 0, SYSDATE)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, dto.getCategory());
			pstmt.setString(2, dto.getUserId());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getSaveFilename());
			pstmt.setString(6, dto.getOriginalFilename());
			pstmt.setLong(7, dto.getFileSize());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
		}
	}

	// 데이터 개수
	public int dataCount(int category) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM sbbs WHERE category = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, category);

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				result = rs.getInt(1);
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

		return result;
	}

	// 검색에서의 데이터 개수
	public int dataCount(int category, String condition, String keyword) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM sbbs b "
					+ " JOIN member1 m ON b.userId = m.userId "
					+ " WHERE category = ? ";
			if (condition.equals("all")) {
				sql += "  AND (INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1) ";
			} else if (condition.equals("reg_date")) {
				keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
				sql += "  AND TO_CHAR(reg_date, 'YYYYMMDD') = ? ";
			} else {
				sql += "  AND INSTR(" + condition + ", ?) >= 1 ";
			}

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, category);
			pstmt.setString(2, keyword);
			if (condition.equals("all")) {
				pstmt.setString(3, keyword);
			}

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				result = rs.getInt(1);
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

		return result;
	}

	// 게시물 리스트
	public List<BoardDTO> listBoard(int category, int offset, int size) {
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append(" SELECT num, userName, subject, saveFilename, hitCount, ");
			sb.append("       TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date ");
			sb.append(" FROM sbbs b ");
			sb.append(" JOIN member1 m ON b.userId = m.userId ");
			sb.append(" WHERE category = ? ");
			sb.append(" ORDER BY num DESC ");
			sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");

			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setInt(1, category);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);

			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BoardDTO dto = new BoardDTO();

				dto.setNum(rs.getLong("num"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setSaveFilename(rs.getString("saveFilename"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setReg_date(rs.getString("reg_date"));

				list.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e2) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e2) {
				}
			}
		}

		return list;
	}

	public List<BoardDTO> listBoard(int category, int offset, int size, String condition, String keyword) {
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append(" SELECT num, userName, subject, saveFilename, hitCount, ");
			sb.append("       TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date ");
			sb.append(" FROM sbbs b ");
			sb.append(" JOIN member1 m ON b.userId = m.userId ");
			sb.append(" WHERE category = ? ");
			if (condition.equals("all")) {
				sb.append(" AND (INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1) ");
			} else if (condition.equals("reg_date")) {
				keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
				sb.append(" AND TO_CHAR(reg_date, 'YYYYMMDD') = ?) ");
			} else {
				sb.append(" AND INSTR(" + condition + ", ?) >= 1 ");
			}
			sb.append(" ORDER BY num DESC ");
			sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");

			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setInt(1, category);
			if (condition.equals("all")) {
				pstmt.setString(2, keyword);
				pstmt.setString(3, keyword);
				pstmt.setInt(4, offset);
				pstmt.setInt(5, size);
			} else {
				pstmt.setString(2, keyword);
				pstmt.setInt(3, offset);
				pstmt.setInt(4, size);
			}

			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BoardDTO dto = new BoardDTO();

				dto.setNum(rs.getLong("num"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setSaveFilename(rs.getString("saveFilename"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setReg_date(rs.getString("reg_date"));

				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e2) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e2) {
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
			sql = "SELECT b.num, category, b.userId, userName, subject, content, "
					+ " saveFilename, originalFilename, filesize, reg_date, hitCount, "
					+ " NVL(likeCount, 0) likeCount "
					+ " FROM sbbs b "
					+ " JOIN member1 m ON b.userId=m.userId "
					+ " LEFT OUTER JOIN ("
					+ "      SELECT num, COUNT(*) likeCount FROM sbbsLike"
					+ "      GROUP BY num"
					+ " ) bc ON b.num = bc.num"
					+ " WHERE b.num = ? ";
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
				
				dto.setLikeCount(rs.getInt("likeCount"));
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

	// 게시물 수정
	public void updateBoard(BoardDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "UPDATE sbbs SET subject=?, content=?, "
					+ " saveFilename=?, originalFilename=?, filesize=? WHERE num=? AND userId=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getSaveFilename());
			pstmt.setString(4, dto.getOriginalFilename());
			pstmt.setLong(5, dto.getFileSize());
			pstmt.setLong(6, dto.getNum());
			pstmt.setString(7, dto.getUserId());
			
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}

	}

	// 게시물 삭제
	public void deleteBoard(long num, String userId) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			if (userId.equals("admin")) {
				sql = "DELETE FROM sbbs WHERE num=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setLong(1, num);
				
				pstmt.executeUpdate();
			} else {
				sql = "DELETE FROM sbbs WHERE num=? AND userId=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setLong(1, num);
				pstmt.setString(2, userId);
				
				pstmt.executeUpdate();
			}

		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}
	}
	
	// 로그인 유저의 게시글 공감 유무
	public boolean isUserBoardLike(long num, String userId) {
		boolean result = false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT num, userId FROM sbbsLike WHERE num = ? AND userId = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			pstmt.setString(2, userId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			
		}
		
		return result;
	}

	// 게시물의 공감 추가
	public void insertBoardLike(long num, String userId) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO sbbsLike(num, userId) VALUES (?, ?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			pstmt.setString(2, userId);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}
		
	}
	
	// 게시글 공감 삭제
	public void deleteBoardLike(long num, String userId) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "DELETE FROM sbbsLike WHERE num = ? AND userId = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			pstmt.setString(2, userId);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
	}
	
	// 게시물의 공감 개수
	public int countBoardLike(long num) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM sbbsLike WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
				
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}
		
		return result;
	}
	
	// 게시물의 댓글 및 답글 추가
	public void insertReply(ReplyDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO sbbsReply(replyNum, num, userId, content, answer, reg_date) "
					+ " VALUES (sbbsReply_seq.NEXTVAL, ?, ?, ?, ?, SYSDATE)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, dto.getNum());
			pstmt.setString(2, dto.getUserId());
			pstmt.setString(3, dto.getContent());
			pstmt.setLong(4, dto.getAnswer());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
		}
		
	}

	// 게시물의 댓글 개수
	public int dataCountReply(long num) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM sbbsReply WHERE num=? AND answer=0";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
				
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}
		
		return result;
	}

	// 게시물 댓글 리스트
	public List<ReplyDTO> listReply(long num, int offset, int size) {
		List<ReplyDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			sb.append(" SELECT r.replyNum, r.userId, userName, num, content, r.reg_date, ");
			sb.append("     NVL(answerCount, 0) answerCount ");
			sb.append(" FROM sbbsReply r ");
			sb.append(" JOIN member1 m ON r.userId = m.userId ");
			sb.append(" LEFT OUTER  JOIN (");
			sb.append("     SELECT answer, COUNT(*) answerCount ");
			sb.append("     FROM sbbsReply ");
			sb.append("     WHERE answer != 0 ");
			sb.append("     GROUP BY answer ");
			sb.append(" ) a ON r.replyNum = a.answer ");
			sb.append(" WHERE num = ? AND r.answer=0 ");
			sb.append(" ORDER BY r.replyNum DESC ");
			sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");
			
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setLong(1, num);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReplyDTO dto = new ReplyDTO();
				
				dto.setReplyNum(rs.getLong("replyNum"));
				dto.setNum(rs.getLong("num"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setAnswerCount(rs.getInt("answerCount"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}
		
		return list;
	}

	public ReplyDTO readReply(long replyNum) {
		ReplyDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT replyNum, num, r.userId, userName, content, r.reg_date "
					+ "  FROM sbbsReply r "
					+ "  JOIN member1 m ON r.userId=m.userId  "
					+ "  WHERE replyNum = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, replyNum);

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new ReplyDTO();
				
				dto.setReplyNum(rs.getLong("replyNum"));
				dto.setNum(rs.getLong("num"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
				
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}
		
		return dto;
	}
	
	// 게시물의 댓글 삭제
	public void deleteReply(long replyNum, String userId) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		if(! userId.equals("admin")) {
			ReplyDTO dto = readReply(replyNum);
			if(dto == null || (! userId.equals(dto.getUserId()))) {
				return;
			}
		}
		
		try {
			sql = "DELETE FROM sbbsReply "
					+ "  WHERE replyNum IN  "
					+ "  (SELECT replyNum FROM sbbsReply START WITH replyNum = ?"
					+ "     CONNECT BY PRIOR replyNum = answer)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, replyNum);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}		
		
	}

	// 댓글의 답글 리스트
	public List<ReplyDTO> listReplyAnswer(long answer) {
		List<ReplyDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT replyNum, num, r.userId, userName, content, reg_date, answer "
					+ " FROM sbbsReply r "
					+ " JOIN member1 m ON r.userId=m.userId "
					+ " WHERE answer=? "
					+ " ORDER BY replyNum DESC ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, answer);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReplyDTO dto = new ReplyDTO();
				
				dto.setReplyNum(rs.getLong("replyNum"));
				dto.setNum(rs.getLong("num"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setAnswer(rs.getLong("answer"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
				
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}
		return list;
	}
	
	// 댓글의 답글 개수
	public int dataCountReplyAnswer(long answer) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM sbbsReply WHERE answer=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, answer);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}
		
		return result;
	}
}
