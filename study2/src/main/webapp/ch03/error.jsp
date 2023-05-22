<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page isErrorPage="true" %> <!-- 에러가 발생할 때 보여지는 페이지임을 설정 -->
<%
	//에러 페이지가 아닌 정상적인 페이지임을 설정
	response.setStatus(HttpServletResponse.SC_OK);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>정보</h3>

<p> 시스템 점검 중 입니다.</p>



</body>
</html>