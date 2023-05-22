<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	request.setCharacterEncoding("utf-8");

	String []chks=request.getParameterValues("nums");
	String s ="";
	if(chks != null){
		for(String c : chks){
			s += c+ " ";
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
<p> 삭제할 게시물 번호 : <%=s%></p>


</body>
</html>