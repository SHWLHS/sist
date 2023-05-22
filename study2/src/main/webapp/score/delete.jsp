<%@page import="com.score.ScoreDAOImpl"%>
<%@page import="com.score.ScoreDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>



<%
	request.setCharacterEncoding("utf-8");
	
	String hak = request.getParameter("hak");
	
	ScoreDAO dao = new ScoreDAOImpl();
	
	dao.deleteScore(hak);
	
	response.sendRedirect("list.jsp");
	
%>
	
	
	
