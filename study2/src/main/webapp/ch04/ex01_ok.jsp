<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	// -request 
	// 	: 내장객체. 클라이언트가 보낸 요청 정보를 가지고 있는 객체
	// 	:HttpServletRequest 객체
	
	// -getParameter("이름")
	//	: 클라이언트가 보낸 파라미터 받기
	//	: 파라미터 중 이름에 해당하는 파라미터가 없으면 null

	// 클라이언트가 보낸 파라미터(GET 방식 : 쿼리스트링)를 넘겨 받는다.
	String name = request.getParameter("name");

	//자바에서 인코딩해서 넘어온 데이터를 디코딩
	name = URLDecoder.decode(name,"utf-8");


	int age = Integer.parseInt(request.getParameter("age"));
	String state = age >= 19? "성인" : "미성년자";
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p>
	<%=name %>님은 나이가 <%=age %> 이므로 <%=state %> 입니다.
</p>




</body>
</html>