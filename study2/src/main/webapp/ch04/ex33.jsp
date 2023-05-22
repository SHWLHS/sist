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

<h3> response 객체</h3>
<!-- 
	- response : HttpServletResponse 객체
	- 클라이언트의 요청에 응답하는 객체
	- redirect	
		: 웹 컨테이너는 웹 브라우저에게 주어진 페이지로 이동하라고 명령을 내림(302 응답 신호를 보냄)
		 -> 웹 브라우저는 주어진 주소의 새로운 페이지에 다시 접속함
		: request, response 객체가 초기화 된다.
		: 일반적으로 redirect 하는 경우
		 로그인후, 로그아웃후, DB의 INSERT, UPDATE, DELETE 후
 -->
 
 <%
 response.sendRedirect("ex33_ok.jsp");
 %>
</body>
</html>