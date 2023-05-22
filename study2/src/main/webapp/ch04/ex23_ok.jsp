<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String num = request.getParameter("num");
	String name = request.getParameter("name");
	String age = request.getParameter("age");
	String id = request.getParameter("id");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p>번호 : <%=num %></p>
<p>이름 : <%=name %></p>
<p>나이 : <%=age %></p> <!-- null : disabled 속성의 객체는 서버로 전송되지 않음 -->
<p>아이디 : <%=id %></p> <!-- id="" 이므로 아무것도 출력되지 않음(value를 아예 주지않음) --> 


</body>
</html>