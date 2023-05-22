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

<h3> submit 버튼 </h3>

<!-- 
	[submit 버튼 종류]
		<button>확인</button>
		<button type="submit">확인</button>
		<input type="submit" value="확인">
		<input type="image" src="btn_submit.gif">
		
	[submit 버튼 동작]
		submit 버튼은 <form>태그 안에 있어야 서버로 전송이 가능하다.

	[input 태그의 required, pattern 속성]
		<form>태그 안에 있어야 작동한다.	
	
	[reset 버튼 동작]
		input 요소의 내용을 value 속성값으로 설정하거나 value 속성이 없으면 지운다.
		reset 버튼은 <form>태그 안에 있어야 작동 한다.
		
 -->

<form action="ex02_ok.jsp" method="post">
	<p>이름 : <input type="text" name="name" required="required"></p>
	<p>나이 : <input type="text" name="age" required="required" pattern="\d+"></p>
	<p>
	
	<!-- submit : 서버로 전송할수있는기능 (아래는 서버로 보낼 수 있는 종류들) -->
		<button>확인</button> |
		<button type="submit">확인</button> |
		<input type="submit" value="확인"> |
		<input type="image" src="btn_submit.gif"> |
		
		<button type="button">일반버튼 - 서버전송불가</button> |
		<button type="reset">다시입력</button> |
	</p>
</form>


</body>
</html>