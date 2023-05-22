<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> EL 내장객체 </h3>

<p> pageContext : 현재 페이지의 설정 정보 </p>
<p> contextPath : <%= request.getContextPath() %> </p>
<p> contextPath : ${ pageContext.request.contextPath } </p>
<hr>

<p> header : 요청 헤더 정보 </p>
<p> User-Agent : ${ header["user-agent"] } </p>



</body>
</html>