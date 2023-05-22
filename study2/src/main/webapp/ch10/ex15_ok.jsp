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

<h3>forEach : Collection 객체 반복 출력 - List</h3>

<h3>forEach와 EL을 이용하여 출력</h3>
<c:forEach var="vo" items="${list }">
	<p>${vo.name } : ${vo.age } : ${vo.subject }</p>
</c:forEach>
<hr>

<h3>반복 상태 확인 : varStatues 속성</h3>
<!-- index:0부터시작, count:1부터시작 , first: 첫번째인지 , last:마지막인지 -->
<c:forEach var="vo" items="${list }" varStatus="status">
	<p>
		${vo.name } : ${vo.age } : ${vo.subject } | 
		${status.index } : ${status.count } : ${status.first } : ${status.last }
	</p>
</c:forEach>
</body>
</html>