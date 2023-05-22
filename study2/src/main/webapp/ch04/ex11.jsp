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

<h3>파라미터 전송</h3>
<div>
	<p> get 방식 전송 </p>
	<p>
		<a href="ex11_ok.jsp?name=spring&age=20">확인</a>
	</p>
</div>
<hr>

<div>
	<p> post 방식 전송 </p>
	<form name="frm" action="ex11_ok.jsp" method="post">
		<p>이름 : <input type="text" name="name" required="required"></p>
		<p>나이 : <input type="text" name="age" required="required" pattern="\d+"></p>
		<p>
			<button type="submit">확인</button> |
			<button type="reset">다시입력</button> 
		</p>
	</form>
</div>


</body>
</html>