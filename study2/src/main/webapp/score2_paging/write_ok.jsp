<%@page import="java.sql.SQLException"%>
<%@page import="com.score.ScoreDAOImpl"%>
<%@page import="com.score.ScoreDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="dto" class="com.score.ScoreDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%
	
	ScoreDAO dao = new ScoreDAOImpl();
	
	String s ="";

	try{ //기본키중복되면 터져서 try~catch문 설정(에러뜨면 백지상태))
		
		dao.insertScore(dto);
		response.sendRedirect("list.jsp");//sendRedirect 안하면 데이터가 중복으로 들어갈수있다.
		return;
			
	}catch(SQLException e){
		if(e.getErrorCode() == 1){
			s = "["+dto.getHak()+"] 학번은 등록된 학번입니다."; 
		}else{
			s = "자료 등록이 실패 했습니다.";
		}

		request.setAttribute("msg", s);
	}
	
	
%>
	<jsp:forward page="write.jsp"/>
	
	