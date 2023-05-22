<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	//post 방식으로 넘어온 파라미터의 인코딩 설정(받기 전에 설정)
	request.setCharacterEncoding("utf-8");

	//String getParameter(이름) : get, post 방식으로 넘어온 파라미터 받기
	
	String name = request.getParameter("name");
	String pwd = request.getParameter("pwd");
	String age = request.getParameter("age");
	String gender = request.getParameter("gender");
	String city = request.getParameter("city");
		//존재하지 않는 파라미터는 null을 반환
	String subject = request.getParameter("subject");
		//동일한 이름으로 전송된 파라미터가 2개 이상인 경우 getParameter()는
		//	첫번째 파라미터만 넘겨 받는다.
		//동일한 이름으로 전송된 파라미터가 2개 이상인 경우 getParameterValues()로 받는다.
		//checkbox는 선택한 항목이 없으면 null을 반환한다.
		//name을 입력하지 않았으면 null이 아니라 ""(length=0)

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>


<h3>서버에서 파라미터 받기</h3>

<p> 이름 : <%=name %></p>
<p> 패스워드 : <%=pwd%></p>
<p> 성별 : <%=gender%></p>
<p> 나이 : <%=age %></p>
<p> 출신도 : <%=city %></p>
<p> 좋아하는과목 : <%=subject %></p>







</body>
</html>