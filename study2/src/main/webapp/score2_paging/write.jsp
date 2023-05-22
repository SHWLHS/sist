<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
* { padding: 0; margin: 0; }
*, *::after, *::before { box-sizing: border-box; }

body {
	font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
	font-size: 14px;
	color: #222;
}

a { color: #222; text-decoration: none; cursor: pointer; }
a:active, a:hover { color: #f28011; text-decoration: underline; }

/* form-control */
.btn {
	color: #333;
	border: 1px solid #999;
	background-color: #fff;
	padding: 5px 10px;
	border-radius: 4px;
	font-weight: 500;
	cursor:pointer;
	font-size: 14px;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	vertical-align: baseline;
}
.btn:active, .btn:focus, .btn:hover {
	background-color: #f8f9fa;
	color:#333;
}
.btn[disabled], fieldset[disabled] .btn {
	pointer-events: none;
	cursor: default;
	opacity: .65;
}

.form-control {
	border: 1px solid #999; border-radius: 4px; background-color: #fff;
	padding: 5px 5px; 
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	vertical-align: baseline;
}
.form-control[readonly] { background-color:#f8f9fa; }

textarea.form-control { height: 170px; resize : none; }

.form-select {
	border: 1px solid #999; border-radius: 4px; background-color: #fff;
	padding: 4px 5px; 
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	vertical-align: baseline;
}
.form-select[readonly] { background-color:#f8f9fa; }

textarea:focus, input:focus { outline: none; }
input[type=checkbox], input[type=radio] { vertical-align: middle; }

/* table */
.table { width: 100%; border-spacing: 0; border-collapse: collapse; }
.table th, .table td { padding-top: 10px; padding-bottom: 10px; }

.table-border thead > tr { border-top: 2px solid #212529; border-bottom: 1px solid #ced4da; }
.table-border tbody > tr { border-bottom: 1px solid #ced4da; }
.table-border tfoot > tr { border-bottom: 1px solid #ced4da; }
.td-border td { border: 1px solid #ced4da; }

/* container */
.container { width: 500px; margin: 30px auto; }

.title { width:100%; font-size: 16px; font-weight: bold; padding: 13px 0; }

.table-form td { padding: 7px 0; }
.table-form tr:first-child { border-top: 2px solid #212529; }
.table-form tr > td:first-child { text-align: center; background: #f8f9fa; width: 100px; }
.table-form tr > td:nth-child(2) { padding-left: 10px; }
.table-form input[type=text], .table-form input[type=date] { width: 96%; }

.info-box { padding: 10px 0; text-align: center; color: blue; }
</style>

</head>
<body>

<div class="container">
	<div class="title">
	    <h3><span>|</span> 성적처리</h3>
	</div>

	<form action="write_ok.jsp" method="post">
		<table class="table table-border table-form">
		<tr>
			<td>학 번</td>
			<td>
				<input type="text" name="hak" class="form-control" maxlength="10" required="required" pattern="\w{1,10}">
			</td>
		</tr>
		
		<tr>
			<td>이 름</td>
			<td>
				<input type="text" name="name" class="form-control" maxlength="10" required="required">
			</td>
		</tr>
		
		<tr>
			<td>생년월일</td>
			<td>
				<input type="date" name="birth" class="form-control" maxlength="10" required="required">
			</td>
		</tr>
		
		<tr>
			<td>국 어</td>
			<td>
				<input type="text" name="kor" class="form-control" required="required" pattern="\d{1,3}">
			</td>
		</tr>
		
		<tr>
			<td>영 어</td>
			<td>
				<input type="text" name="eng" class="form-control" required="required" pattern="\d{1,3}">
			</td>
		</tr>
		
		<tr>
			<td>수 학</td>
			<td>
				<input type="text" name="mat" class="form-control" required="required" pattern="\d{1,3}">
			</td>
		</tr>
		</table>
		
		<table class="table">
		<tr>
			<td align="center">
				<input type="submit" value=" 등록완료 " class="btn">	
				<input type="reset" value=" 다시입력 " class="btn">	
				<input type="button" value=" 등록취소 " class="btn" onclick="location.href='list.jsp';">	
			</td>
		</tr>
		</table>
	</form>
	
	<table class="table">
		<tr>
			<td align="center">${msg}</td>
		</tr>
	</table>
	
</div>

</body>
</html>