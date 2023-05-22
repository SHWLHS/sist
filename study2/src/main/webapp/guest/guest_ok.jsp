<%@page import="java.sql.SQLException"%>
<%@page import="com.guest.GuestDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	request.setCharacterEncoding("utf-8");

%>

<jsp:useBean id="dto" class="com.guest.GuestDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%
	GuestDAO dao = new GuestDAO();
	String s = "";	

	try{
		dao.insertGuest(dto);
		response.sendRedirect("guest.jsp");
		return;
		
	}catch(SQLException e){
		s = "등록에 실패했습니다.";
		request.setAttribute("msg", s);
	}
	
%>
	
	<jsp:forward page="guest.jsp"/>