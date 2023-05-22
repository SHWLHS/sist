<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	
	String msg = (String)request.getAttribute("msg");//object라 Stng으로 다운캐스팅
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p><%=msg %></p>
<p>${ msg }</p><!-- EL : 자바코드를 안찍어도 찍는방법 -->

</body>
</html>