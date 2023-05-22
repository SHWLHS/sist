<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>세션 동작 원리</h3>

<p> isNew() : <%=session.isNew() %></p>
<hr>

<h3>쿠키 내용</h3>
<%
	Cookie []  cc = request.getCookies();
	if(cc != null){
		for(Cookie c : cc){
			String name = c.getName();
			String value = c.getValue();
			out.print("<p>" + name + " : " + value + "</p>");
			
		}
	}
%>


</body>
</html>