<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%

	//post 방식은 파라미터를 넘겨 받기전에 반드시 파라미터의 이노딩을 설정해야 한다.
	// 설정하지 않으면 한글 등 이 깨진다.
	//post 방식에서 넘어온 파라미터의 인코딩 설정
	request.setCharacterEncoding("utf-8");
	
	String name = request.getParameter("name");

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