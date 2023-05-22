<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
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

<h2>c:set 태그 - 표현식의 결과를 특정 범위에 저장</h2>

<c:set var="n" value="2"/>
<c:set var="result" value="1"/>
<c:forEach var="a" begin="1" end="10">
   <c:set var="result" value="${n*result}"/>
   <p>${n} 의 ${a} 승 = ${result}</p>
</c:forEach>

</body>
</html>