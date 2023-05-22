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

.img-box img {
	cursor: pointer;

}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">

<script type="text/javascript">
<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
	function deletePhoto() {
	    if(confirm("게시글을 삭제 하시 겠습니까 ? ")) {
		    let query = "num=${dto.num}&page=${page}";
		    let url = "${pageContext.request.contextPath}/sphoto/delete.do?" + query;
	    	location.href = url;
	    }
	}
</c:if>

function imageViewer(src) {
	const $model = $("#myDialogModal .modal-body");
	let s="<img src='"+src+"' class='img-thumbnail w-100 h-100'>";
	$model.html(s);
	
	$("#myDialogModal").modal("show");
}
</script>

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
				
				<table class="table">
					<thead>
						<tr>
							<td colspan="2" align="center">
								${dto.subject}
							</td>
						</tr>
					</thead>
					
					<tbody>
						<tr>
							<td width="50%">
								이름 : ${dto.userName}
							</td>
							<td align="right">
								${dto.reg_date}
							</td>
						</tr>
						
						<tr>
							<td colspan="2" style="border-bottom: none;">
								<div class="row row-cols-6 img-box">
									<c:forEach var="vo" items="${listFile}">
										<div class="col p-1">
											<img src="${pageContext.request.contextPath}/uploads/sphoto/${vo.imageFilename}"
												class="img-thumbnail w-100 h-100" style="max-height: 130px;"
												onclick="imageViewer('${pageContext.request.contextPath}/uploads/sphoto/${vo.imageFilename}');">
										</div>
									</c:forEach>
								</div>
							</td>
						</tr>

						<tr>
							<td colspan="2">
								${dto.content}
							</td>
						</tr>
						
						<tr>
							<td colspan="2">
								이전글 :
								<c:if test="${not empty preReadDto}">
									<a href="${pageContext.request.contextPath}/sphoto/article.do?num=${preReadDto.num}&page=${page}">${preReadDto.subject}</a>
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								다음글 :
								<c:if test="${not empty nextReadDto}">
									<a href="${pageContext.request.contextPath}/sphoto/article.do?num=${nextReadDto.num}&page=${page}">${nextReadDto.subject}</a>
								</c:if>
							</td>
						</tr>
						
					</tbody>
				</table>
				
				<table class="table table-borderless">
					<tr>
						<td width="50%">
							<c:choose>
								<c:when test="${sessionScope.member.userId==dto.userId}">
									<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/sphoto/update.do?num=${dto.num}&page=${page}';">수정</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="btn btn-light" disabled="disabled">수정</button>
								</c:otherwise>
							</c:choose>
					    	
							<c:choose>
					    		<c:when test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
					    			<button type="button" class="btn btn-light" onclick="deletePhoto();">삭제</button>
					    		</c:when>
					    		<c:otherwise>
					    			<button type="button" class="btn btn-light" disabled="disabled">삭제</button>
					    		</c:otherwise>
					    	</c:choose>
						</td>
						<td class="text-end">
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/sphoto/list.do?page=${page}';">리스트</button>
						</td>
					</tr>
				</table>
				
			</div>
		</div>
	</div>
</main>

<!-- Modal -->
<div class="modal fade" id="myDialogModal" tabindex="-1" aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">이미지 뷰어</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
        
			</div>
		</div>
	</div>
</div>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>