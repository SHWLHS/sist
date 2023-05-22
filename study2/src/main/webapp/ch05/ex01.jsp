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

<form action="ex01_ok.jsp" method="post">
<p>
	<input type="text" name="num1" required="required" pattern="\d+">
	<select name="operator">
		<option value="+">더하기</option>
		<option value="-">빼기</option>
		<option value="*">곱하기</option>
		<option value="/">나누기</option>
	</select>
	<input type="text" name="num2" required="required" pattern="\d+">
	<button>결과</button>
</p>
</form>

</body>
</html>