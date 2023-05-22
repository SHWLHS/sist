<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="my" uri="/WEB-INF/myTag.tld" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>커스텀 태그</h3>

<p>몸체가 있는 태그</p>
<p>
	<my:for  var="n" begin="1" end="10" step="2">
		${n } &nbsp;|&nbsp;
	</my:for>
</p>
<hr>

<p>
	<my:for  var="n" begin="1" end="10" >
		${n } &nbsp;|&nbsp;
	</my:for>
</p>


</body>
</html>