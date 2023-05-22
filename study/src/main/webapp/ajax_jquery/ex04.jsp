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

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

</head>
<body>

<h2>JQuery AJAX : $.ajax()</h2>

<form name="calcForm" >
	<input type="text" name="num1" id="num1">
	<select name="oper" id="oper">
		<option value="+">더하기</option>
		<option value="-">빼기</option>
		<option value="*">곱하기</option>
		<option value="/">나누기</option>
	</select>
	<input type="text" name="num2" id="num2">
	<button type="button" class="btnSend">결과</button>
</form>
<hr>
<div class="result-box"></div>

<script type="text/javascript">
$(function(){//밑에 있어서 없어도 되지만 혹시 몰라서 넣어놓음(onload 이벤트역할)
	$(".btnSend").click(function(){
		
		let n1 = $("#num1").val();
		let n2 = $("#num2").val();
		let op = $("#oper").val();
		
		let url ="ex04_ok.jsp";
		
		$.ajax({
			type : "post",//메소드방식
			url : url,//서버주소
			data : {num1:n1, num2:n2, oper:op},//서버로보내는 데이터
			success : function(data){//성공했을때
				$(".result-box").html(data);
			},
			error : function(e){
				console.log(e.status); //에러 상태코드(404,500 등)
				console.log(e.responseText);//에러메시지
			}
		});
		
	});
});
</script>




</body>
</html>