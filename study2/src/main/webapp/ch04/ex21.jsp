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

<h3> 폼 예제 </h3>



<form action="ex21_ok.jsp" method="post" name="myForm">
	<p> 이름 : <input type="text" name="name"> </p>
	<p> 학번 : <input type="text" name="studentID"> </p>
	<p> 성별 : 
		<input type="radio" name="gender" value="M" checked="checked">남자
		<input type="radio" name="gender" value="F" >여자
	</p>
	<p> 좋아하는 과목 : 
		<input type="text" name="subject">
		<input type="text" name="subject">
		<input type="text" name="subject">
	</p>
	<p> 출신도 : 
		<select name="city">
			<option value="">::선택::</option>
			<option value="서울">서울</option>
			<option value="경기">경기</option>
			<option value="인천">인천</option>
			<option value="기타">기타</option>
		</select>
	</p>
	<p>
		<span>취미<br></span>
		<select name="hobby" multiple="multiple" size="5">
			<option value="운동">운동하기 </option>
			<option value="영화">영화하기 </option>
			<option value="음악">음악듣기 </option>
			<option value="게임">게임하기 </option>
			<option value="요리">요리하기 </option>
		</select>
	</p>
	<p>
		<button>보내기</button>
	</p>
</form>



</body>
</html>