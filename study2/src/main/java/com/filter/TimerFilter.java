package com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

@WebFilter("/*")
public class TimerFilter implements Filter{

	private FilterConfig filterConfig;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		//필터 클래스의 객체가 생성될때 한번 실행
		
		this.filterConfig = filterConfig;
		
	}

	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		//클라이언트의 요청이 있을때마다 실행
		
		//request 필터
		long begin = System.currentTimeMillis();
		
		//다음 필터 또는 필터의 마지막이면 end-pointer(서블릿,jsp등)을 실행
		chain.doFilter(request, response);//서블릿으로 보내주는 메소드
		
		//response 필터
		long after = System.currentTimeMillis();
		
		String uri = "";
		if(request instanceof HttpServletRequest) {
			HttpServletRequest req = (HttpServletRequest)request;
			
			uri = req.getRequestURI();
			filterConfig.getServletContext().log("["+uri+"]-" + (after-begin) + "ms");
		}
	}
	
	
	
	@Override
	public void destroy() {
		//필터 클래스의 객체가 소멸될 때 한번 실행
		
		
	}
	
}
