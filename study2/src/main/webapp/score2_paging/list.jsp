<%@page import="com.util.MyUtil"%>
<%@page import="com.score.ScoreDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.score.ScoreDAOImpl"%>
<%@page import="com.score.ScoreDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");

	ScoreDAO dao = new ScoreDAOImpl();
	
	MyUtil util = new MyUtil();
	
	// 파라미터로 넘어온 페이지 번호 받기
	String pageNum = request.getParameter("page");
	int current_page =1; //페이지 번호가 넘어오지 않으면 1페이지 출력
	if(pageNum != null){
		current_page = Integer.parseInt(pageNum);
	}
	
	//전체 데이터 개수
	int dataCount = dao.dataCount();
	
	//전체 페이지 수 
	int size = 3;
	int total_page = util.pageCount(dataCount, size);//전체페이지수
	
	//웹은 정적이므로 마지막 페이지의 모든 데이터가 삭제되어도 감지하지 못함
	if(current_page > total_page){
		current_page = total_page;
	}
	
	// 건너뛸 개수
	int offset = (current_page -1)*size;
	if(offset < 0) offset=0;
	
	List<ScoreDTO> list = dao.listScore(offset, size);
	
	//페이징 처리
	String listUrl = "list.jsp";
	
	String paging = util.paging(current_page, total_page, listUrl);
			
	
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

/* container */
.container { width: 800px; margin: 30px auto; }

.title { width:100%; font-size: 16px; font-weight: bold; padding: 13px 0; }

.table-list thead > tr { background: #f8f9fa; }
.table-list td, .table-list th { border: 1px solid #ced4da; }
.table-list td { text-align: center; padding-top: 3px; padding-bottom: 3px; }

/* paginate */
.page-navigation { clear: both; padding: 20px 0; text-align: center; }

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
	const f = document.listForm;
	const els = f.querySelectorAll("input[name=haks]");
	
	for(let e of els){
		e.checked = f.chkAll.checked;
	}

}
	
function deleteList() {
	const f = document.listForm;
	let cnt = f.querySelectorAll("input[name=haks]:checked").length;
	
	if(cnt === 0) {
		alert("삭제할 게시물을 먼저 선택하세요");
		return;
	}
	
	//삭제후 list.jsp로 리다이렉트 함
	if( confirm("선택한 학생 정보를 삭제하시겠습니까 ? ") ) {
		f.action = "deleteList.jsp";
		f.submit();
	}
}

function updateScore(hak) {
	let url = "update.jsp?hak=" + hak + "&page=<%=current_page%>";
	location.href=url;
}

function deleteScore(hak) {
	if(confirm("학생 정보를 삭제 하시겠습니까?")){
		let url = "delete.jsp?hak="+hak + "&page=<%=current_page%>";
		location.href = url;
	}
}
</script>

</head>
<body>

<div class="container">
	<div class="title">
	    <h3><span>|</span> 성적처리</h3>
	</div>
	
	<table class="table">
		<tr>
			<td align="left" width="50%">
				<button type="button" class="btn" onclick="deleteList();">삭제</button>
			</td>
			<td align="right">
				<button type="button" class="btn" onclick="location.href='write.jsp';">등록하기</button>
			</td>
		</tr>
	</table>
		
	<form name="listForm" method="post">
	<table class="table table-list">
		<thead>
			<tr>
				<th width="35">
					<input type="checkbox" name="chkAll" value="all" onclick="check();">
				</th>
				<th width="100">학번</th>
				<th width="110">이름</th>
				<th width="110">생년월일</th>
				<th width="60">국어</th>
				<th width="60">영어</th>
				<th width="60">수학</th>
				<th width="60">총점</th>
				<th width="60">평균</th>
				<th>변경</th>
			</tr>
		</thead>

		<tbody>
			<% for(ScoreDTO dto:list)  { %>
			<tr>
				<td>
					<input type="checkbox" name="haks" value="<%=dto.getHak()%>">
				</td>
				<td><%=dto.getHak()%></td>
				<td><%=dto.getName()%></td>
				<td><%=dto.getBirth()%></td>
				<td><%=dto.getKor()%></td>
				<td><%=dto.getEng()%></td>
				<td><%=dto.getMat()%></td>
				<td><%=dto.getTot()%></td>
				<td><%=dto.getAve()%></td>
				<td>
					<input type="button" value="수정" onclick="updateScore('<%=dto.getHak()%>')" class="btn">
					<input type="button" value="삭제" onclick="deleteScore('<%=dto.getHak()%>')" class="btn">
				</td>
			</tr>
			<% } %>
			
		</tbody>

	</table>
	<input type="hidden" name="page" value="<%=current_page%>">
	</form>
	
	<div class="page-navigation">
		<%= dataCount ==0 ? "등록된 자료가 없습니다." : paging %>
	</div>
</div>

</body>
</html>