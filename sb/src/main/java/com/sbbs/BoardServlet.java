package com.sbbs;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.json.JSONObject;

import com.member.SessionInfo;
import com.util.FileManager;
import com.util.MyUploadServlet;
import com.util.MyUtil;
import com.util.MyUtilBootstrap;

@MultipartConfig
@WebServlet("/sbbs/*")
public class BoardServlet extends MyUploadServlet {
	private static final long serialVersionUID = 1L;
	private String pathname;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		String uri = req.getRequestURI();
		
		// 세션 정보
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		// 해더 정보
		String ajax = req.getHeader("AJAX");

		if(ajax != null && info == null) {
			resp.sendError(403);
			return;
		} else if (info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}

		// 파일을 저장할 경로(pathname)
		String root = session.getServletContext().getRealPath("/");
		pathname = root + "uploads" + File.separator + "sbbs";
		
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
		} else if (uri.indexOf("deleteFile.do") != -1) {
			deleteFile(req, resp);
		} else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		} else if (uri.indexOf("download.do") != -1) {
			download(req, resp);
		} else if (uri.indexOf("insertBoardLike.do") != -1) {
			// 게시물 공감 저장
			insertBoardLike(req, resp);
		} else if (uri.indexOf("insertReply.do") != -1) {
			// 댓글 추가
			insertReply(req, resp);
		} else if (uri.indexOf("listReply.do") != -1) {
			// 댓글 리스트
			listReply(req, resp);
		} else if (uri.indexOf("deleteReply.do") != -1) {
			// 댓글 삭제
			deleteReply(req, resp);
		} else if (uri.indexOf("insertReplyAnswer.do") != -1) {
			// 댓글의 답글 추가
			insertReplyAnswer(req, resp);
		} else if (uri.indexOf("listReplyAnswer.do") != -1) {
			// 댓글의 답글 리스트
			listReplyAnswer(req, resp);
		} else if (uri.indexOf("deleteReplyAnswer.do") != -1) {
			// 댓글의 답글 삭제
			deleteReplyAnswer(req, resp);
		} else if (uri.indexOf("countReplyAnswer.do") != -1) {
			// 댓글의 답글 개수
			countReplyAnswer(req, resp);
		}
	}

	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BoardDAO dao = new BoardDAO();
		MyUtil util = new MyUtilBootstrap();

		// 게시물 리스트
		String cp = req.getContextPath();
		
		try {
			String gubun = req.getParameter("category");
			int category = 1;
			if(gubun != null) {
				category = Integer.parseInt(gubun);
			}
			
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null)
				current_page = Integer.parseInt(page);

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
				dataCount = dao.dataCount(category);
			} else {
				dataCount = dao.dataCount(category, condition, keyword);
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
				list = dao.listBoard(category, offset, size);
			} else {
				list = dao.listBoard(category, offset, size, condition, keyword);
			}

			String query = "";
			if (keyword.length() != 0) {
				query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
			}

			// 페이징 처리
			String listUrl = cp + "/sbbs/list.do?category=" + category;
			String articleUrl = cp + "/sbbs/article.do?category=" + category + "&page=" + current_page;
			if (query.length() != 0) {
				listUrl += "&" + query;
				articleUrl += "&" + query;
			}

			String paging = util.paging(current_page, total_page, listUrl);

			// 포워딩할 JSP로 넘길 속성
			req.setAttribute("list", list);
			req.setAttribute("category", category);
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
		forward(req, resp, "/WEB-INF/views/sbbs/list.jsp");
	}

	protected void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글쓰기 폼
		String category = req.getParameter("category");
		
		req.setAttribute("category", category);
		req.setAttribute("mode", "write");
		forward(req, resp, "/WEB-INF/views/sbbs/write.jsp");
	}

	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글 저장
		BoardDAO dao = new BoardDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String cp = req.getContextPath();
		String category = req.getParameter("category");
		
		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/sbbs/list.do?category=" + category);
			return;
		}
		
		try {
			BoardDTO dto = new BoardDTO();

			// userId는 세션에 저장된 정보
			dto.setUserId(info.getUserId());

			// 파라미터
			dto.setCategory(Integer.parseInt(category));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));

			Part p = req.getPart("selectFile");
			Map<String, String> map = doFileUpload(p, pathname);
			if (map != null) {
				String saveFilename = map.get("saveFilename");
				String originalFilename = map.get("originalFilename");
				long size = p.getSize();
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(originalFilename);
				dto.setFileSize(size);
			}

			dao.insertBoard(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/sbbs/list.do?category=" + category);
	}

	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글보기
		BoardDAO dao = new BoardDAO();
		// MyUtil util = new MyUtilBootstrap();
		
		String cp = req.getContextPath();
		
		String category = req.getParameter("category");
		String page = req.getParameter("page");
		String query = "category=" + category + "&page=" + page;

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
				resp.sendRedirect(cp + "/sbbs/list.do?" + query);
				return;
			}
			// dto.setContent(util.htmlSymbols(dto.getContent()));

			// 로그인 유저의 게시글 공감 여부
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			boolean isUserLike = dao.isUserBoardLike(num, info.getUserId());
			
			// 이전글 다음글
			int nCategory = Integer.parseInt(category);
			BoardDTO preReadDto = dao.preReadBoard(nCategory, dto.getNum(), condition, keyword);
			BoardDTO nextReadDto = dao.nextReadBoard(nCategory, dto.getNum(), condition, keyword);
			
			// JSP로 전달할 속성
			req.setAttribute("category", category);
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);
			req.setAttribute("preReadDto", preReadDto);
			req.setAttribute("nextReadDto", nextReadDto);
			
			req.setAttribute("isUserLike", isUserLike);

			// 포워딩
			forward(req, resp, "/WEB-INF/views/sbbs/article.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/sbbs/list.do?" + query);
	}

	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수정 폼
		BoardDAO dao = new BoardDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String cp = req.getContextPath();

		String category = req.getParameter("category");
		String page = req.getParameter("page");

		try {
			long num = Long.parseLong(req.getParameter("num"));
			BoardDTO dto = dao.readBoard(num);

			if (dto == null) {
				resp.sendRedirect(cp + "/sbbs/list.do?category=" + category + "&page=" + page);
				return;
			}

			// 게시물을 올린 사용자가 아니면
			if (!dto.getUserId().equals(info.getUserId())) {
				resp.sendRedirect(cp + "/sbbs/list.do?category=" + category + "&page=" + page);
				return;
			}

			req.setAttribute("category", category);
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("mode", "update");

			forward(req, resp, "/WEB-INF/views/sbbs/write.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/sbbs/list.do?category=" + category + "&page=" + page);
	}

	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수정 완료
		BoardDAO dao = new BoardDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String cp = req.getContextPath();
		String category = req.getParameter("category");
		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/sbbs/list.do?category=" + category);
			return;
		}
		
		String page = req.getParameter("page");

		try {
			BoardDTO dto = new BoardDTO();
			dto.setNum(Long.parseLong(req.getParameter("num")));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setSaveFilename(req.getParameter("saveFilename"));
			dto.setOriginalFilename(req.getParameter("originalFilename"));
			dto.setFileSize(Long.parseLong(req.getParameter("fileSize")));

			dto.setUserId(info.getUserId());

			Part p = req.getPart("selectFile");
			Map<String, String> map = doFileUpload(p, pathname);
			if (map != null) {
				if (req.getParameter("saveFilename").length() != 0) {
					// 기존파일 삭제
					FileManager.doFiledelete(pathname, req.getParameter("saveFilename"));
				}

				// 새로운 파일
				String saveFilename = map.get("saveFilename");
				String originalFilename = map.get("originalFilename");
				long size = p.getSize();
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(originalFilename);
				dto.setFileSize(size);
			}

			dao.updateBoard(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/sbbs/list.do?category=" + category + "&page=" + page);
	}

	protected void deleteFile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수정에서 파일만 삭제
		BoardDAO dao = new BoardDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String cp = req.getContextPath();

		String category = req.getParameter("category");
		String page = req.getParameter("page");

		try {
			long num = Long.parseLong(req.getParameter("num"));
			BoardDTO dto = dao.readBoard(num);
			if (dto == null) {
				resp.sendRedirect(cp + "/sbbs/list.do?category=" + category + "&page=" + page);
				return;
			}

			if (!info.getUserId().equals(dto.getUserId())) {
				resp.sendRedirect(cp + "/sbbs/list.do?category=" + category + "&page=" + page);
				return;
			}

			// 파일삭제
			FileManager.doFiledelete(pathname, dto.getSaveFilename());

			// 파일명과 파일크기 변경
			dto.setOriginalFilename("");
			dto.setSaveFilename("");
			dto.setFileSize(0);
			dao.updateBoard(dto);

			req.setAttribute("category", category);
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);

			req.setAttribute("mode", "update");

			forward(req, resp, "/WEB-INF/views/sbbs/write.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/sbbs/list.do?category=" + category +"&page=" + page);
	}

	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 삭제
		BoardDAO dao = new BoardDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String cp = req.getContextPath();
		
		String category = req.getParameter("category");
		String page = req.getParameter("page");
		String query = "category=" + category + "&page=" + page;

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

			BoardDTO dto = dao.readBoard(num);
			if (dto == null) {
				resp.sendRedirect(cp + "/sbbs/list.do?" + query);
				return;
			}

			// 글을 등록한 사람, admin 만 삭제 가능
			if (!info.getUserId().equals(dto.getUserId()) && !info.getUserId().equals("admin")) {
				resp.sendRedirect(cp + "/sbbs/list.do?" + query);
				return;
			}

			if (dto.getSaveFilename() != null && dto.getSaveFilename().length() != 0) {
				FileManager.doFiledelete(pathname, dto.getSaveFilename());
			}

			dao.deleteBoard(num, info.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/sbbs/list.do?" + query);
	}

	protected void download(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 파일 다운로드
		BoardDAO dao = new BoardDAO();
		boolean b = false;

		try {
			long num = Long.parseLong(req.getParameter("num"));

			BoardDTO dto = dao.readBoard(num);
			if (dto != null) {
				b = FileManager.doFiledownload(dto.getSaveFilename(), dto.getOriginalFilename(), pathname, resp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		if ( !b ) {
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>alert('파일다운로드가 실패 했습니다.');history.back();</script>");
		}
	}
	
	// 게시물 공감 저장 - AJAX:JSON
	protected void insertBoardLike(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		BoardDAO dao = new BoardDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String state = "false";
		int likeCount = 0;

		try {
			long num = Long.parseLong(req.getParameter("num"));
			String isNoLike = req.getParameter("isNoLike");
			
			if(isNoLike.equals("true")) {
				dao.insertBoardLike(num, info.getUserId()); // 공감
			} else {
				dao.deleteBoardLike(num, info.getUserId()); // 공감 취소
			}
			
			likeCount = dao.countBoardLike(num);

			state = "true";
		} catch (SQLException e) {
			state = "liked";
		} catch (Exception e) {
			e.printStackTrace();
		}

		JSONObject job = new JSONObject();
		job.put("state", state);
		job.put("likeCount", likeCount);

		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
	}
	
	// 리플 리스트 - AJAX:TEXT
	protected void listReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BoardDAO dao = new BoardDAO();
		MyUtil util = new MyUtilBootstrap();

		try {
			long num = Long.parseLong(req.getParameter("num"));
			String pageNo = req.getParameter("pageNo");
			int current_page = 1;
			if (pageNo != null) {
				current_page = Integer.parseInt(pageNo);
			}

			int size = 5;
			int total_page = 0;
			int replyCount = 0;

			replyCount = dao.dataCountReply(num);
			total_page = util.pageCount(replyCount, size);
			if (current_page > total_page) {
				current_page = total_page;
			}

			// 리스트에 출력할 데이터
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			List<ReplyDTO> listReply = dao.listReply(num, offset, size);

			// 엔터를 <br>
			for (ReplyDTO dto : listReply) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}

			// 페이징 처리 : AJAX 용 - listPage : 자바스크립트 함수명
			String paging = util.pagingMethod(current_page, total_page, "listPage");

			req.setAttribute("listReply", listReply);
			req.setAttribute("pageNo", current_page);
			req.setAttribute("replyCount", replyCount);
			req.setAttribute("total_page", total_page);
			req.setAttribute("paging", paging);
			
			forward(req, resp, "/WEB-INF/views/sbbs/listReply.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendError(400);
	}

	// 리플 또는 답글 저장 - AJAX:JSON
	protected void insertReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BoardDAO dao = new BoardDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String state = "false";
		try {
			ReplyDTO dto = new ReplyDTO();

			long num = Long.parseLong(req.getParameter("num"));
			dto.setNum(num);
			dto.setUserId(info.getUserId());
			dto.setContent(req.getParameter("content"));
			String answer = req.getParameter("answer");
			if (answer != null) {
				dto.setAnswer(Long.parseLong(answer));
			}
			
			dao.insertReply(dto);
			
			state = "true";
		} catch (Exception e) {
			e.printStackTrace();
		}

		JSONObject job = new JSONObject();
		job.put("state", state);

		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
	}

	// 리플 또는 답글 삭제 - AJAX:JSON
	protected void deleteReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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

		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
	}

	// 답글 저장 - AJAX:JSON
	protected void insertReplyAnswer(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		insertReply(req, resp);
	}

	// 리플의 답글 리스트 - AJAX:TEXT
	protected void listReplyAnswer(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		BoardDAO dao = new BoardDAO();

		try {
			long answer = Long.parseLong(req.getParameter("answer"));

			List<ReplyDTO> listReplyAnswer = dao.listReplyAnswer(answer);

			// 엔터를 <br>(스타일 => style="white-space:pre;")
			for (ReplyDTO dto : listReplyAnswer) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}

			req.setAttribute("listReplyAnswer", listReplyAnswer);

			forward(req, resp, "/WEB-INF/views/sbbs/listReplyAnswer.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendError(400);
		
	}

	// 리플 답글 삭제 - AJAX:JSON
	protected void deleteReplyAnswer(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		deleteReply(req, resp);
	}

	// 리플의 답글 개수 - AJAX:JSON
	protected void countReplyAnswer(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
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

		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
	}
	
}
