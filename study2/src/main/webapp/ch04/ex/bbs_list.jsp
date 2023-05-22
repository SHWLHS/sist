<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
	
	int size = 10;
	String rows = request.getParameter("size");
	if(rows != null){
		size = Integer.parseInt(rows);
	}



%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.3.0/css/all.css">

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

.board { margin: 30px auto; width: 700px; }

.title { width:100%; font-size: 16px; font-weight: bold; padding: 13px 0; }

.table-list thead > tr { background: #f8f9fa; }
.table-list th, .table-list td { text-align: center; }
.table-list td:nth-child(6n+3) { text-align: left; padding-left: 5px; }

.table-list .chk { width: 40px; color: #787878; }
.table-list .num { width: 60px; color: #787878; }
.table-list .subject { color: #787878; }
.table-list .name { width: 100px; color: #787878; }
.table-list .date { width: 100px; color: #787878; }
.table-list .hit { width: 70px; color: #787878; }

.page-navigation {
	clear: both;
	padding: 20px 0;
	text-align: center;
}

.paginate {
	text-align: center;
	white-space: nowrap;
	font-size: 14px;	
}
.paginate a {
	border: 1px solid #ccc;
	color: #000;
	font-weight: 600;
	text-decoration: none;
	padding: 3px 7px;
	margin-left: 3px;
	vertical-align: middle;
}
.paginate a:hover, .paginate a:active {
	color: #6771ff;
}
.paginate span {
	border: 1px solid #e28d8d;
	color: #cb3536;
	font-weight: 600;
	padding: 3px 7px;
	margin-left: 3px;
	vertical-align: middle;
}
.paginate :first-child {
	margin-left: 0;
}
</style>

<script type="text/javascript">
function check() {
	const chk = document.querySelector("#chkAll");
	const nums = document.querySelectorAll("form input[name=nums]");
/*	
	for(let el of nums){
		el.checked = chk.checked; //checked는 ture , false반환
	}
*/
	nums.forEach(el => el.checked = chk.checked)
	
	
}

function deleteList() {

	const f = document.listForm;
	const chk = document.querySelectorAll("form input[name=nums]:checked");
	
	if(chk.length === 0){
		alert('삭제할 게시물을 선택하세요');
		return;
	}
	
	if(confirm('선택한 게시글을 삭제하시겠습니까 ?')){
		f.action = 'deleteList.jsp';
		f.submit();
	}
	
}

function searchList() {
	
	
}

function changeList() {
	const size = document.querySelector("#size").value;
	location.href="bbs_list.jsp?size="+size;
	
	
}

</script>

</head>
<body>

<div class="board">

	<div class="title">
	    <h3><i class="fa-regular fa-clipboard"></i> 게시판</h3>
	</div>

	<form name="listForm" method="post">
	<table class="table">
	   <tr>
		  <td align="left" width="50%">
		  	<button type="button" class="btn" onclick="deleteList();">삭제</button>
		  </td>
		  <td align="right">
			 <select name="size" id="size" class="form-select" onchange="changeList();">
				   <option value="5" <%=size ==5? "selected='selected' ": "" %>>5개씩 출력</option>
				   <option value="10" <%=size ==10? "selected='selected' ": "" %>>10개씩 출력</option>
				   <option value="20" <%=size ==20? "selected='selected' ": "" %>>20개씩 출력</option>
				   <option value="30" <%=size ==30? "selected='selected' ": "" %>>30개씩 출력</option>
				   <option value="50" <%=size ==50? "selected='selected' ": "" %>>50개씩 출력</option>
			 </select>
		  </td>
	   </tr>
	</table>

	<table class="table table-border table-list">
	<thead>
		<tr> 
			<th class="chk">
				<input type="checkbox" name="chkAll" id="chkAll" onclick="check();">        
			</th>
			<th class="num">번호</th>
			<th class="subject">제목</th>
			<th class="name">작성자</th>
			<th class="date">작성일</th>
			<th class="hit">조회수</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><input type="checkbox" name="nums" value="3"></td> 
			<td>3</td>
			<td>
				<a href="">HTML 강좌...</a>
			</td>
			<td>홍길동</td>
			<td>2021-03-10</td>
			<td>1</td>
		</tr>

		<tr>
			<td><input type="checkbox" name="nums" value="2"></td> 
			<td>2</td>
			<td>
				<a href="">CSS 강좌...</a>
			</td>
			<td>스타일</td>
			<td>2021-03-03</td>
			<td>1</td>
		</tr>

		<tr> 
			<td><input type="checkbox" name="nums" value="1"></td> 
			<td>1</td>
			<td>
				<a href="">자바 강좌...</a>
			</td>
			<td>김자바</td>
			<td>2021-01-10</td>
			<td>1</td>
		</tr>
	</tbody>
	</table>
	</form>
	
	<table class="table">
		<tr height="50">
			<td align="center">
				<div class="paginate">
					<span>1</span>
					<a href="#">2</a>
					<a href="#">3</a>
				</div>
			</td>
	   </tr>
	</table>

	<table class="table">
		<tr height="45">
			<td width="100">
				<button type="button" class="btn">새로고침</button>
			</td>
			<td align="center">
				<form name="searchForm" action="" method="post">
					<select name="condition" class="form-select">
						<option value="all">제목+내용</option>
						<option value="name">작성자</option>
						<option value="reg_date">등록일</option>
						<option value="subject">제목</option>
						<option value="content">내용</option>
					</select>
					<input type="text" name="keyword" value="" class="form-control">
					<button type="button" class="btn" onclick="searchList()">검색</button>
				</form>
			</td>
			<td align="right" width="100">
				<button type="button" class="btn">글올리기</button>
			</td>
		</tr>
	</table>
</div>

</body>
</html>