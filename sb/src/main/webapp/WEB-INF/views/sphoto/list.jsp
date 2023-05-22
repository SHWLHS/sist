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
				<h3><i class="bi bi-images"></i> 포토 앨범 </h3>
			</div>
			
			<div class="body-main">
		        <div class="row board-list-header">
		            <div class="col-auto me-auto">
		            	<p class="form-control-plaintext">
		            		${dataCount}개(${page}/${total_page} 페이지)
		            	</p>
		            </div>
		            <div class="col-auto">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/sphoto/write.do';">사진올리기</button>
					</div>
		        </div>
		        
				<div id="carouselImageCaptions" class="carousel slide" data-bs-ride="carousel">
					<div class="carousel-indicators">
						<c:forEach var="dto" items="${list}" varStatus="status">
							<button type="button" data-bs-target="#carouselImageCaptions" data-bs-slide-to="${status.index}" class="${status.index==0?'active':''}" aria-current="true" aria-label="${dto.subject}"></button>
						</c:forEach>
					</div>
					
					<div class="carousel-inner">
						<c:forEach var="dto" items="${list}" varStatus="status">
							<div class="carousel-item ${status.index==0?'active':''}">
								<a href="${articleUrl}&num=${dto.num}">
									<img src="${pageContext.request.contextPath}/uploads/sphoto/${dto.imageFilename}"
										 class="d-block w-100" style="max-height: 450px;">
								</a>
								<div class="carousel-caption d-none d-md-block">
									<h5>${dto.subject}</h5>
								</div>
							</div>
						</c:forEach>
					</div>
					
					<button class="carousel-control-prev" type="button" data-bs-target="#carouselImageCaptions" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button" data-bs-target="#carouselImageCaptions" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>					
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