package com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;

@WebFilter("/*")
public class LoginFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		//request 필터
		
		
		//로그인 체크
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse)response;
		String cp = req.getContextPath();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		if(info == null && isExcludeUri(req) == false) {//로그인 안되어있고 
			if(isAjaxRequest(req)) {//ajax이면 에러 발생
				resp.sendError(403);
			}else {
				
				//로그인 전 주소 저장
				String uri = req.getRequestURI();
				String qs = req.getQueryString();
				if( qs != null) {
					uri += "?" + qs;
					
				}
				session.setAttribute("preLoginURI", uri);
				
				
				//ajax가 아니면 로그인화면으로 이동
				resp.sendRedirect(cp + "/member/login.do");
				
			}
			
			return;
		}
		
		
		chain.doFilter(request, response);
		
		
		//response 필터
	
	}
	
	
	//요청이 AJAX 인지를 확인하는 메소드
	protected boolean isAjaxRequest(HttpServletRequest req) {
		String h = req.getHeader("AJAX");
		
		
		
		return h != null && h.equals("true");
	}
	
	//로그인 체크가 필요하지 않은지의 여부 파악
	protected boolean isExcludeUri(HttpServletRequest req ) {
		String uri = req.getRequestURI();
		String cp = req.getContextPath();
		uri = uri.substring(cp.length());//cp를 제거하는 주소 uri
		
		if(uri.length() <= 1) {//메인페이지일경우 1보다 적거나 같으니깐 검사 안해도됨
			return true;
		}
		
		String[] uris = {
				"/index.jsp", "/main.do",
				"/member/login.do", "/member/login_ok.do",
				"/member/member.do","/member/member_ok.do",
				"/member/userIdCheck.do", "/member/pwdFind.do",
				"/notice/list.do", "/member/pwdFind_ok.do", "/member/complete.do",
				"/resources/**" //resources 안에 있는 모든것들은 로그인 안되있어도 
				
		};
		
		for(String s : uris) {
			if(s.lastIndexOf("**") != -1 ) {
				s = s.substring(0,s.lastIndexOf("**"));
				if(uri.indexOf(s) ==0) {
					return true;
				}
			}else if (uri.equals(s)) {
				return true;
			}
			
		}
			
		
		return false;
	}
	
	
	
	
	

}
