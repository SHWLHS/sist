package com.bbs;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//자바스크립트로 페이징처리

// * -> 주소가 bbs로 시작하면 다 처리하게 설정, 앞에 / 로 시작해야함
@WebServlet("/bbs/*")
public class BoardServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		execute(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		execute(req, resp);
	}
	
	protected void forward(HttpServletRequest req, HttpServletResponse resp, String path) throws ServletException, IOException {
		//포워딩
		RequestDispatcher rd = req.getRequestDispatcher(path);
		rd.forward(req, resp);
	}
	
	//get과 post 합쳐서 처리
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		//주소 : http://localhost:9090/study3/bbs/list.do?page=1
		//uri : /study3/bbs/list.do
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
		}
		
	}
	

	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//게시글 리스트 : 자바스크립트로 페이징처리
		BoardDAO dao = new BoardDAO();
		
		
		try {
			//파라미터 : [페이지번호],[검색컬럼, 검색값] -> 필요할수도있고(페이지번호클릭,검색,검색하고페이지번호클릭)필요없을수도있다(새로고침,처음페이지들어올때)
			//페이지 번호
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {//page값이 있을때 정수변환해서 현재페이지로 설정
				current_page = Integer.parseInt(page);
			}
			
			//검색
			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if(condition == null) {//검색상태가 아니면
				condition = "all"; //?????
				keyword = "";
			}
			
			//GET 방식이면 디코딩 
			if(req.getMethod().equalsIgnoreCase("GET")) {
				keyword = URLDecoder.decode(keyword, "utf-8");
			}
			
			//전체 데이터 개수
			int dataCount;
			if(keyword.length() == 0) { //검색이 아닐때
				dataCount = dao.dataCount();
			}else { //검색일때
				dataCount = dao.dataCount(condition, keyword);
			}
			
			//전체 페이지 수
			int size = 4;
			int total_page = dataCount / size + (dataCount % size > 0 ? 1:0);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			//게시글 가져오기
			int offset = (current_page -1) *size;
			if(offset <0 ) offset = 0;
			
			List<BoardDTO> list = null;
			
			if(keyword.length() == 0) {//검색이 아니면
				list = dao.listBoard(offset, size);//검색이 아닌 전체 리스트 
			}else {//검색이면
				list = dao.listBoard(offset, size, condition, keyword);//검색인 리스트
			}
			
			
			//포워딩할 JSP에 전달할 속성(attribute)
			req.setAttribute("list",list);
			req.setAttribute("page",current_page);
			req.setAttribute("dataCount",dataCount);
			req.setAttribute("size",size);
			req.setAttribute("total_page",total_page);
			req.setAttribute("condition",condition);
			req.setAttribute("keyword",keyword);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		//포워딩에서 /는 cp(study3)까지 의미한다.
		forward(req, resp, "/WEB-INF/views/bbs/list.jsp");
	}
	
	protected void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글쓰기 폼
		
		req.setAttribute("mode", "write");
		forward(req, resp, "/WEB-INF/views/bbs/write.jsp");
		
	}
	
	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글저장
		BoardDAO dao = new BoardDAO();
		String cp = req.getContextPath();//클라이언트 contextPath
		
		//get방식으로 들어오면 안되서 post방식으로 들어오게 설정
		if(! req.getMethod().equalsIgnoreCase("POST")) {//POST방식이 아니면 
			resp.sendRedirect(cp+"/bbs/list.do");//list로 리다이렉트
			return;
		}
		
		try {
			//폼데이터 : 이름, 제목, 내용, 패스워드
			//번호 - 시퀀스, 등록일-SYSDATE ,조회수-0
			//아이피주소-클라이언트아이피
			
			
			BoardDTO dto = new BoardDTO();
			
			dto.setName(req.getParameter("name"));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setPwd(req.getParameter("pwd"));
			dto.setIpAddr(req.getRemoteAddr());//클라이언트 ip
			
			dao.insertBoard(dto);
			
		} catch (Exception e) {
		}
		
		//오류생겨도 리다이렉트 해야하니깐 trycath문 밖에 위치
		resp.sendRedirect(cp+"/bbs/list.do");//INSERT 후에는 반드시 리다이렉트(새로고침하면 데이터가 계속 쌓이기 때문)
		//forward(req, resp, "/WEB-INF/views/bbs/list.jsp"); 
		// ->setattribute한것이 없어서 화면에 데이터들이 안보이고 캐시가 안지워지기 때문에 새로고침하면 db에 갔다와서 똑같은 데이터가 축적된다. 
		
	}
	
	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글보기
		BoardDAO dao = new BoardDAO();
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		String query = "page="+page;
		
		try {//trycatch쓴이유 클라이언트가 주소줄에 입력해서 보면 숨겨져있는 코드들이 보일수있어서 문제가 야기될 수 있다.
			long num = Long.parseLong(req.getParameter("num"));
			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			
			if(condition == null) {//null일때 검색안한상태이기때문에 첫화면을 all과 ""을 설정
				condition = "all";
				keyword = "";
			}
			keyword = URLDecoder.decode(keyword,"utf-8");//위에서 keyword를 ""안해주면 null이기때문에 디코딩에서 터지게됨 
			
			if(keyword.length() != 0) {//검색이면
				query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword,"utf-8");//인코딩해서 컨디션과 키워드를 같이 넘겨줌
			}
			
			//조회수 증가
			dao.updateHitCount(num);
			
			//게시글 가져오기
			BoardDTO dto = dao.readBoard(num);
			if(dto == null) {//웹은 정적이라 새로고침해야 변경된것들을 알수있음 새로고침하기전에 이미지워진 데이터를 클릭하면 null이나옴 그래서 리다이렉트로 list로 넘겨줌
				resp.sendRedirect(cp + "/bbs/list.do?" + query);
				return;
			}
			
			//글내용 엔터를 <br>로
			dto.setContent(dto.getContent().replaceAll("\n","<br>"));
			
			//이전글 다음글 
			BoardDTO preReadDto = dao.preReadBoard(num, condition, keyword);
			BoardDTO nextReadDto = dao.nextReadBoard(num, condition, keyword);
			
			//포워딩 할 JSP에 넘겨줄 속성
			req.setAttribute("dto", dto);
			req.setAttribute("preReadDto", preReadDto);
			req.setAttribute("nextReadDto", nextReadDto);
			
			
			req.setAttribute("page", page);
			req.setAttribute("query",query);
			
			forward(req, resp, "/WEB-INF/views/bbs/article.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/bbs/list.do?"+query);//주소창에 없는조건이나 주소를 글보기에서 쓰면 터져서 list로 리다이렉트함 
	}
	
	
	
	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 수정 폼 
		BoardDAO dao = new BoardDAO();
		String cp = req.getContextPath();
		String page = req.getParameter("page");
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			
			BoardDTO dto = dao.readBoard(num);
			if(dto == null) {
				resp.sendRedirect(cp + "/bbs/list.do?page="+page);
				return;
			}
			
			req.setAttribute("mode","update");
			req.setAttribute("dto", dto);
			req.setAttribute("page",page);
			
			forward(req,resp,"/WEB-INF/views/bbs/write.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/bbs/list.do?page="+page);
		
	}
	
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글 수정 완료
		BoardDAO dao = new BoardDAO();
		String cp = req.getContextPath();
		String page = req.getParameter("page");
		
		try {
			BoardDTO dto = new BoardDTO();
			
			dto.setName(req.getParameter("name"));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setPwd(req.getParameter("pwd"));
			dto.setNum(Long.parseLong(req.getParameter("num")));
			
			dao.updateBoard(dto);
			
			//수정완료 후 글보기로 가기
			//resp.sendRedirect(cp+"/bbs/article.do?page="+page+ "&num="+dto.getNum());//INSERT 후에는 반드시 리다이렉트(새로고침하면 데이터가 계속 쌓이기 때문)
			//return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//수정완료 후 아니면 수정 실패 했을 때 list로 돌아가기 (검색조건x)
		resp.sendRedirect(cp+"/bbs/list.do?page="+page);//INSERT 후에는 반드시 리다이렉트(새로고침하면 데이터가 계속 쌓이기 때문)
			
	}
	
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//게시글 삭제
		BoardDAO dao = new BoardDAO();
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		String query = "page="+page;
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			
			if(condition == null) {
				condition = "all";
				keyword = "";

			}
			keyword = URLDecoder.decode(keyword,"utf-8");
			
			if(keyword.length() != 0) {//검색이면
				query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword,"utf-8");//인코딩해서 컨디션과 키워드를 같이 넘겨줌
			}
			
			dao.deleteBoard(num);
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp+"/bbs/list.do?"+query);
		
		
	}
	
	

}
