<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
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

.container { margin: 20px auto; width: 500px; }

.title { width:100%; font-size: 16px; font-weight: bold; padding: 13px 0; }

.border-top { border-top: 1px solid #ced4da; }
.border-bottom { border-bottom: 1px solid #ced4da; }
</style>

</head>
<body>

<div class="container">
	<div class="title">
	    <h3><span>|</span> 꿈의 로또</h3>
	</div>

	<form name="lottoForm" action="lotto1_ok.jsp" method="post">
	<table class="table">
		<tr class="border-top border-bottom">
			<td colspan="10">
				* 로또 구매 갯수[1~5] : 
				<input type="text" name="cnt" size="5" class="form-control">
			</td>
		<tr>
		
		<tr class="border-bottom">
			<td colspan="10">
			   * 포함 할 수[최대 6개까지 추가 가능]
			</td>
		</tr>
		<%
			int n=0;
			for(int i=1; i<=5; i++) {
		%>
		<tr>
			<td>&nbsp;</td>
			<%
			for(int j=1; j<=9; j++) {
				n++;
			%>
			  <td align="right">
			      <label><%=n%></label>&nbsp;<input type="checkbox" name="chk" value="<%=n%>">
			  </td>
			<% } %>
		</tr>
		<% } %>
		
		<tr class="border-top">
			<td colspan="10">
				<button type="submit" class="btn">구매하기</button>
			</td>
		</tr>
	</table>  
	</form>
</div>

</body>
</html>