package com.tag;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

public class Fortag extends TagSupport {
	private static final long serialVersionUID = 1L;
	
	//속성들 setter만 만들어야함(int는 null을 가질수없어서 Integer로 사용)
	private Integer begin;
	private Integer end;
	private Integer step;
	private String var;
	
	
	public void setBegin(Integer begin) {
		this.begin = begin;
	}
	public void setEnd(Integer end) {
		this.end = end;
	}
	public void setStep(Integer step) {
		this.step = step;
	}
	public void setVar(String var) {
		this.var = var;
	}
	
	@Override
	public int doStartTag() throws JspException {
		//시작 태그를 만났을 때
		if(step==null) {
			step = 1;
		}
		
		//						증가								감소
		if(step == 0 || (begin > end && step > 0) || (begin < end && step < 0)) {
			return SKIP_BODY;
		}
		
		pageContext.setAttribute(var, begin);
		
		return EVAL_BODY_AGAIN;//몸체 실행
	}
	
	@Override
	public int doAfterBody() throws JspException {
		//몸체 실행 후
		if((step>0 && end>=begin+step) || (step<0 && end<=begin+step)) {
			begin += step;
			pageContext.setAttribute(var, begin);
			return EVAL_BODY_AGAIN;//몸체 다시 실행
		}
		return SKIP_BODY;
	}
	
	@Override
	public int doEndTag() throws JspException {
		//종료 태그를 만날때
		
		begin = end = step = null;
		var = null;
		
		
		return EVAL_PAGE; //JSP 다음 내용 실행
	}
	

}
