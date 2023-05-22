<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>파일 업로드</h3>

<%--
	-form 태그에서 enctype을 생략하면 기본이 application/x-www-form-urlencoded
	-application/x-www-form-urlencoded 속성 값은 파라미터를 주소형식으로 인코딩하여 전송
		파라미터는 "이름1=값1&이름2=값2" 형태로 body에 실어서 전송
	-application/x-www-form-urlencoded 속성 값에서 파일을 전송하면 파일은 파일이름만 전송됨
	-enctype은 method가 post인 경우만 유효
 --%>

<form action="ex01_ok.jsp" method="post">
	<p> 제목 : <input type="text" name="subject"></p>
	<p> 이름 : <input type="text" name="name"></p>
	<p> 파일 : <input type="file" name="selectFile"></p>
	<p>
		<button type="submit">등록하기</button>
	</p>
</form>


</body>
</html>