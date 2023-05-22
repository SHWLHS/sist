<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page errorPage="error.jsp" %>

<%
	String s ="a";
	int n = Integer.parseInt(s);//에러 발생
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>page 지시어</h3>
<p> errorPage : 에러가 발생할 경우 보여줄 페이지 지정 </p>

<p> <%=n %></p>

</body>
</html>