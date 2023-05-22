<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");

	String[] nn = request.getParameterValues("itemRight");
	String msg = request.getParameterValues("msg")[0];
	
	String name = "";
	if(nn != null){
		for(String n : nn){
			name += n +" ";
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

<h3>요청 받은 메시지 정보</h3>

<p>받는사람 : <%=name %> </p>
<div style="white-space: pre;">내용 : <%=msg %></div>

</body>
</html>