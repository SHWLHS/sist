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

<h3> 일반 버튼으로 submit </h3>



<form name="frm" method="post">
	<p>이름 : <input type="text" name="name" ></p>
	<p>나이 : <input type="text" name="age" ></p>
	<p>
		<button type="button" onclick="sendOk();">확인</button> |
		<button type="reset">다시입력</button> 
	</p>
</form>


<script type="text/javascript">
//submit버튼을 통해서 유효성 검사
function sendOk(){
	const f = document.frm;
	
	if(! f.name.value){
		alert("이름을 입력하세요.")
		f.name.focus();
		return;
	}
	
	 if(! /^\d+$/.test(f.age.value)){
		alert("나이는 숫자만 입력 가능합니다.")
		f.age.focus();
		return;
	}
	 
	//action을 form태그에서 꼭 줄필요 없음.
	f.action = "ex05_ok.jsp";
	f.submit(); // 일반버튼등을 이용하여 form의 내용을 서버로 전송
	
	
}

</script>

</body>
</html>