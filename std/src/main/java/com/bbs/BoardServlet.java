package com.bbs;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.member.SessionInfo;
import com.util.MyServlet;
import com.util.MyUtil;

@WebServlet("/bbs/*")
public class BoardServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		String uri = req.getRequestURI();

		// 세션 정보
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		//헤더 정보
		String ajax = req.getHeader("AJAX");
		
		
		
		if ( ajax != null && info == null) {
			//AJAX로 요청해서 로그인이 안된 경우 403 이라는 에러코드를 던짐
			resp.sendError(403);
			return;
		}else if( info == null) {
			//AJAX로 요청하지 않고 로그인 되지 않은 상태
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}

		// uri에 따른 작업 구분
		if (uri.indexOf("list.do") != -1) {
			list(req, resp);
		} else if (uri.indexOf("write.do") != -1) {
			writeForm(req, resp);
		} else if (uri.indexOf("write_ok.do") != -1) {
			writeSubmit(req, resp);
		} else if (uri.indexOf("article.do") != -1) {
			article(req, resp);
		} else if (uri.indexOf("update.do") != -1) {
			updateForm(req, resp);
		} else if (uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp);
		} else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		} else if (uri.indexOf("insertBoardLike.do") != -1) {
			//게시글 공감
			insertBoardLike(req, resp);
		} else if (uri.indexOf("insertReply.do") != -1) {
			//댓글 등록
			insertReply(req, resp);
		} else if (uri.indexOf("listReply.do") != -1) {
			//댓글 리스트
			listReply(req, resp);
		} else if (uri.indexOf("deleteReply.do") != -1) {
			//댓글 삭제
			deleteReply(req, resp);
		} else if (uri.indexOf("insertReplyLike.do") != -1) {
			//댓글 좋아요/싫어요 등록
			insertReplyLike(req, resp);
		} else if (uri.indexOf("countReplyLike.do") != -1) {
			//댓글 좋아요/싫어요 개수
			countReplyLike(req, resp);
		} else if (uri.indexOf("insertReplyAnswer.do") != -1) {
			//댓글의 답글 등록
			insertReplyAnswer(req, resp);
		} else if (uri.indexOf("listReplyAnswer.do") != -1) {
			//댓글의 답글 삭제 리스트
			listReplyAnswer(req, resp);
		} else if (uri.indexOf("deleteReplyAnswer.do") != -1) {
			//댓글의 답글 삭제
			deleteReplyAnswer(req, resp);
		} else if (uri.indexOf("countReplyAnswer.do") != -1) {
			//댓글의 답글 개수
			countReplyAnswer(req, resp);
		}
	}

	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시물 리스트
		BoardDAO dao = new BoardDAO();
		MyUtil util = new MyUtil();

		String cp = req.getContextPath();
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null) {
				current_page = Integer.parseInt(page);
			}
			
			// 검색
			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if (condition == null) {
				condition = "all";
				keyword = "";
			}

			// GET 방식인 경우 디코딩
			if (req.getMethod().equalsIgnoreCase("GET")) {
				keyword = URLDecoder.decode(keyword, "utf-8");
			}

			// 전체 데이터 개수
			int dataCount;
			if (keyword.length() == 0) {
				dataCount = dao.dataCount();
			} else {
				dataCount = dao.dataCount(condition, keyword);
			}
			
			// 전체 페이지 수
			int size = 10;
			int total_page = util.pageCount(dataCount, size);
			if (current_page > total_page) {
				current_page = total_page;
			}

			// 게시물 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<BoardDTO> list = null;
			if (keyword.length() == 0) {
				list = dao.listBoard(offset, size);
			} else {
				list = dao.listBoard(offset, size, condition, keyword);
			}

			String query = "";
			if (keyword.length() != 0) {
				query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
			}

			// 페이징 처리
			String listUrl = cp + "/bbs/list.do";
			String articleUrl = cp + "/bbs/article.do?page=" + current_page;
			if (query.length() != 0) {
				listUrl += "?" + query;
				articleUrl += "&" + query;
			}

			String paging = util.paging(current_page, total_page, listUrl);

			// 포워딩할 JSP에 전달할 속성
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("size", size);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("paging", paging);
			req.setAttribute("condition", condition);
			req.setAttribute("keyword", keyword);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		// JSP로 포워딩
		forward(req, resp, "/WEB-INF/views/bbs/list.jsp");
	}

	protected void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글쓰기 폼
		req.setAttribute("mode", "write");
		forward(req, resp, "/WEB-INF/views/bbs/write.jsp");
	}

	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글 저장
		BoardDAO dao = new BoardDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String cp = req.getContextPath();
		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/bbs/list.do");
			return;
		}
		
		try {
			BoardDTO dto = new BoardDTO();

			// userId는 세션에 저장된 정보
			dto.setUserId(info.getUserId());

			// 파라미터
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));

			dao.insertBoard(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/bbs/list.do");
	}

	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글보기
		BoardDAO dao = new BoardDAO();
		MyUtil util = new MyUtil();
		
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		String query = "page=" + page;

		try {
			long num = Long.parseLong(req.getParameter("num"));
			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if (condition == null) {
				condition = "all";
				keyword = "";
			}
			keyword = URLDecoder.decode(keyword, "utf-8");

			if (keyword.length() != 0) {
				query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
			}

			// 조회수 증가
			dao.updateHitCount(num);

			// 게시물 가져오기
			BoardDTO dto = dao.readBoard(num);
			if (dto == null) { // 게시물이 없으면 다시 리스트로
				resp.sendRedirect(cp + "/bbs/list.do?" + query);
				return;
			}
			dto.setContent(util.htmlSymbols(dto.getContent()));
			
			//로그인 유저의 게시글 공감 여부(좋아요)
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			boolean isUserLike = dao.isUserBoardLike(num, info.getUserId());
			
			
			// 이전글 다음글
			BoardDTO preReadDto = dao.preReadBoard(dto.getNum(), condition, keyword);
			BoardDTO nextReadDto = dao.nextReadBoard(dto.getNum(), condition, keyword);

			// JSP로 전달할 속성
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);
			req.setAttribute("preReadDto", preReadDto);
			req.setAttribute("nextReadDto", nextReadDto);
			
			req.setAttribute("isUserLike", isUserLike);

			// 포워딩
			forward(req, resp, "/WEB-INF/views/bbs/article.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/bbs/list.do?" + query);
	}

	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수정 폼
		BoardDAO dao = new BoardDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String cp = req.getContextPath();

		String page = req.getParameter("page");

		try {
			long num = Long.parseLong(req.getParameter("num"));
			BoardDTO dto = dao.readBoard(num);

			if (dto == null) {
				resp.sendRedirect(cp + "/bbs/list.do?page=" + page);
				return;
			}

			// 게시물을 올린 사용자가 아니면
			if (! dto.getUserId().equals(info.getUserId())) {
				resp.sendRedirect(cp + "/bbs/list.do?page=" + page);
				return;
			}

			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("mode", "update");

			forward(req, resp, "/WEB-INF/views/bbs/write.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/bbs/list.do?page=" + page);
	}

	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수정 완료
		BoardDAO dao = new BoardDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String cp = req.getContextPath();
		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/bbs/list.do");
			return;
		}

		String page = req.getParameter("page");
		try {
			BoardDTO dto = new BoardDTO();
			
			dto.setNum(Long.parseLong(req.getParameter("num")));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));

			dto.setUserId(info.getUserId());

			dao.updateBoard(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/bbs/list.do?page=" + page);
	}

	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 삭제
		BoardDAO dao = new BoardDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		String query = "page=" + page;

		try {
			long num = Long.parseLong(req.getParameter("num"));
			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if (condition == null) {
				condition = "all";
				keyword = "";
			}
			keyword = URLDecoder.decode(keyword, "utf-8");

			if (keyword.length() != 0) {
				query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
			}

			dao.deleteBoard(num, info.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/bbs/list.do?" + query);
	}
	
	
	
	protected void insertBoardLike(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//게시글 공감 저장: AJAX-JSON
		BoardDAO dao = new BoardDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String state = "false";
		int boardLikeCount = 0;
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			String isNoLike = req.getParameter("isNoLike");
			
			if(isNoLike.equals("true")){
				dao.insertBoardLike(num, info.getUserId());//공감
			} else {
				dao.deleteBoardLike(num, info.getUserId());//공감 취소
			}
			
			//공감개수
			boardLikeCount = dao.countBoardLike(num);
			
			state = "true";
			
		} catch (SQLException e) {
			state = "liked";
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		JSONObject job = new JSONObject();
		job.put("state", state);
		job.put("boardLikeCount", boardLikeCount);
		
		resp.setContentType("text/html;charset=utf-8");//설정 안하면 한글 깨짐
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
		
	}
	
	protected void insertReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//게시글 댓글/답글 저장 : AJAX-JSON
		BoardDAO dao = new BoardDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String state = "false";
		
		try {
			ReplyDTO dto = new ReplyDTO();
			
			long num = Long.parseLong(req.getParameter("num"));
			dto.setNum(num);
			dto.setUserId(info.getUserId());
			dto.setContent(req.getParameter("content"));
			String answer = req.getParameter("answer");
			if(answer != null) {//answer가 넘어오지 않았으면 
				dto.setAnswer(Long.parseLong(answer));
			}
			
			dao.insertReply(dto);
			
			state = "true";
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		JSONObject job = new JSONObject();
		job.put("state", state);
		
		resp.setContentType("text/html;charset=utf-8");//설정 안하면 한글 깨짐
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
		
		
	}
	
	protected void listReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//게시글 댓글 리스트 : AJAX-Text
		BoardDAO dao = new BoardDAO();
		MyUtil util = new MyUtil();
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			String pageNo = req.getParameter("pageNo");
			int current_page = 1;
			
			if(pageNo != null) {
				current_page = Integer.parseInt(pageNo);
			}
			
			int size = 5;
			int total_page = 0;
			int replyCount = 0;
			
			replyCount = dao.dataCountReply(num);
			total_page = util.pageCount(replyCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			int offset = (current_page - 1)*size;
			if(offset < 0) offset = 0;
			
			
			List<ReplyDTO> listReply = dao.listReply(num, offset, size);
			
			for(ReplyDTO dto : listReply) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}
			
			//"listPage" 자바스크립트 함수이름 
			String paging = util.pagingMethod(current_page, total_page, "listPage");
			
			req.setAttribute("listReply", listReply);
			req.setAttribute("pageNo",current_page);
			req.setAttribute("replyCount",replyCount);
			req.setAttribute("total_page",total_page);
			req.setAttribute("paging",paging);
			
			//ajax는 forward하면 listReply.jsp에는 html태그 쓰면 안된다.
			forward(req, resp, "/WEB-INF/views/bbs/listReply.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendError(400);//문제가 있으면 400에러 던짐
	}
	
	protected void deleteReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//게시글 댓글 삭제 : AJAX-Text
		BoardDAO dao = new BoardDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "false";
		
		try {
			long replyNum = Long.parseLong(req.getParameter("replyNum"));
			dao.deleteReply(replyNum, info.getUserId());
			
			state = "true";
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		JSONObject job = new JSONObject();
		job.put("state", state);
		
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
	}
	
	protected void insertReplyLike(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//게시글 댓글 좋아요/싫어요 추가 : AJAX-JSON
		
	}
	
	protected void countReplyLike(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//게시글 댓글 좋아요/싫어요 개수 : AJAX-JSON
		
	}
	
	protected void insertReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//게시글 댓글의 답글 추가 : AJAX-JSON
		//insertReply(req,resp)에서 처리함
		
	}
	
	protected void listReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//게시글 댓글의 답글 리스트 : AJAX-Text
		BoardDAO dao = new BoardDAO();
		
		try {//answer: 해당되는 아버지 번호
			long answer = Long.parseLong(req.getParameter("answer"));
			
			List<ReplyDTO> listReplyAnswer = dao.listReplyAnswer(answer);
			
			for(ReplyDTO dto : listReplyAnswer) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}
			
			req.setAttribute("listReplyAnswer", listReplyAnswer);
			
			forward(req, resp, "/WEB-INF/views/bbs/listReplyAnswer.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendError(400);
	}
	
	protected void deleteReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//게시글 댓글의 답글 삭제 : AJAX-JSON
		
		
	}
	
	protected void countReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//게시글 댓글의 답글 개수 : AJAX-JSON
		BoardDAO dao = new BoardDAO();
		int count = 0;
		
		try {
			long answer = Long.parseLong(req.getParameter("answer"));
			count = dao.dataCountReplyAnswer(answer);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		JSONObject job = new JSONObject();
		job.put("count", count);
		
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
		
	}
	
	
	
	
	
	
}
