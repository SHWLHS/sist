<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	//session : 세션을 나타내는 JSP 내장 객체(HttpSession 객체)
	//서블릿에서 세션 객체 구하기 : HttpSession session = req.getSession(); 
	
	//세션 유지시간 설정. 기본 30분. 단위 초
	session.setMaxInactiveInterval(60*20); //유지시간을 20분으로 설정
	
	//세션에 정보 저장
	session.setAttribute("name", "홍길동");// setAttribute(String, Object)
	session.setAttribute("age", 20);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> session 설정</h3>

<p> <a href="ex03.jsp">돌아가기</a> </p>




</body>
</html>