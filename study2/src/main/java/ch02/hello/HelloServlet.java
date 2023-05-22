package ch02.hello;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.GenericServlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/*
  	-GenericServlet 추상 클래스
  		: Servlet 인터페이스 구현 클래스
  		: 서블릿의 기반이 되는 클래스
  		: service() 추상 메소드를 재정의 해야 한다.
 */



public class HelloServlet extends GenericServlet{
	private static final long serialVersionUID = 1L;
	

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		
		//서블릿이 초기화 될때 단 한번 실행
		System.out.println("init!");
		
	}

	@Override  
	public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {
		//클라이언트가 요청할때 마다 실행
		
		System.out.println("service!");
		
		try {
			Calendar now = Calendar.getInstance();
			String s = String.format("%tF %tT", now ,now);
			
			//클라이언트에게 보내는 문서 타입
			res.setContentType("text/html; charset=utf-8");
			
			//클라이언트에게 HTML 문서를 전송
			PrintWriter out = res.getWriter();
			
			out.println("<html>");
			out.println("<head><title>첫번째 예제</title></head>");
			out.println("<body>");
			out.println("<h3>서블릿 첫번째 예제</h3>");
			out.println("<p>오늘날짜 및 현재 시간은 "+s+ "입니다.</p>");
			out.println("</body>");
			out.println("</html>");
			
		} catch (Exception e) {
			getServletContext().log("error:",e);
		}
		
	}

	@Override
	public void destroy() {
		// 서블릿이 종료(서버 종료) 되는 시점에 단 한번 실행(강제종료하면 실행안됨)
		System.out.println("destroy!");
		
	}


}
