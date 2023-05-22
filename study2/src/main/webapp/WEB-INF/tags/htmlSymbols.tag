<%@ tag body-content="scriptless" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %> 
<%@ attribute name="trim" %>

<%--몸체로 전달 받은 내용을 var 속성의 지정한 scope 영역에 저장 --%>
<jsp:doBody var ="content" scope="page"/>
<%-- pageContext.setAttribute("이름",값); 같은 개념으로 설정 --%>

<%
	String content = (String)jspContext.getAttribute("content");
	
	if(trim != null && trim.equals("true")){
		content = content.trim();
	}
	
	content = content.replaceAll("&","&amp;");
	content = content.replaceAll("\"","&quot;");
	content = content.replaceAll(">","&gt;");
	content = content.replaceAll("<","&lt;");
	content = content.replaceAll("\n","<br>");
	content = content.replaceAll("\\s","&nbsp;");
%>

<%= content%>