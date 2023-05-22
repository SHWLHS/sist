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

<h2>JQuery AJAX : GET - $(selector).load()</h2>

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
		/*
		let n1 = $("#num1").val();
		let n2 = $("#num2").val();
		let op = $("#oper").val();

		let query = "num1=" + n1 + "&num2=" + n2 + "&oper=" + encodeURIComponent(op);
		*/
		
		//form태그이면서 name속성이 있으면 serialize()사용 가능(위에 방법과 동일)
		let query = $("form[name=calcForm]").serialize();//form태그 있어야 가능
		//console.log(query); //어떻게 나오는지 확인함
		
		let url = "ex01_ok.jsp?"+query;
		
		//AJAX - GET 방식
		$(".result-box").load(url);
		
	});
});
</script>




</body>
</html>