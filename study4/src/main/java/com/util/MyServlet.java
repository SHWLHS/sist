package com.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Constructor;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Map<String, MyAction> map = new HashMap<>();
	
	@Override
	public void init(ServletConfig config) throws ServletException {//서블릿이 생성될때 딱한번만 실행
		super.init(config);
		
		String pathname = config.getInitParameter("configFile");
		if(pathname == null) {
			throw new ServletException("<init-param> error !!!");
		}
		
		ServletContext context = getServletContext();
		pathname = context.getRealPath(pathname);
		
		File f = new File(pathname);
		if( ! f.exists()) {
			throw new ServletException(pathname + " : file not found !!! ");
		}
		
		
		Properties p = new Properties();
		
		try (FileInputStream fis = new FileInputStream(f)){
			//config.properties 파일을 읽어 Properties 객체에 저장
			p.load(fis);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		}
		
		try {
			Iterator<Object> it = p.keySet().iterator();
			String className;
			
			//config.properties 에 있는 클래스의 객체를 생성하여 map에 저장
			while(it.hasNext()) {
				String key = (String)it.next();
				className = p.getProperty(key).trim();
				
				//System.out.println(key + " : " + className); 중간확인
				
				//객체 생성 
				Class<?> cls = Class.forName(className);
				Constructor<?> con = cls.getDeclaredConstructor();
				MyAction action = (MyAction)con.newInstance();
				
				// 맵에 저장
				map.put(key, action);
				
				//System.out.println(key + " : " + action); 중간확인
				
				
				
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		}
		
	}
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		execute(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		execute(req, resp);
		
	}
	
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		MyAction action = null;
		
		try {
			String uri = req.getRequestURI();
			
			//uri 에서 ContextPath 제거
			if(uri.indexOf(req.getContextPath()) ==0) {
				uri = uri.substring(req.getContextPath().length());
			}
			
			//uri 마지막 부분의 "/경로.do" 제거
			if(uri.lastIndexOf("/") >= 0) {
				uri = uri.substring(0,uri.lastIndexOf("/"));
			}
			
			action = map.get(uri);
			
			if(action == null) {
				throw new ServletException("HTTP 상태 404 - 찾을 수 없음");
			}
			
			//주소에 해당하는 MyAction 하위 클래스의 execute() 메소드 호출
			action.execute(req, resp);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		}
		
		
	}
	
	
	
	
	
}
