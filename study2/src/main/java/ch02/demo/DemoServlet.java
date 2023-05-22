package ch02.demo;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 	-HttpServlet
 		:추상 클래스
 		:GenericServlet 클래스를 상속 받음
 		:GenericServlet 클래스의 service() 메소드가 재정의 되어 있음
 		:service() 메소드를 요청 method에 따라 다음의 메소드가 호출되도록 구현되어 있음
 		  doGet(HttpServletRequest, HttpServletResponse )
 		  doPost(HttpServletRequest, HttpServletResponse )
 		:요청 method에 따라 doGet(), doPost()를 재정의 해서 구현 함
 		:기본적인 요청 method는 GET method 임
 		:POST 요청은 <form> 태그에서 method="post" 라고 속성으로 설정함
 		
 		
 	-HttpServletRequest(ex: 아이디,패스워드)
 		:클라이언트가 보낸 요청 정보를 담고 있는 객체
 	-HttpServletResponse(ex: 로그인완료,실패) 
 		:클라이언트에게 응답할 정보를 담고 있는 객체
  
 */

@WebServlet("/demo") //서블릿과 주소 매핑
public class DemoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//클라이언트가 GET 방식으로 요청한 경우 실행
		
		//GET 방식의 요청 정보는 주소줄에 파라미터(쿼리스트링)를 전송
		//	주소?이름1=값1&이름2=값2
		
		try {
			//클라이언트가 보낸 파라미터 정보를 받는다
			String name = req.getParameter("name");
			int age = Integer.parseInt(req.getParameter("age"));
			
			String state = age >=19? "성인":"미성년자";
			
			//클라이언트에게 전송할 컨텐츠 타입
			resp.setContentType("text/html;charset=utf-8");
			
			//처리 결과를 클라이언트에게 전송
			PrintWriter out = resp.getWriter();
			
			out.println("<html>");
			out.println("<head><title>servlet 예제</title></head>");
			out.println("<body>");
			out.println("<h3>GET 방식으로 요청한 처리 결과</h3>");
			out.println("<p>"+name+"님의 나이는"+age+"이므로 <b>"+state+"</b> 입니다.</p>");
			out.println("</body>");
			out.println("</html>");
			
		} catch (Exception e) {
			getServletContext().log("error",e);
			
		}
		
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//클라이언트가 POST 방식으로 요청한 경우 실행
		
		//POST 방식의 요청 정보는 body에 정보를 실어서 보냄
		//<form method="post" action="주소">...</form> 을 통해서 요청정보를 보냄
		
		//POST 방식은 클라이언트에서 전송한 인코딩을 설정해야 한글이 깨지지 않는다.
		req.setCharacterEncoding("utf-8"); //반드시 서버 실행되기전에 먼저 써줘야한다.
		
		try {
			//클라이언트가 보낸 파라미터 정보를 받는다
			String name = req.getParameter("name");
			int age = Integer.parseInt(req.getParameter("age"));
			
			String state = age >=19? "성인":"미성년자";
			
			//클라이언트에게 전송할 컨텐츠 타입
			resp.setContentType("text/html;charset=utf-8");
			
			//처리 결과를 클라이언트에게 전송
			PrintWriter out = resp.getWriter();
			
			out.println("<html>");
			out.println("<head><title>servlet 예제</title></head>");
			out.println("<body>");
			out.println("<h3>POST 방식으로 요청한 처리 결과</h3>");
			out.println("<p>"+name+"님의 나이는"+age+"이므로 <b>"+state+"</b> 입니다.</p>");
			out.println("</body>");
			out.println("</html>");
			
		} catch (Exception e) {
			getServletContext().log("error",e);
			
		}
		
		
	} 

}
