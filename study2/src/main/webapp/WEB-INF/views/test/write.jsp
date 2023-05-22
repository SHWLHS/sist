<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	String cp = request.getContextPath();//문맥경로(프로젝트명)
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<!-- HTML 에서의 /는 http://localhost:9090/ 까지 해당 -->


<form action="<%=cp%>/test" method="post">
	<p>이름 : <input type="text" name="name"></p>
	<p>나이 : <input type="text" name="age"></p>
	<p>
		<button type="submit">등록하기</button>
	</p>
</form>

</body>
</html>