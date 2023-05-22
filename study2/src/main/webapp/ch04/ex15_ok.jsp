<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");

	//서버로 전송된 파라미터이름
	Enumeration<String> e = request.getParameterNames();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> 클라이 언트가 전송한 모든 파라미터 이름 : getParameterNames() </h3>

<%
	while(e.hasMoreElements()){
		String name = e.nextElement();
		String[] ss = request.getParameterValues(name);
		for(String s : ss){
			out.print("<p>" + name + " : " + s + "</p>");
		}
	}
%>

</body>
</html>