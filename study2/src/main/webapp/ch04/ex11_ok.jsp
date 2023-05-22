<%@page import="java.net.URLDecoder"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> 클라이언트로 부터 요청(request) 받은 정보 </h3>

<%
	out.print("<p>method : " + request.getMethod()+"</p>");//get인지 post인지 알아내는것
	//get방식으로 넘어오는것을 Query String이라고 함
	out.print("<p>Query String(GET 방식 파라미터) : " + request.getQueryString()+ "</p>");
	out.print("<hr>");
	
	//헤더
	out.print("<p>[request로 넘어온 데이터(head 영역)]...</p>");
	Enumeration<String> e = request.getHeaderNames();//Enumeration : iterator랑 비슷한거
	while(e.hasMoreElements()){
		String name = e.nextElement();
		String value = request.getHeader(name);
		out.print("<p>" + name + " : " + value + "</p>");
		
	}
	out.print("<hr>");
	
	out.print("<p>[request로 넘어온 데이터(body영역 : post 파라미터)]...</p>");
	//클라이언트가 보낸 body 정보를 읽기 위한 입력 스트림
	InputStream is = request.getInputStream();
	byte[]b = new byte[4096];
	int size;
	String s;
	
	while((size=is.read(b)) != -1){
		s = new String(b,0,size);
		out.print("<p>디코딩 하지 않은 경우 : " + s + "</p>");
		
		s = URLDecoder.decode(s,"utf-8");
		out.print("<p>디코딩한경우 : " + s + "</p>");
	}
	out.print("<hr>");
%>


</body>
</html>