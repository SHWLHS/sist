<%@page import="com.guest.GuestDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.util.MyUtil"%>
<%@page import="com.guest.GuestDAO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
	
	GuestDAO dao = new GuestDAO();
	
	MyUtil util = new MyUtil();
	
	String pageNum = request.getParameter("page");
	int current_page = 1;
	if(pageNum != null){
		current_page = Integer.parseInt(pageNum);
	}
	
	int dataCount = dao.dataCount();
	
	int size = 3;
	int total_page = util.pageCount(dataCount, size);
	
	if(current_page > total_page){
		current_page = total_page;
	}
	
	int offset = (current_page -1)*size;
	if(offset <0) offset=0;
	
	List<GuestDTO> list = dao.listGuest(offset, size);
	String s;
	for(GuestDTO dto : list){
		s = dto.getContent().replaceAll("\n","<br>");
		dto.setContent(s);
	}
	
	String guestUrl = "guest.jsp";
	
	String paging = util.paging(current_page, total_page, guestUrl);
			
	long num;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>study</title>
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

/* guest */
.guest-container { margin: 30px auto; width: 600px; }

.title { width:100%; font-size: 16px; font-weight: bold; padding: 13px 0; }

.table-form td { padding: 7px 0; }
.table-form tr:first-child {  border-top: 2px solid #212529; }
.table-form tr > td:first-child { width: 100px; text-align: center; background: #f8f9fa; }
.table-form tr > td:nth-child(2) { padding-left: 10px; }
.table-form input[type=text], .table-form input[type=file], .table-form textarea { width: 97%; }
.table-form textarea { height: 75px; }

.guest-list { margin-top: 10px; table-layout:fixed; word-break:break-all; }
.guest-list tr:nth-child(2n+1) { border: 1px solid #d5d5d5; background: #f8f9fa; } 
.guest-list td { padding-left: 7px; padding-right: 7px; }

.right { text-align: right; padding-right: 10px; }

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
</head>

<script type="text/javascript">
function deleteguest(num1){
	if(confirm("게시물을 삭제 하시겠습니까?")){
		let url = "delete.jsp?num="+num1+"&page=<%=current_page%>"
		location.href= url;
	}
	
}
	
</script>

<body>

<div class="guest-container">
	<div class="title">
	    <h3><span>|</span> 방명록</h3>
	</div>
	
	<form name="guestForm" method="post" action="guest_ok.jsp">
		<table class="table table-border table-form">
			<tr> 
				<td>작성자</td>
				<td> 
					<input type="text" name="name" maxlength="20" class="form-control" required="required">
				</td>
			</tr>
	  
			<tr> 
				<td valign="top">내&nbsp;&nbsp;&nbsp;용</td>
				<td valign="top"> 
					<textarea name="content" class="form-control" required="required"></textarea>
				</td>
			</tr>
		</table>
	
		<table class="table">
			<tr> 
				<td class="right">
					<button type="submit" class="btn">등록하기</button>
					<button type="reset" class="btn">다시입력</button>	  
				</td>
			</tr>
		</table>
	</form>
	
	<% for(GuestDTO dto : list) { %>
	<table class="table guest-list">
		<tr>
			<td width="50%">
				<span style="font-weight: 600"><%=dto.getName() %></span>
			</td>
			<td width="50%" align="right">
				<%=dto.getReg_date() %> | <a onclick="deleteguest(<%=dto.getNum()%>);">삭제</a>
				
			</td>
		</tr>
		<tr>
			<td colspan="2" valign="top"><%=dto.getContent() %></td>
		</tr>
	</table>
	<% } %>
	
	<div class="page-navigation">
		<%=dataCount ==0 ? "등록된 게시글이 없습니다.":paging %>
	</div>
	
</div>

</body>
</html>
