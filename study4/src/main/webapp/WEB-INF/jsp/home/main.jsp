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

<header>
	<span>홈</span> |
	<a href="#">로그인</a> |
	<a href="${pageContext.request.contextPath }/bbs/list.do">게시판</a> |
	<a href="${pageContext.request.contextPath }/guest/main.do">방명록</a>
</header>


<main>
	<hr>
	
	<h3>메인</h3>
	<div>
		<p>메인 화면 입니다. </p>
	</div>
</main>



</body>
</html>