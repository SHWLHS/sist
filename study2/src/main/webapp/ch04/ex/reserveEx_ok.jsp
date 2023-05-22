<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String[] ss= request.getParameterValues("chks");
	String seatNum = "";
	if(ss != null){
		for(String s : ss){
			seatNum += s + " ";
		}
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>좌석 예약</h3>
<p>선택한 좌석 : <%=seatNum %></p>
</body>
</html>