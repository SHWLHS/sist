<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	//세션에 저장된 특정 속성값 지우기
	session.removeAttribute("name");
	session.removeAttribute("age");
	
	//세션에 저장된 모든 속성값 지우고 세션을 초기화 (보통 로그아웃할때 사용)
	session.invalidate();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>세션에 저장된 속성값 지우기</h3>

<p> <a href="ex03.jsp">돌아가기</a> </p>


</body>
</html>