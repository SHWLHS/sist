package ch02.sample;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SampleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
		
	}
	
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		//int a  = Integer.parseInt("A"); //에러 테스트 위해 일부로 에러를 일으킴
		
		try {
			//ServletConfig : 해당 서블릿의 설정 정보를 가지고 있는 객체 
			ServletConfig config = getServletConfig();
			
			//ServletContext : 웹서버의 설정 정보를 가지고 있는 객체
			ServletContext context = getServletContext();
			
			//web.xml 의 <servlet> 아래의 <init-param> 설정 값 가져오기
			String name = config.getInitParameter("name");
			String city = config.getInitParameter("city");
			
			
			//web.xml의 <context-param> 설정 값 가져오기
			String url = context.getInitParameter("url");
			String user = context.getInitParameter("user");
			
			resp.setContentType("text/html; charset=utf-8");
			PrintWriter out = resp.getWriter();
			
			out.print("<html>");
			out.print("<body>");
			out.print("<h3>ServletConfig / ServletContext 객체 </h3>");
			out.print("<p>ServletConfig 설정 값 :  " + name + "," + city + "</p>" );
			out.print("<p>ServletContext 설정 값 :  " + url + "," + user + "</p>" );
			out.print("</body>");
			out.print("</html>");
			
			
		} catch (Exception e) {
			getServletContext().log("error : ", e);
		}
		
	}
	
	
	
}
