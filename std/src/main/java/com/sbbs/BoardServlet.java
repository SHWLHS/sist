package com.sbbs;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.member.SessionInfo;
import com.util.FileManager;
import com.util.MyUploadServlet;
import com.util.MyUtil;

@MultipartConfig
@WebServlet("/sbbs/*")
public class BoardServlet extends MyUploadServlet {//파일을 올리는 기능을 같이 만들어논 클래스 상속
	private static final long serialVersionUID = 1L;

	private String pathname;
	
	
	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		
		
		//세션정보
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if (info == null) {//세션이 null이면(로그인이 안되어있으면)
			forward(req, resp, "/WEB-INF/views/member/login.jsp");//로그인창으로 이동
			return;
		}
		
		//파일을 저장할 경로
		String root = session.getServletContext().getRealPath("/");
		pathname = root + "uploads" + File.separator + "sbbs";
		
		
		//uri에 따른 작업 구분
		String uri = req.getRequestURI();
		
		if(uri.indexOf("list.do") != -1) {
			list(req, resp);
		}else if(uri.indexOf("write.do") != -1) {
			writeForm(req, resp);
		}else if(uri.indexOf("write_ok.do") != -1) {
			writeSubmit(req, resp);
		}else if(uri.indexOf("article.do") != -1) {
			article(req, resp);
		}else if(uri.indexOf("update.do") != -1) {
			updateForm(req, resp);
		}else if(uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp);
		}else if(uri.indexOf("deleteFile.do") != -1) {
			deleteFile(req, resp);
		}else if(uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		}else if(uri.indexOf("download.do") != -1) {
			download(req, resp);
		}
				
		
	}
	
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//게시글 리스트
		BoardDAO dao = new BoardDAO();
		MyUtil util = new MyUtil();
		
		String cp = req.getContextPath();
		
		try {
			//category는 어떠한 경우라도 따라다녀야함.
			String _category = req.getParameter("category");
			int category = 1;
			if(_category != null) {//실수해서 category안넘겼을때 기본으로 1로 주게끔 설정
				category = Integer.parseInt(_category);
			}
			
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			//검색
			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if(condition == null) {
				condition = "all";
				keyword = "";
			}
			
			//GET방식인 경우 디코딩
			if(req.getMethod().equalsIgnoreCase("GET")) {
				keyword = URLDecoder.decode(keyword,"utf-8");
			}
			
			//전체 데이터 개수
			int dataCount;
			if(keyword.length() == 0) {
				dataCount = dao.dataCount(category);
			}else {
				dataCount = dao.dataCount(category, condition, keyword);
			}
			
			int size = 2;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			int offset = (current_page -1)*size;
			if(offset < 0 ) offset = 0;
			
			List<BoardDTO> list = null;
			
			if(keyword.length() == 0 ) {
				list = dao.listBoard(category, offset, size);
			}else {
				list = dao.listBoard(category, offset, size, condition, keyword);
			}
			
			String query = "";
			if(keyword.length() != 0) {
				query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword,"utf-8");
			}
			
			//페이징처리
			String listUrl = cp + "/sbbs/list.do?category="+category;
			String articleUrl = cp + "/sbbs/article.do?page="+current_page+"&category="+category;
			if(query.length() != 0) {
				listUrl += "&" + query;
				articleUrl += "&" + query;
			}
			
			String paging = util.paging(current_page, total_page, listUrl);
			
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("size", size);
			req.setAttribute("total_page", total_page);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("paging", paging);
			req.setAttribute("condition", condition);
			req.setAttribute("keyword", keyword);
			
			req.setAttribute("category", category);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		forward(req, resp, "/WEB-INF/views/sbbs/list.jsp");
		
	}
	
	protected void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글쓰기 폼
		String category = req.getParameter("category");
		
		req.setAttribute("category", category);
		req.setAttribute("mode", "write");
		forward(req, resp, "/WEB-INF/views/sbbs/write.jsp");
	}
	
	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 저장 
		BoardDAO dao = new BoardDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");//위에서 null이아닌걸 다잡아줬기때문에 무조건 값이 들어있음
		
		String cp = req.getContextPath();
		String category = req.getParameter("category");
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp+"/sbbs/list.do?category="+category);//list로 리다이렉트
			return;
		}
		
		try {
			BoardDTO dto = new BoardDTO();
			
			dto.setCategory(Integer.parseInt(category));
			dto.setUserId(info.getUserId()); //로그인한 유저
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			
			//파일 받기
			Part p = req.getPart("selectFile");
			Map<String, String> map = doFileUpload(p, pathname);
			if(map != null) {
				String saveFilename = map.get("saveFilename");
				String orginalFilename = map.get("originalFilename");
				long fileSize = p.getSize();
				
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(orginalFilename);
				dto.setFileSize(fileSize);
			}
			
			
			dao.insertBoard(dto);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
			resp.sendRedirect(cp + "/sbbs/list.do?category="+category);
		
	}
	
	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글 보기
			BoardDAO dao = new BoardDAO();
			MyUtil util = new MyUtil();
			
			String cp = req.getContextPath();
			
			String category = req.getParameter("category");//숫자로 변환할 필요없음(연산에 쓰일 일이 없음)
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
				dto.setContent(util.htmlSymbols(dto.getContent()));

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

				// 포워딩
				forward(req, resp, "/WEB-INF/views/sbbs/article.jsp");
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}

			resp.sendRedirect(cp + "/sbbs/list.do?" + query);
		
		
	}
	
	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글수정 폼
		BoardDAO dao = new BoardDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String cp = req.getContextPath();
		
		String category = req.getParameter("category");
		String page = req.getParameter("page");
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			
			BoardDTO dto = dao.readBoard(num);
			
			if(dto == null || (! dto.getUserId().equals(info.getUserId()))) {
				resp.sendRedirect(cp+"/sbbs/list.do?category="+category+"&page="+page);
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
		resp.sendRedirect(cp+"/sbbs/list.do?category="+category+"&page="+page);
		
		
		
		
		
	}
	
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	      // 글 수정 완료
	      //넘어오는 파라미터 : 게시물번호, 제목, 내용, 새로운 파일, 기존 saveFilename, originalFilename, fileSize, page
	      BoardDAO dao=new BoardDAO();
	      
	      HttpSession session=req.getSession();
	      SessionInfo info=(SessionInfo)session.getAttribute("member");
	      
	      String cp=req.getContextPath();
	      String category=req.getParameter("category");
	     
	      if(req.getMethod().equalsIgnoreCase("GET")) {
	         resp.sendRedirect(cp+"/sbbs/list.do?category="+category);
	         return;
	      }
	      
	      String page=req.getParameter("page");
	      
	      try {
	         BoardDTO dto=new BoardDTO();
	         
	         dto.setNum(Long.parseLong(req.getParameter("num")));
	         dto.setSubject(req.getParameter("subject"));
	         dto.setContent(req.getParameter("content"));
	         //새로운파일을 안올렸으면 기존파일 그대로 수정(안해주면 수정하면서 기존파일 없어짐)
	         dto.setSaveFilename(req.getParameter("saveFilename"));
	         dto.setOriginalFilename(req.getParameter("originalFilename"));
	         dto.setFileSize(Long.parseLong(req.getParameter("fileSize")));//파일이 없으면 사이즈0으로 넘어옴
	         
	         dto.setUserId(info.getUserId());
	         
	         Part p = req.getPart("selectFile");
	         Map<String, String> map = doFileUpload(p, pathname);
	         if(map != null) {//새로운파일이 올라왔으면
	        	 if(req.getParameter("saveFilename").length() != 0) {
	        		 //기존파일 삭제
	        		 FileManager.doFiledelete(pathname, req.getParameter("saveFilename"));
	        	 }
	        	 //새로운 파일
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
	      resp.sendRedirect(cp+"/sbbs/list.do?category="+category+"&page="+page);
	      
	}
	
	protected void deleteFile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//수정에서 파일 삭제
		
		BoardDAO dao = new BoardDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String cp = req.getContextPath();
		
		String category = req.getParameter("category");
		String page = req.getParameter("page");
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			
			BoardDTO dto = dao.readBoard(num);
			
			if(dto == null || (! dto.getUserId().equals(info.getUserId()))) {
				resp.sendRedirect(cp+"/sbbs/list.do?category="+category+"&page="+page);
				return;
			}
			
			//파일 삭제
			FileManager.doFiledelete(pathname,dto.getSaveFilename());
			
			//테이블에서 파일 정보 변경
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
		resp.sendRedirect(cp+"/sbbs/list.do?category="+category+"&page="+page);
		
		
		
		
		
		
		
	}
	
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//게시글 삭제
		//게시물번호, 카테고리, 페이지번호 [,검색컬럼,검색값]
		
		BoardDAO dao = new BoardDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
				
		String cp = req.getContextPath();
		
		String category = req.getParameter("category");
		String page = req.getParameter("page");
		String query = "category="+category+"&page="+page;
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if(condition == null) {
				condition = "all";
				keyword = "";
			}
			keyword = URLDecoder.decode(keyword,"utf-8");
			
			if(keyword.length() != 0) {
				query += "&condition=" + condition +"&keyword="+URLEncoder.encode(keyword,"utf-8");
			}
			
			BoardDTO dto = dao.readBoard(num);
			if(dto == null) {//게시물이 없으면 삭제안됨, list로 리다이렉트
				resp.sendRedirect(cp+"/sbbs/list.do?"+query);
				return;
			}
			
			//게시글 작성자 및 admin 만 삭제 가능
			if(! info.getUserId().equals(dto.getUserId()) && ! info.getUserId().equals("admin")) {
				resp.sendRedirect(cp+"/sbbs/list.do?"+query);
				return;
			}
			
			//첨부파일이 있으면 삭제
			if(dto.getSaveFilename() != null && dto.getSaveFilename().length() != 0) {
				FileManager.doFiledelete(pathname,dto.getSaveFilename());
			}
			
			dao.deleteBoard(num, info.getUserId());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp+"/sbbs/list.do?"+query);
		
		
		
	}
	
	protected void download(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//파일 다운로드
		
		
	}
	
	
	protected void insertLikeBoard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//게시글 좋아요
		
		
	}
	
	protected void insertReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//댓글 추가
		
		
	}
	
	protected void deleteReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//댓글 삭제
		
		
	}

	
	protected void insertReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//댓글의 답글 추가
		
		
	}
	
	protected void listReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//댓글의 답글 리스트
		
		
	}
	
	protected void deleteReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//댓글의 답글 삭제
		
		
	}
	
	protected void countReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//댓글의 답글 개수
		
		
	}
	
	

}
