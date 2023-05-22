<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%-- contentType : 생성할 문서타입을 지정한다.(없으면 한글깨짐 꼭 있어야 함) --%>

<%
	//자바 코드 영역
	
	Calendar cal = Calendar.getInstance();
	String t = String.format("%tF %tA %tT", cal, cal, cal);
							//%tF :년-월-일  %tA:요일  %tT:시:분:초
	
	
	// 합 구하기 //자바주석
	int s = 0;
	for(int i=1; i<=100; i++){
		s += i;
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

<h3>간단한 JSP 예제</h3>

<!-- HTML 주석입니다. ->클라이언트에게 전송됨(페이지소스보기에서 보임) -->
<%-- JSP 주석입니다. --%>

<p>
	접속 날짜 및 시간은 <%= t %> 입니다.
</p>

<p>
	1부터 100까지 합은 <%= s %> 입니다.
</p>


</body>
</html>