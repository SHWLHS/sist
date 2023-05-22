<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

/* board */
.board { margin: 30px auto; width: 700px; }

.title { width:100%; font-size: 16px; font-weight: bold; padding: 13px 0; }

.table-list thead > tr { background: #f8f9fa; }
.table-list th, .table-list td { text-align: center; }
.table-list td:nth-child(5n+2) { text-align: left; padding-left: 5px; }

.table-list .num { width: 60px; color: #787878; }
.table-list .subject { color: #787878; }
.table-list .name { width: 100px; color: #787878; }
.table-list .date { width: 100px; color: #787878; }
.table-list .hit { width: 70px; color: #787878; }

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
		<!-- url태그가 자동으로 cp도 붙혀주고 param태그가 인코딩도해줌 -->
<c:url var="listUrl" value="/bbs/list.do">
	<c:if test="${not empty keyword }">
		<c:param name="condition" value="${condition }"/>
		<c:param name="keyword" value="${keyword }"/>
	</c:if>
</c:url>

<!-- pageCount,pagingUrl 함수 paginate.js파일에서 불러오기 -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resource/js/paginate.js"></script>

<script type="text/javascript">
window.addEventListener("load",function(){
	let page = ${page};
	let pageSize = ${size};
	let dataCount = ${dataCount};
	let url = "${listUrl}";
	
	let total_page = pageCount(dataCount, pageSize);
	let paging = pagingUrl(page, total_page, url);
	document.querySelector(".dataCount").innerHTML =
		dataCount + '개 (' + page + '/' + total_page + '페이지)';
	document.querySelector(".page-navigation ").innerHTML =
		dataCount === 0 ? '등록된 게시물이 없습니다' : paging;
});


function searchList(){
	const f = document.searchForm;

	
	
	f.submit();
	
}


</script>
</head>
<body>

<div class="board">
	<div class="title">
	    <h3><span>|</span> 게시판</h3>
	</div>

	<table class="table">
		<tr>
			<td width="50%"><span class="dataCount"></span></td>
			<td align="right">&nbsp;</td>
		</tr>
	</table>
	
	<table class="table table-border table-list">
		<thead>
			<tr>
				<th class="num">번호</th>
				<th class="subject">제목</th>
				<th class="name">작성자</th>
				<th class="date">작성일</th>
				<th class="hit">조회수</th>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach var="dto" items="${list }" varStatus="status">
				<tr>
					<td>${dataCount-(page-1)*size-status.index }</td>
					<td>
						<!-- 자바가 아닌 jsp에서 글보기 주소 던져서 가기 -->
						<c:url var="url" value="/bbs/article.do">
							<c:param name="num" value="${dto.num }"/>
							<c:param name="page" value="${page }"/>
							<c:if test="${not empty keyword }">
								<c:param name="condition" value="${condition }"/>
								<c:param name="keyword" value="${keyword }"/>
							</c:if>
						</c:url>
						<a href="${url }">${dto.subject }</a>
					</td>
					<td>${dto.name }</td>
					<td>${dto.reg_date }</td>
					<td>${dto.hitCount }</td>
				</tr>
			</c:forEach>
		<tbody>
		
	</table>
	
	<div class="page-navigation"></div>
	
	<table class="table">
		<tr>
			<td width="100">
				<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/bbs/list.do';">새로고침</button>
			</td>
			<td align="center">
				<form name="searchForm" action="${pageContext.request.contextPath}/bbs/list.do" method="post">
					<select name="condition" class="form-select">
						<option value="all" ${condition == "all" ? "selected='selected'" : "" }>제목+내용</option>
						<option value="name" ${condition == "name" ? "selected='selected'" : "" }>작성자</option>
						<option value="reg_date" ${condition == "reg_date" ? "selected='selected'" : "" }>등록일</option>
						<option value="subject" ${condition == "subject" ? "selected='selected'" : "" }>제목</option>
						<option value="content" ${condition == "content" ? "selected='selected'" : "" }>내용</option>
					</select>
					<input type="text" name="keyword" value="${keyword }" class="form-control"><!-- form태그안에 input태그 1개(엔터치면 넘어감) -->
					<button type="button" class="btn" onclick="searchList();">검색</button>
				</form>
			</td>
			<td align="right" width="100">
				<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/bbs/write.do';">글올리기</button>
			</td>														<!-- html에서 주소는 cp를뺀 localhost9090까지 -->
		</tr>
	</table>	
</div>

</body>
</html>