<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	// 쿠키 설정 : 서버에서 클라이언트 컴퓨터에 정보 저장
	// 쿠키의 유효 시간을 설정하지 않으면 브라우저가 종료되면 쿠키도 제거 된다.
	Cookie c1 = new Cookie("subject","java");
	response.addCookie(c1);//클라이언트 컴퓨터에 쿠키 저장
	
	Cookie c2 = new Cookie("subject2","spring");
	c2.setMaxAge(60*60); //단위 : 초 -> 60*60 1시간동안 쿠키가 살아있음
	response.addCookie(c2);
	
	//한글을 쿠키로 설정해야 하는 경우에는 반드시 인코딩 해야함
	Cookie c3 = new Cookie("subject3",URLEncoder.encode("오라클","utf-8"));
	c3.setMaxAge(-1); //-1: 브라우저가 종료되면 쿠키도 제거 (기본)
	response.addCookie(c3);

	//쿠키는 기본적으로 쿠키를 설정한 경로에서만 접근할 수 있다.
	Cookie c4 = new Cookie("tel","010-1111-2222");
	c4.setPath("/"); //모든 경로에서 쿠키를 접근 할 수 있도록 설정
	response.addCookie(c4);
			
	Cookie c5 = new Cookie("age","20");
	c5.setMaxAge(0);//쿠키 설정과 동시에 제거(일반적으로 쿠키를 제거 할 때 사용)
	response.addCookie(c5);



%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>


<h3><a href="ex01.jsp">돌아가기</a></h3>






</body>
</html>