<%@page import="com.guest.GuestDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	request.setCharacterEncoding("utf-8");
	
	long num = Long.parseLong(request.getParameter("num"));
	String pageNum = request.getParameter("page");

	GuestDAO dao = new GuestDAO();
	
	dao.deleteGuest(num);
	
	response.sendRedirect("guest.jsp?page="+pageNum);
%>