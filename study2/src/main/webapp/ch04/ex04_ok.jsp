<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%

	request.setCharacterEncoding("utf-8");
	
	String name = request.getParameter("name");

	int age = Integer.parseInt(request.getParameter("age"));
	String state = age >= 19? "성인" : "미성년자";
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p>
	<%=name %>님은 나이가 <%=age %> 이므로 <%=state %> 입니다.
</p>

</body>
</html>