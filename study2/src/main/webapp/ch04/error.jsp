<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>


<p> 요청 처리 과정에서 에러가 발생했습니다.</p>
<hr>

<p>예외 타입 : <%= exception.getClass().getName() %></p>
<p>예외 메시지 : <%= exception.getMessage()%></p>
</body>
</html>