package com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServletRequest;

@WebFilter(
		urlPatterns = "/*",
		initParams = @WebInitParam(name="charset", value = "utf-8")
)

public class CharacterEncodingFilter implements Filter {
	private String charset;
	

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		charset = filterConfig.getInitParameter("charset");
		if(charset == null) {//설정 안되있으면 utf-8로 설정
			charset = "utf-8";
		}
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		//POST 방식에서 파라미터 인코딩
		if(request instanceof HttpServletRequest) {
			HttpServletRequest req = (HttpServletRequest)request;
			if(req.getMethod().equalsIgnoreCase("POST")) {
				req.setCharacterEncoding(charset);
			}
		}
		
		chain.doFilter(request, response);
		
	}
	
	@Override
	public void destroy() {
		
		
	}

}
