<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	//post 방식으로 넘어온 파라미터의 인코딩 설정(받기 전에 설정)
	request.setCharacterEncoding("utf-8");

	//String[] getParameterValues(이름) 
	//: get, post 방식으로 넘어온 파라미터 받아  String[]로 반환
	//:동일한 이름이 두개 이상인 파라미터, <select> 등에서 multiple 속성을 가진 요소는
	// 반드시 getParameterValues()로 받는다.
	
	String name = request.getParameterValues("name")[0];
	String pwd = request.getParameterValues("pwd")[0];
	String age = request.getParameterValues("age")[0];
	String gender = request.getParameterValues("gender")[0];
	String []ss = request.getParameterValues("subject");
		//checkbox, radio에서 선택된 항목이 없으면 null을 반환
		
	//null이 아니면 배열에있는거 출력
	String subject = "";
		if(ss !=null){
			for(String s : ss){
				subject += s +" ";
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


<h3>서버에서 파라미터 받기</h3>

<p> 이름 : <%=name %></p>
<p> 패스워드 : <%=pwd%></p>
<p> 성별 : <%=gender%></p>
<p> 나이 : <%=age %></p>
<p> 좋아하는과목 : <%=subject %></p>







</body>
</html>