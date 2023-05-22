<%@page import="java.util.ArrayList"%>
<%@page import="ch10.user.User"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("utf-8");
	
	List<User> list = new ArrayList<>();
	
	list.add(new User("김자바",20,"자바"));
	list.add(new User("이자바",22,"오라클"));
	list.add(new User("나자바",20,"스프링"));
	list.add(new User("다자바",22,"HTML"));
	list.add(new User("하자바",21,"CSS"));
	
	request.setAttribute("list", list);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<jsp:forward page="ex15_ok.jsp"/>





</body>
</html>