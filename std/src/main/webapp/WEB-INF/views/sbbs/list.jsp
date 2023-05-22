<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
<style type="text/css">
.body-main {
	max-width: 700px;
}

.table-list thead > tr:first-child{ background: #f8f8f8; }
.table-list th, .table-list td { text-align: center; }
.table-list .left { text-align: left; padding-left: 5px; }

.table-list .num { width: 60px; color: #787878; }
.table-list .subject { color: #787878; }
.table-list .name { width: 100px; color: #787878; }
.table-list .date { width: 100px; color: #787878; }
.table-list .hit { width: 70px; color: #787878; }
.table-list .file { width: 50px; color: #787878; }
</style>
<script type="text/javascript">
function searchList() {
	const f = document.searchForm;
	f.submit();
}
</script>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>
	
<main>
	<div class="container body-container">
	    <div class="body-title">
			<h2><i class="fa-regular fa-square"></i> ${category == 1 ? "프로그래밍 강좌" : (category== 2 ? "데이터베이스 강좌" : "웹프로그래밍 강좌") } </h2>
	    </div>
	    
	    <div class="body-main mx-auto">
			<table class="table">
				<tr>
					<td width="50%">${dataCount }개(${page }/${total_page } 페이지)</td>
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
						<th class="file">첨부</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach var="dto" items="${list }" varStatus="status">	
						<tr>
							<td>${dataCount-(page-1)*size-status.index }</td>
							<td class="left"><a href="${articleUrl }&num=${dto.num}">${dto.subject }</a></td>
							<td>${dto.userName }</td>
							<td>${dto.reg_date }</td>
							<td>${dto.hitCount }</td>
							<td>
								<c:if test="${not empty dto.saveFilename }">
									<a href="${pageContext.request.contextPath }/sbbs/download.do?num=${dto.num}">
										<img src="${pageContext.request.contextPath }/resource/images/file.png"
											width="17" style="vertical-align: middle">
									
									</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
				
			</table>
			
			<div class="page-navigation">
				${dataCount == 0? "등록된 게시물이 없습니다.": paging }
			</div>
			
			<table class="table">
				<tr>
					<td width="100">
						<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/sbbs/list.do?category=${category}';" title="새로고침"><i class="fa-solid fa-arrow-rotate-right"></i></button>
					</td>
					<td align="center">
						<form name="searchForm" action="${pageContext.request.contextPath}/sbbs/list.do" method="post">
							<select name="condition" class="form-select">
								<option value="all"  ${condition=="all"? "selected='selected' ":"" }>제목+내용</option>
								<option value="userName" ${condition=="userName"? "selected='selected' ":"" }>작성자</option>
								<option value="reg_date" ${condition=="reg_date"? "selected='selected' ":"" }>등록일</option>
								<option value="subject" ${condition=="subject"? "selected='selected' ":"" }>제목</option>
								<option value="content" ${condition=="content"? "selected='selected' ":"" }>내용</option>
							</select>
							<input type="text" name="keyword" value="" class="form-control">
							<input type="hidden" name="category" value="${category }">
							<button type="button" class="btn" onclick="searchList();">검색</button>
						</form>
					</td>
					<td align="right" width="100">
						<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/sbbs/write.do?category=${category}';">글올리기</button>
					</td>
				</tr>
			</table>	

		</div>
	</div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>