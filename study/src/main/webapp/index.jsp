<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Calendar cal = Calendar.getInstance();
String s = String.format("%tF %ta %tT", cal, cal, cal);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>스프링 홈페이지</h3>
	<p>
		접속 시간은
		<%=s%>입니다.
	</p>

</body>
</html>