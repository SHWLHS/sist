<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("utf-8");

	List<String> list = new ArrayList<>();
	list.add("서울");
	list.add("경기");
	list.add("인천");
	
	request.setAttribute("list", list );
	request.setAttribute("subject", "자바,스프링,HTML,CSS,서블릿");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<jsp:forward page="ex14_ok.jsp"/>

</body>
</html>