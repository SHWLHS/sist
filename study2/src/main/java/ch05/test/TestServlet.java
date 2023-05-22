package ch05.test;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/test")
public class TestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//클라이언트가 get방식으로 요청한 경우
		forward(req, resp, "/WEB-INF/views/test/write.jsp");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//클라이언트가 post 방식으로 요청한 경우
		req.setCharacterEncoding("utf-8"); //post방식이라 설정해야함
		
		String name = req.getParameter("name");
		int age = Integer.parseInt(req.getParameter("age"));
		
		String s = age>=19? "성인" : "미성년자";
		
		String m = name + "님은 " + s + "입니다.";
		
		req.setAttribute("msg", m);//req.setAttribute(String,object)
		
		forward(req, resp, "/WEB-INF/views/test/result.jsp");
	}
	
	protected void forward(HttpServletRequest req, HttpServletResponse resp, String path) throws ServletException, IOException {
		//포워딩
		RequestDispatcher rd = req.getRequestDispatcher(path);
		rd.forward(req, resp);
		
	}
	
	
}
