package com.tag;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

public class HelloTag extends TagSupport {
	private static final long serialVersionUID = 1L;
	
	@Override
	public int doStartTag() throws JspException {//doStartTag() : 태그를 시작하는 동시에 실행
		JspWriter out = pageContext.getOut();//pageContext : jsp에대한 환결설정을 가지고 있는 객체
		
		try {
			out.print("<b>반가워요</b>");//클라이언트에게 전송
		} catch (Exception e) {
			throw new JspException(e);
		}
		
		return SKIP_BODY;//바디는 없어서 건너뜀(바디 없는 태그)
	}
	
	
}


