<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>element 액션 태그 및 text 액션 태그</h3>

<!-- jsp:element는 임의의 XML이나 HTML 태그를 만든다. -->
<jsp:element name="userName">
	<jsp:attribute name="gender">
		여자
	</jsp:attribute>
	<jsp:body>
		사임당
	</jsp:body>
</jsp:element>

<!-- jsp:text 는 JSP 페이지에 표시할 텍스트 -->
<p>
	<jsp:text> text 액션 태그 예제 </jsp:text>
</p>

</body>
</html>