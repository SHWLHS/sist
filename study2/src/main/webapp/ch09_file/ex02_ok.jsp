<%@page import="java.net.URLDecoder"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("utf-8"); //사실 의미 없음
	
	//form 데이터에서 enctype = "multipart/form-data"로 전송한 데이터는
	// request.getParameter("이름")으로 받을 수 없다.
	// String subject = request.getParameter("subejct"); //null

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>요청 받은 정보</h3>
<%
	String contentType = request.getContentType();
	out.print("<p>contentType : " + contentType + "</p>");
	out.print("<hr>");
	
	out.print("<h3>[헤더정보들]...</h3>");
	Enumeration<String> e = request.getHeaderNames();
	while(e.hasMoreElements()){
		String name = e.nextElement();
		String value = request.getHeader(name);
		out.print("<p>" + name + " : " + value + "</p>");
	}
	out.print("<hr>");
	
	out.print("<h3>[request body 영억으로 넘어온 데이터]...</h3>");
	
	InputStream is = request.getInputStream();
	byte[] buf = new byte[4096];
	
	int size;
	String str;
	
	while((size = is.read(buf)) != -1){
		//enctype = "application/x-www-form-urlencoded " 인 경우
		//str = new String(buf,0,size);
		//str = URLDecoder.decode(str,"utf-8");
		
		//enctype="multipart/form_data" 인 경우
		str = new String (buf,0,size,"utf-8");
		
		out.print("<p>" + str + "</p>");
	}
	out.print("<hr>");
	
%>

</body>
</html>