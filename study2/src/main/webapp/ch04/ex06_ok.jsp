<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%

	request.setCharacterEncoding("utf-8");

	String condition = request.getParameter("condition");
	String kwd = request.getParameter("keyword");
	

%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p> 검색조건 : <%= condition%></p>
<p> 검색 값 : <%= kwd%></p>

</body>
</html>