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
	<a href="${pageContext.request.contextPath }/home/main.do">홈</a> |
	<a href="#">로그인</a> |
	<a href="${pageContext.request.contextPath }/bbs/list.do">게시판</a> |
	<span>방명록</span> 
</header>


<main>
	<hr>
	
	<h3>방명록</h3>
	<div>
		<p>방명록 화면 입니다. </p>
	</div>
</main>



</body>
</html>