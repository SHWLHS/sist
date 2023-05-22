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

<h3> session : 클라이언트의 정보를 서버에 저장</h3>
<!-- 세션은 일반적으로 로그인처리할때 사용하며 , 로그인한 유저의 아이디,이름,권한등을 저장한다. -->

<p>
	<a href="ex03_setSession.jsp">세션에 값(속성) 저장</a> |
	<a href="ex03_getSession.jsp">세션에 저장된 속성 가져오기</a> |
	<a href="ex03_removeSession.jsp">세션에 저장된 속성 제거</a> 
</p>


</body>
</html>