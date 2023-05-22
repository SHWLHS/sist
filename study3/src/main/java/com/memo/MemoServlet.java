package com.memo;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.util.FileManager;
import com.util.MyUtil;

/*
 	-@MultipartConfig 
 	 : 서블릿 3.0 에서 파일 업로드를 지원하는 애노테이션
 	 : @MultipartConfig를 사용한 경우
 	 	enctype="multipart/form-data" 로 넘어온 일반 파라미터를 
 	 	req.getParameter("이름") 으로 받을 수 있다.
 	 : 하나의 파라미터당 하나의 Part 객체가 생성된다.
 	 : 모든 Part 반환
 	 	Collection<Part> part = req.getParts();
*/
@WebServlet("/memo/*")
@MultipartConfig
public class MemoServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private String pathname;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		execute(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		execute(req, resp);
	}
	
	protected void forward(HttpServletRequest req, HttpServletResponse resp, String path) throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher(path);
		rd.forward(req, resp);
	}
	
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		//파일저장경로 설정?
		HttpSession session = req.getSession();
		String root = session.getServletContext().getRealPath("/");//루트경로의 실제 서버컴퓨터 위치
		
		pathname = root + "uploads" + File.separator + "memo";
		
		File f = new File(pathname);
		
		if(! f.exists()) {//폴더가 없으면 
			f.mkdirs();//모든 폴더 만들기
		}
		
		String uri = req.getRequestURI();//uri는 클라이언트가 들어온 주소
		
		//클라이언트가 들어온 주소로 구분해서 메소드 연결
		if(uri.indexOf("list.do") != -1 ) {//주소속에 list.do가 있으면
			list(req, resp);//리스트함수로 이동
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
		}else if(uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		}else if(uri.indexOf("download.do") != -1) {
			download(req,resp);
		}
		
	}
		
	
	
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemoDAO dao = new MemoDAO();
		MyUtil util = new MyUtil();
		
		String cp = req.getContextPath();
		
		try {
			//페이지 번호
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null) {
				current_page = Integer.parseInt(page);
			}
			
			//전체 데이터 개수
			int dataCount = dao.dataCount();
			
			int size = 5;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			int offset = (current_page -1)*size;
			if(offset < 0) offset = 0;
			
			List<MemoDTO> list = dao.listMemo(offset, size);
			
			//페이징처리
			String listUrl = cp + "/memo/list.do";
			String articleUrl = cp + "/memo/article.do?page="+current_page;
			
			String paging = util.paging(current_page, total_page, listUrl);
			
			//포워딩에 전달할 속성
			req.setAttribute("list",list);
			req.setAttribute("page", current_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("size", size);
			req.setAttribute("total_page", total_page);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("paging", paging);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		forward(req, resp, "/WEB-INF/views/memo/list.jsp");		
		
		
		
	}
	
	
	protected void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setAttribute("mode", "write");
		forward(req, resp, "/WEB-INF/views/memo/write.jsp");
	}
	
	
	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemoDAO dao = new MemoDAO();
		String cp = req.getContextPath();
		
		if(! req.getMethod().equalsIgnoreCase("POST")) {//POST방식이 아니면 
			resp.sendRedirect(cp+"/memo/list.do");//list로 리다이렉트
			return;
		}
		
		try {
			MemoDTO dto = new MemoDTO();
			
			//내용받기
			dto.setContent(req.getParameter("content"));

			//파일받기
			Part p = req.getPart("selectFile");
			
			String originalFilename = getOriginalFilename(p);
			String saveFilename = null;
			if(originalFilename != null && originalFilename.length() != 0) {//첨부파일이 존재하면
				
				//클라이언트가 올린 파일의 확장자
				String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
				
				//서버에 저장할 파일 이름
				//일반적으로 클라이언트가 올린 파일 이름으로 서버에 저장하지 않고 다른이름으로 저장한다.
				saveFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
												//%tY%tm%td%tH%tM%tS 년월일시분초 , 형식은 여러개인데 값은 하나일때 1$ 붙히기
				saveFilename += System.nanoTime();
				saveFilename += fileExt;
				
				//서버에 파일 저장하기
				String path = pathname + File.separator + saveFilename;
				p.write(path);
				
				dto.setOriginalFilename(originalFilename);
				dto.setSaveFilename(saveFilename);
			}
			
			dao.insertMemo(dto);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/memo/list.do");
		
	}
	
	
	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemoDAO dao = new MemoDAO();
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			
			MemoDTO dto = dao.readMemo(num);
			if(dto == null) {
				resp.sendRedirect(cp + "/memo/list.do?page="+page);
				return;
			}
			
			//글내용 엔터를 <br>로
			dto.setContent(dto.getContent().replaceAll("\n","<br>"));
			
			//포워딩 할 JSP에 넘겨줄 속성
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			
			forward(req, resp, "/WEB-INF/views/memo/article.jsp");
			
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp + "/bbs/list.do?page="+page);
		
	}
	
	
	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemoDAO dao = new MemoDAO();
		String cp = req.getContextPath();
		String page = req.getParameter("page");
		
		try { 
			long num = Long.parseLong(req.getParameter("num"));
			
			MemoDTO dto = dao.readMemo(num);
			if(dto == null) {
				resp.sendRedirect(cp + "/memo/list.do?page="+page);
				return;
			}
			
			req.setAttribute("mode", "update");
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			
			forward(req, resp, "/WEB-INF/views/memo/write.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/memo/list.do?page="+page);
	}
	
	
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemoDAO dao = new MemoDAO();
		String cp = req.getContextPath();
		String page = req.getParameter("page");
		
		try {
			MemoDTO dto = new MemoDTO();
			
			dto.setContent(req.getParameter("content"));
			dto.setNum(Long.parseLong(req.getParameter("num")));
			dto.setSaveFilename(req.getParameter("saveFilename"));
			dto.setOriginalFilename(req.getParameter("originalFilename"));
			
			//파일을 다시 업로드 한 경우
			Part p = req.getPart("selectFile");
			
			String originalFilename = getOriginalFilename(p);
			String saveFilename = null;
			if(originalFilename != null && originalFilename.length() != 0) {//첨부파일이 존재하면
				
				//기존에 업로드 된 파일 지우기(기존꺼 지우고 다른파일 재업로드)
				if(dto.getSaveFilename().length() != 0) {
					String s = pathname + File.separator + dto.getSaveFilename();
					FileManager.doFileDelete(s);//static이라 바로호출가능
				}
				
				//클라이언트가 올린 파일의 확장자
				String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
				
				//서버에 저장할 파일 이름
				//일반적으로 클라이언트가 올린 파일 이름으로 서버에 저장하지 않고 다른이름으로 저장한다.
				saveFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
												//%tY%tm%td%tH%tM%tS 년월일시분초 , 형식은 여러개인데 값은 하나일때 1$ 붙히기
				saveFilename += System.nanoTime();
				saveFilename += fileExt;
				
				//서버에 파일 저장하기
				String path = pathname + File.separator + saveFilename;
				p.write(path);
				
				dto.setOriginalFilename(originalFilename);
				dto.setSaveFilename(saveFilename);
			}
			
			dao.updateMemo(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp+ "/memo/list.do?page="+ page);
		
		
		
	}
	
	
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemoDAO dao = new MemoDAO();
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			MemoDTO dto = dao.readMemo(num);
			
			if(dto.getSaveFilename()!= null && dto.getSaveFilename().length() != 0) {//첨부파일이 있으면
				//첨부된 파일 삭제
				String s = pathname + File.separator + dto.getSaveFilename();//첨부파일 경로
				FileManager.doFileDelete(s);
			}

			//게시글 지우기
			dao.deleteMemo(num);
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp+"/memo/list.do?page="+page);
		
	}
	
	
	protected void download(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemoDAO dao = new MemoDAO();
		boolean b = false;
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			MemoDTO dto = dao.readMemo(num);
			
			if(dto != null) {//다운로드를 100% 할수있다고 보장받지 못함
				
				b = FileManager.doFileDownload(dto.getSaveFilename(), dto.getOriginalFilename(), pathname, resp);
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if( ! b) {//다운로드에 실패하면(b가 false이면)
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>alert('파일 다운로드가 실패했습니다.');history.back();</script>");// history.back() : 뒤로가기
		}

	
	}
	
	
	
	

	//클라이언트가 올린 파일 이름
	private String getOriginalFilename(Part p) {
		String[]ss = p.getHeader("content-disposition").split(";");//getHeader로 가져와서 대소문자 구분안함
		for(String s : ss) {
			if(s.trim().startsWith("filename")) {
				return s.substring(s.indexOf("=")+1).trim().replace("\"", "");
			}
		}
		
		
		return null;
	}
	
	
	

}
