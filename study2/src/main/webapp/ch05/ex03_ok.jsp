<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");

	int age = Integer.parseInt(request.getParameter("age"));
	String s = age >= 19? "성인":"미성년자";
	
	request.setAttribute("state", s);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p> 포워딩 하면 이 페이지는 보이지 않습니다. </p>
<!-- jsp 액션 태그를 이용하여 forward -->
<jsp:forward page="ex03_result.jsp"/>



</body>
</html>