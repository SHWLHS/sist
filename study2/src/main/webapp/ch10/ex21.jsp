<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String s = "<p style='color:red;'>자바</p>";
	
	pageContext.setAttribute("subject", s);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>c:out 태그 : 표현식의 결과를 출력한다.</h3>

<p>EL를 이용한 출력 : 글자가 red로 출력 </p>
<p> ${subject }</p>
<hr>

<p> c:out을 이용한 출력-1 : escapeXml 속성이 true로 태그 문자가 그대로 출력 </p>
<c:out value="${subject }"/>
<hr>

<p> c:out을 이용한 출력-2 : escapeXml 속성이 false 이면 태그의 실행결과가 출력</p>
<c:out value="${subject }" escapeXml="false"/>
<hr>




</body>
</html>