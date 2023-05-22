<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page errorPage = "error.jsp"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>


<h3>exception 내장 객체</h3>
<!-- 
	JSP 페이지에서 발생한 예외를 처리할 페이지를 지정한 경우 에러 페이지 전달되는 예외 객체
 -->
 
 <%
 	//String s = null;
 	//int a = s.length();//NullpointException
 	
 	String s = "";
 	int a = s.length();//0
 	
 	
 	
 	String name = request.getParameter("name").toUpperCase();//name은 null인데 toUpperCase()를써서 에러
 		//주소에 ?name을 쓰고 새로고침하면 name이라는 객체는 만들어졌기 때문에 값이 ""된다 그래서 에러가 아님.
 %>
 
 <p>
 	이름 : <%=name %>
 </p>
 

</body>
</html>