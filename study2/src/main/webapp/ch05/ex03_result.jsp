<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");

//페이지를 포워딩한 경우 포워딩한 페이지에서 request, response 객체가 전달되므로
//	파라미터를 받을수 있다.
// ex03.jsp => ex03_ok.jsp => ex03_result.jsp
//			요청				포워딩
//		name,age 전달			name,age도 포워딩된 페이지에서 받을 수 있음
	String name = request.getParameter("name");
	int age = Integer.parseInt(request.getParameter("age"));
	
	//request.setAttribute(이름,값) 으로 설정한 값 가져오기
	//메소드 원형 : Object request.getAttribute("이름")
	String s = (String)request.getAttribute("state");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p>이름 : <%=name %></p>
<p>나이 : <%=age %>, <%=s %></p>


</body>
</html>