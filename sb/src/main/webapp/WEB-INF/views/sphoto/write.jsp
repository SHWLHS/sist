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

.img-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, 65px);
	grid-gap: 5px;
}

.img-grid .item {
    object-fit: cover; /* 가로세로 비율은 유지하면서 컨테이너에 꽉 차도록 설정 */
    width: 65px;
    height: 65px;
	cursor: pointer;
}

.img-box {
	max-width: 600px;

	box-sizing: border-box;
	display: flex; /* 자손요소를 flexbox로 변경 */
	flex-direction: row; /* 정방향 수평나열 */
	flex-wrap: nowrap;
	overflow-x: auto;
}
.img-box img {
	width: 65px; height: 65px;
	margin-right: 5px;
	flex: 0 0 auto;
	cursor: pointer;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">

<script type="text/javascript">
function sendOk() {
    const f = document.photoForm;
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

    var mode = "${mode}";
    if( (mode === "write") && (!f.selectFile.value) ) {
        alert("이미지 파일을 추가 하세요. ");
        f.selectFile.focus();
        return;
    }
    
    f.action = "${pageContext.request.contextPath}/sphoto/${mode}_ok.do";
    f.submit();
}

<c:if test="${mode=='update'}">
function deleteFile(fileNum) {
	if(! confirm("이미지를 삭제 하시겠습니까 ?")) {
		return;
	}
	
	let query = "num=${dto.num}&fileNum=" + fileNum + "&page=${page}";
	let url = "${pageContext.request.contextPath}/sphoto/deleteFile.do?" + query;
	location.href = url;
}
</c:if>

$(function(){
	var sel_files = [];
	
	$("body").on("click", ".write-form .img-add", function(event){
		$("form[name=photoForm] input[name=selectFile]").trigger("click"); 
	});
	
	$("form[name=photoForm] input[name=selectFile]").change(function(){
		if(! this.files) {
			let dt = new DataTransfer();
			for(let file of sel_files) {
				dt.items.add(file);
			}
			document.photoForm.selectFile.files = dt.files;
			
	    	return false;
	    }
	    
        for(let file of this.files) {
        	sel_files.push(file);
        	
            const reader = new FileReader();
			const $img = $("<img>", {class:"item img-item"});
			$img.attr("data-filename", file.name);
            reader.onload = e => {
            	$img.attr("src", e.target.result);
            };
			reader.readAsDataURL(file);
            
            $(".img-grid").append($img);
        }
		
		let dt = new DataTransfer();
		for(let file of sel_files) {
			dt.items.add(file);
		}
		document.photoForm.selectFile.files = dt.files;		
	    
	});
	
	$("body").on("click", ".write-form .img-item", function(event) {
		if(! confirm("선택한 파일을 삭제 하시겠습니까 ?")) {
			return false;
		}
		
		let filename = $(this).attr("data-filename");
		
	    for(let i = 0; i < sel_files.length; i++) {
	    	if(filename === sel_files[i].name){
	    		sel_files.splice(i, 1);
	    		break;
			}
	    }
	
		let dt = new DataTransfer();
		for(let file of sel_files) {
			dt.items.add(file);
		}
		document.photoForm.selectFile.files = dt.files;
		
		$(this).remove();
	});
});

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
				<form name="photoForm" method="post" enctype="multipart/form-data">
					<table class="table write-form mt-5">
						<tr>
							<td class="table-light col-sm-2" scope="row">제 목</td>
							<td>
								<input type="text" name="subject" class="form-control" value="${dto.subject}">
							</td>
						</tr>
	        
						<tr>
							<td class="table-light col-sm-2" scope="row">작성자명</td>
	 						<td>
								<p class="form-control-plaintext">${sessionScope.member.userName}</p>
							</td>
						</tr>
	
						<tr>
							<td class="table-light col-sm-2" scope="row">내 용</td>
							<td>
								<textarea name="content" id="content" class="form-control">${dto.content}</textarea>
							</td>
						</tr>
						
						<tr>
							<td class="table-light col-sm-2" scope="row">이미지</td>
							<td>
								<div class="img-grid"><img class="item img-add rounded" src="${pageContext.request.contextPath}/resources/images/add_photo.png"></div>
								<input type="file" name="selectFile" accept="image/*" multiple="multiple" style="display: none;" class="form-control">
							</td>
						</tr>
						
						<c:if test="${mode=='update'}">
							<tr>
								<td class="table-light col-sm-2" scope="row">등록이미지</td>
								<td> 
									<div class="img-box">
										<c:forEach var="vo" items="${listFile}">
											<img src="${pageContext.request.contextPath}/uploads/sphoto/${vo.imageFilename}"
												onclick="deleteFile('${vo.fileNum}');">
										</c:forEach>
									</div>
								</td>
							</tr>
						</c:if>
						
					</table>
					
					<table class="table table-borderless">
	 					<tr>
							<td class="text-center">
								<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
								<button type="reset" class="btn btn-light">다시입력</button>
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/sphoto/list.do';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
								<c:if test="${mode=='update'}">
									<input type="hidden" name="num" value="${dto.num}">
									<input type="hidden" name="page" value="${page}">
								</c:if>
							</td>
						</tr>
					</table>
				</form>
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