<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	Cookie c1 = new Cookie("subject",null);
	c1.setMaxAge(0);
	response.addCookie(c1);
	
	Cookie c2 = new Cookie("subject2",null);
	c2.setMaxAge(0);
	response.addCookie(c2);
	
	Cookie c3 = new Cookie("subject3",null);
	c3.setMaxAge(0);
	response.addCookie(c3);
	
	Cookie c4 = new Cookie("tel",null);
	c4.setPath("/");//패스를 설정한 쿠키를 제거할 때는 패스를 설정해야 함
	c4.setMaxAge(0);
	response.addCookie(c4);	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>


<h3>쿠키 제거</h3>

<p> <a href="ex01.jsp">돌아가기</a> </p>


</body>
</html>