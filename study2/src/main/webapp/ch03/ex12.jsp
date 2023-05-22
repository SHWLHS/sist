<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page buffer="1kb" autoFlush="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>page 지시어</h3>

<pre>
	buffer :  출력 버퍼 크기 지정(기본 8kb)
	autoFlush : 버퍼가 꽉찰 경우 비우는 여부 지정(기본 : true - 버퍼 비움)
</pre>

<!-- 아래 for문의 결과만으로도 4kb가 넘으면 autoFlush가 false라서 에러가 나옴 -->
<!-- autoFlush를 true로 변경하면 에러가 없어짐 -->
<% for(int i=1; i<=1000; i++) { %>
	1234
<% } %>


</body>
</html>