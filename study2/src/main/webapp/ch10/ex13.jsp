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

<h3>JSTL : forEach - 반복구문</h3>

<form action="ex13.jsp" method="post">
	<p>
		<input type="text" name="num" placeholder="숫자" required="required" pattern="\d+">
		<button type="submit">확인</button>
	</p>
</form>

<c:if test="${not empty param.num }">

	<p>**${param.num }단**</p>
		<!-- step : 증가분, 생략하면 증가분은 1 -->
	<c:forEach var="n" begin="1" end="9" step="1">
		<p>${param.num }*${n} = ${param.num * n }</p>
	</c:forEach>
</c:if>



</body>
</html>