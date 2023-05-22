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

<h2> c:forTokens 태그</h2>
<!-- 구분자로 구분된 토큰을 반복 출력 -->

<c:forTokens items="Red,Blue,Green" delims="," var="color">
	<p> <c:out value="${color }"/> | ${color }</p>
</c:forTokens>


</body>
</html>