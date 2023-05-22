<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String name = "";
	int age = 0;
	try{
		name = (String)session.getAttribute("name");
		age = (Integer)session.getAttribute("age");//null은 형변환 안되서 trycatch사용
	}catch(Exception e){
		
	}
	int interval = session.getMaxInactiveInterval();//유지시간
	
	String id = session.getId();// 세션 아이디
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	 Date date1 = new Date(session.getCreationTime());//세션이 만들어진시간
	String create_date = sdf.format(date1);
	
	//세션 마지막 접속 시간
	Date date2 = new Date(session.getLastAccessedTime());//세션 마지막 접속 시간
	String last_date = sdf.format(date2);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>세션 정보</h3>
<p> 세션 아이디 : <%=id %> </p>
<p>이름과 나이 : <%=name%>, <%=age %></p>
<p>EL을 이용한 세션값 가져오기 : ${sessionScope.name }, ${sessionScope.age } </p>
<p> 세션 최대 유지시간 : <%=interval %></p>
<p> 세션 생성 시간 : <%=create_date %> </p>
<p> 세션 마지막 접속 시간 : <%=last_date %> </p>
<hr>

<p> <a href="ex03.jsp">돌아가기</a> </p>

</body>
</html>