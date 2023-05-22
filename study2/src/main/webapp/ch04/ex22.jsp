<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script type="text/javascript">
function send(op){
	const f = document.frm;
	if(! /^\d+$/.test(f.num1.value)){
		f.num1.focus();
		return;
	}
	
	if(! /^\d+$/.test(f.num2.value)){
		f.num1.focus();
		return;
	}
	
	f.operator.value = op;
	
	
	f.submit();
}
</script>
</head>
<body>

<h3> hidden </h3>

<form name="frm" action="ex22_ok.jsp" method="post">
<p>
	<input type="text" name="num1" placeholder="첫번째수">
	<input type="text" name="num2" placeholder="두번째수">
	<input type="hidden" name="operator" >
</p>
<p>
	<button type="button" onclick="send('+')"> + </button>
	<button type="button" onclick="send('-')"> - </button>
	<button type="button" onclick="send('*')"> * </button>
	<button type="button" onclick="send('/')"> / </button>
</p>
</form>

</body>
</html>