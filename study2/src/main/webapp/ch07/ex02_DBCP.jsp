<%@page import="com.util.DBCPConn"%>
<%@page import="java.sql.Connection"%>
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

<h3> DBCP 테스트 </h3>

<%
	Connection conn = null;

	conn = DBCPConn.getConnection();
	out.print("<p>"+conn+"</p>");
	DBCPConn.close(conn);//DBCP는 사용 후 Connection을 반드시 반납해야함(반납하지 않으면 락걸림 )

	conn = DBCPConn.getConnection();
	out.print("<p>"+conn+"</p>");
%>


</body>
</html>