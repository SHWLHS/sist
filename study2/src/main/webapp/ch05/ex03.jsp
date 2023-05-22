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

<h3> forward</h3>

<form action="ex03_ok.jsp" method="post">
	<p> 이름 : <input type="text" name="name" required="required"></p>
	<p> 나이 : <input type="text" name="age" required="required" pattern="\d+"></p>
	<p>
		<button type="submit">확인</button>
	</p>
</form>

</body>
</html>