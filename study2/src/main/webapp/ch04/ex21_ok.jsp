<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%	
	//post방식은 인코딩하고 시작
	request.setCharacterEncoding("utf-8");
	
	String name = request.getParameter("name");
	String studentID = request.getParameter("studentID");
	String gender = request.getParameter("gender");
	String[] subject = request.getParameterValues("subject");
	String city = request.getParameter("city");
	String[] hobby = request.getParameterValues("hobby");
	
	String rSubject = "";
	String rHobby = "";
	
	if(subject != null){
		for(String s : subject){
			rSubject += s + " ";
		}
	}
	
	if(hobby != null){
		for(String s : hobby){
			rHobby += s + " ";
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

<p>이름 : <%=name%> </p>
<p>학번 : <%=studentID%> </p>
<p>성별 : <%=gender%> </p>
<p>좋아하는 과목 : <%=rSubject%> </p>
<p>출신도 : <%=city%> </p>
<p>취미 : <%=rHobby%> </p>

</body>
</html>