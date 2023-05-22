<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>표현식</h3>
<!-- 
	- 표현식
		: 자바 코드이 결과를 클라이언트에게 전송하기 위해 사용
		: 표현식은 out.print(코드); 형식으로 변환
		: 표현식은 서버측에서 실행되고 실행결과(문자열)을 클라이언트에게 전송한다.
 -->
 
<p>
	합 : <%= 1+2+3+4+5 %>
</p>

<p>
	<%
		//스크립 릿(scriptlet) : 자바 코드 영역
		int s = 10;
		String result = s % 2 == 0? "짝수" : "홀수";
	%>
	
	<%=s %>는 <%=result %> 입니다.
	

</p>


</body>
</html>