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



<form name="frm" action="ex04_ok.jsp" method="post">
	<p>이름 : <input type="text" name="name" ></p>
	<p>나이 : <input type="text" name="age" ></p>
	<p>
		<button type="submit">확인</button> |
		<button type="reset">다시입력</button> 
	</p>
</form>


<script type="text/javascript">
//submit버튼을 통해서 유효성 검사
function check(){
	const f = document.frm;
	
	if(! f.name.value){
		alert("이름을 입력하세요.")
		f.name.focus();
		return false;
	}
	
	 if(! /^\d+$/.test(f.age.value)){
		alert("나이는 숫자만 입력 가능합니다.")
		f.age.focus();
		return false;
	}
	 
	 //submit버튼으로 서버 전송하는 경우
	 // f.submit(); 처럼 submit()함수를 호출하면 두번 전송되므로 주의한다.
	 
	return true;
}
	
	document.addEventListener('submit', e => {
		if(! check()){//false이면
			e.preventDefault();//이벤트 취소
		}
	});
	


</script>

</body>
</html>