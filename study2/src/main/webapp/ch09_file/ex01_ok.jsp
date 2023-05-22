<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("utf-8");

	String subject = request.getParameter("subject");
	String name = request.getParameter("name");
	String upload = request.getParameter("selectFile");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>결과</h3>

<p> 제목 : <%=subject %></p>
<p> 이름 : <%=name %></p>
<p> 파일 : <%=upload %></p><!-- 파일 이름만 넘어옴 -->


</body>
</html>