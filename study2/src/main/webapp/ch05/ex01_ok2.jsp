<%@page import="ch05.calc.Calculator"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");

	Calculator cal = new Calculator();//만든 클래스 호출(임포트)
	
	cal.setNum1(Integer.parseInt(request.getParameter("num1")));
	cal.setNum2(Integer.parseInt(request.getParameter("num2")));
	cal.setOperator(request.getParameter("operator"));
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<%= cal.toString() %>



</body>
</html>