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


<h3> 파라미터 전송 -POST 방식 </h3>

<pre>
	-post 방식은 파라미터를 body에 정보를 실어서 보냄
	-get 방식은 용량에 제한이 있지만 post는 용량에 제한이 없다.
	-post 방식은 form 태그에 method="post"에 의해 전송된다.
	-form 태그에서 method="post"로 전송하면 기본적으로
	 enctype="application/x=www-form-urlenceded" 이다.
	 application/x=www-form-urlenceded"는 정보를 주소형식으로 인코딩 해서 보낸다.
	-enctype 속성은 form 태그에서 method="post"에서만 유효하다.
</pre>

<form action="ex02_ok.jsp" method="post">
	<p>이름 : <input type="text" name="name"></p>
	<p>나이 : <input type="text" name="age" pattern="\d+"></p>
	<p>
		<button type="submit">확인</button>
	</p>
</form>



</body>
</html>