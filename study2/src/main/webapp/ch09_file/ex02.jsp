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
	- form 태그에서 enctype="multipart/form-data" 인 경우
		: 주소 형식으로 인코딩하지 않고 전송
		: 파일을 전송할 때 사용
		: 파일의 내용도 전송 된다.
	- enctype은 method가 post인 경우만 유효하다.
 --%>

<form action="ex02_ok.jsp" method="post" enctype="multipart/form-data">
	<p> 제목 : <input type="text" name="subject"></p>
	<p> 이름 : <input type="text" name="name"></p>
	<p> 파일 : <input type="file" name="selectFile"></p>
	<p>
		<button type="submit">등록하기</button>
	</p>
</form>


</body>
</html>