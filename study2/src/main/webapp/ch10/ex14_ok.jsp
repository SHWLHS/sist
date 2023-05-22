<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>forEach : Collection 객체 반복 출력 - List</h3>

<c:forEach var="s" items="${list }">
	<p>${s }</p>
</c:forEach>
<hr>



<h3>forEach : 메소드 사용</h3>

<c:forEach var="s" items="${subject.split(',') }">
	<p>${s }</p>
</c:forEach>

</body>
</html>