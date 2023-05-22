<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>쿠키 가져오기</h3>
<!-- 클라이언트 컴퓨터에 저장된 쿠키를 서버로 가져오기 -->

<%
	Cookie[] cc = request.getCookies();//하나씩 가져오는 방법은 없음 , 전체 배열로 가져와야함

	if(cc != null){
		for(Cookie c: cc){
			String name = c.getName();//쿠키이름
			String value = c.getValue();//쿠키값
			if(name.equals("subject3")){//한글을 인코딩해서 저장해서
				value = URLDecoder.decode(value,"utf-8");//디코딩
			}
			
			out.print("<p>" + name + " : " + value + "</p>" );
					
		}
	}

%>
<p> <a href="ex01.jsp">돌아가기</a> </p>

</body>
</html>