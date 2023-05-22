<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	String method = request.getMethod();
	String scheme = request.getScheme();
	String cp = request.getContextPath();//getContextPath: 문맥경로 , /study2
	String uri = request.getRequestURI();//URI : /study2/ch04/ex32_ok.jsp
	String url = request.getRequestURL().toString();
		//URL : http://localhost:9090/study2/ch04/ex32_ok.jsp
		// getRequestURL() : 리턴타입이 StringBuffer 여서 String으로 형변환 해줘야함
	String query = request.getQueryString();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p>요청방식(method) : <%=method %></p>
<p>scheme : <%=scheme%></p>
<p>Context path : <%=cp %></p>
<p>URI : <%=uri %></p>
<p>URL : <%=url %></p>
<p>QueryString: <%=query %></p>


</body>
</html>