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

<h2>c:url / c:param</h2>
<!-- 
	*c:url 태그
		-url을 만들며 URL 인코딩 또는 URL 형식 지정에 사용
		-context path가 자동으로 추가
	*c:param
		-c:import, c:url 태그에 파라미터를 전달하기 위해 사용
 -->
 
 <!-- 파라미터를 인코딩 하여 주소를 만든다. -->
 <!-- a라는 변수에 ex23_ok.jsp를 담아주고 name,age를 파라미터로 같이 인코딩해서 전달 -->
<c:url var="a" value="ex23_ok.jsp"> 
	<c:param name="name" value="이자바"/>
	<c:param name="age" value="20"/>
</c:url>

<a href="${a}">확인</a>
<!-- "ex23_ok.jsp?name=%ec%9d%b4%ec%9e%90%eb%b0%94&age=20" -->


</body>
</html>