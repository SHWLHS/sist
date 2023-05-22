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

<h3>파라미터를 getParameter()로 받기</h3>

<div>
	<form action="ex12_ok.jsp" method="post">
		<p> 이름 : <input type="text" name="name"></p>
		<p> 패스워드 : <input type="password" name="pwd"></p>
		<p> 나이 : <input type="text" name="age"></p>
		<p>
			<input type="radio" name="gender" value="M" checked="checked">남
			<input type="radio" name="gender" value="F" >여
		</p>
		<p>
		 	좋아하는 과목 : 
		 	<input type="checkbox" name="subject" value="자바">자바
		 	<input type="checkbox" name="subject" value="서블릿">서블릿
		 	<input type="checkbox" name="subject" value="스프링">스프링
		 	<input type="checkbox" name="subject" value="오라클">오라클
		 	<input type="checkbox" name="subject" value="웹">웹
		</p>
		<p>
			<button type="submit">확인</button>
		</p>
	</form>
	
</div>


</body>
</html>