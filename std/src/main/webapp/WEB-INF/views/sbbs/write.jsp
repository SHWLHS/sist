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
	padding-top: 15px;
}

.table-form td { padding: 7px 0; }
.table-form p { line-height: 200%; }
.table-form tr:first-child { border-top: 2px solid #212529;  }
.table-form tr > td:first-child { width: 110px; text-align: center; background: #f8f8f8; }
.table-form tr > td:nth-child(2) { padding-left: 10px; }

.table-form input[type=text], .table-form input[type=file], .table-form textarea {
	width: 96%; }
</style>

<script type="text/javascript">
function sendOk() {
    const f = document.boardForm;
	let str;
	
    str = f.subject.value.trim();
    if(!str) {
        alert("제목을 입력하세요. ");
        f.subject.focus();
        return;
    }

    str = f.content.value.trim();
    if(!str) {
        alert("내용을 입력하세요. ");
        f.content.focus();
        return;
    }

    f.action = "${pageContext.request.contextPath}/sbbs/${mode}_ok.do";
    f.submit();
}

<c:if test="${mode=='update'}">
	function deleteFile(num){
		if(confirm('파일을 삭제하시겠습니까? ')){
			let query = "category=${category}&num="+num+"&page=${page}";
			let url = "${pageContext.request.contextPath}/sbbs/deleteFile.do";
			location.href = url + "?" + query;
		}
	}
</c:if>

</script>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>
	
<main>
	<div class="container body-container">
	    <div class="body-title">
			<h2><i class="fa-regular fa-square"></i>${category == 1 ? "프로그래밍 강좌" : (category== 2 ? "데이터베이스 강좌" : "웹프로그래밍 강좌") }</h2>
	    </div>
	    
	    <div class="body-main mx-auto">
			<form name="boardForm" method="post" enctype="multipart/form-data">
				<table class="table table-border table-form">
					<tr> 
						<td>제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
						<td> 
							<input type="text" name="subject" maxlength="100" class="form-control" value="${dto.subject }">
						</td>
					</tr>
					
					<tr> 
						<td>작성자</td>
						<td> <!-- 작성자는 로그인한 상태이기때문에 session에서 가져옴(session을 member로 info값으로 저장, info안에 userName이 있음 -->
							<p>${sessionScope.member.userName}</p>
						</td>
					</tr>
					
					<tr> 
						<td valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
						<td> 
							<textarea name="content" class="form-control">${dto.content }</textarea>
						</td>
					</tr>
					
					<tr>
						<td>첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
						<td> 
							<input type="file" name="selectFile" class="form-control">
						</td>
					</tr>
					
					<c:if test="${mode == 'update' }">
						<tr>
							<td>첨부된파일</td>
							<td>
								<p>
									<c:if test="${not empty dto.saveFilename }">
										<a href="javascript:deleteFile(${dto.num})"><i class="far fa-trash-alt"></i></a>
										${dto.originalFilename }
									</c:if>
								</p>
							</td>
						</tr>
					</c:if>
				
					
				</table>
					
				<table class="table">
					<tr> 
						<td align="center">
							<button type="button" class="btn" onclick="sendOk();">${mode=="update" ? "수정완료":"등록완료" }</button>
							<button type="reset" class="btn">다시입력</button>
							<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/sbbs/list.do?category=${category}';">${mode=="update" ? "수정취소":"등록취소" }</button>
							<input type="hidden" name="category" value="${category}">
							<!-- 기존파일들을 넘겨주지 않으면 수정하면서 기존파일이 지워짐 -->
							<c:if test="${mode=='update' }">
								<input type="hidden" name="num" value="${dto.num }">
								<input type="hidden" name="saveFilename" value="${dto.saveFilename}">
								<input type="hidden" name="originalFilename " value="${dto.originalFilename }">
								<input type="hidden" name="fileSize" value="${dto.fileSize }">
								<input type="hidden" name="page" value="${page}">
							</c:if>
						</td>
					</tr>
				</table>
		
			</form>

	    </div>
	</div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>