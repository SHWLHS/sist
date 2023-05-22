<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %> 
<%@ attribute name = "title" required="true" %>
<%@ attribute name = "level" type="Integer" %>

<%--속성이 있는 태그 --%>
<%
	String s = null, e = null;

	if(level == null || level <= 1){
		s = "<h1>";
		e = "</h1>";
		
	}else if(level >= 6){
		s = "<h6>";
		e = "</h6>";
	}else {
		s = "<h"+level+">";
		e = "<h"+level +">";
	}
%>
<%-- 속성값은 EL, 스크립릿에서 사용 가능 --%>
<%=s %>${title}<%=e%>
