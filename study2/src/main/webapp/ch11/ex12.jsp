<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>태그 파일 : 몸체가 있는 태그</h3>

<p>
	<tf:htmlSymbols>
		<b></b> : 글자를 진하게 합니다.
		엔터o
	</tf:htmlSymbols>
</p>
<hr>

<p>
	<tf:htmlSymbols2>
		<b></b> : 글자를 진하게 합니다.
		엔터x
	</tf:htmlSymbols2>
</p>

</body>
</html>