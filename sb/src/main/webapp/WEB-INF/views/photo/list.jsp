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
.body-container {
	max-width: 800px;
}

.item {
	min-height: 230px;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
	
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3><i class="bi bi-image"></i> 포토 갤러리 </h3>
			</div>
			
			<div class="body-main">
		        <div class="row board-list-header">
		            <div class="col-auto me-auto">
		            	<p class="form-control-plaintext">
		            		${dataCount}개(${page}/${total_page} 페이지)
		            	</p>
		            </div>
		            <div class="col-auto">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/photo/write.do';">사진올리기</button>
					</div>
		        </div>				
				
				 <div class="row">
				 	<c:forEach var="dto" items="${list}" varStatus="status">
				 		<div class="col-md-4 col-lg-3 p-1 item">
				 			<a href="${articleUrl}&num=${dto.num}" title="${dto.subject}">
				 				<img class="img-fluid img-thumbnail w-100 h-100" src="${pageContext.request.contextPath}/uploads/photo/${dto.imageFilename}">
				 			</a>
						</div>
				 	</c:forEach>
				 </div>
				
				<div class="page-navigation">
					${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
				</div>

			</div>
		</div>
	</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>