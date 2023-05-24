<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.4/font/bootstrap-icons.css">

<style type="text/css">
*{ padding: 0; margin: 0; }
*, *::after, *::before { box-sizing: border-box; }

body { font-size: 14px; font-family: "Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif; }

textarea:focus, input:focus { outline: none; }
</style>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
$(function(){
	$(".btnClose").click(function(){
		$("#myDialogModal2").modal("hide");	
	});
});

//jquery로 대화상자 띄우기
$(function(){
	$(".btnDialog3").click(function(){
		$("#myDialogModal3").modal("show");
	});
});


$(function(){
	$(".btnDialog4").click(function(){
		$("#myDialogModal4").modal("show");
	});
});




</script>
</head>
<body>

<header>
	<div class="container-fluid mb-2 p-3 bg-success text-white">
		<h5>Modal dialog</h5>
	</div>
</header>
	
<main>
	<div class="container-fluid mb-2 p-2">
		<button type="button" class="btn btn-primary"
			data-bs-toggle="modal" data-bs-target="#myDialogModal">대화상자</button>
		<button type="button" class="btn btn-primary"
			data-bs-toggle="modal" data-bs-target="#myDialogModal2">대화상자 2</button>
		<button type="button" class="btn btn-primary btnDialog3">대화상자 3</button>
		<button type="button" class="btn btn-primary btnDialog4">대화상자 4</button>
	</div>
</main>

<footer>
</footer>

<!-- Modal : 일반 모달 대화상자. 대화상자 밖을 클릭하면 대화상자가 사라짐  -->
<div class="modal fade" id="myDialogModal" tabindex="-1" 
		aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">대화상자제목</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
        		<h4>대화상자</h4>
        		<p>대화상자 밖을 클릭하면 대화상자가 사라진다.</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary">등록하기</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal 2 : 대화상자 밖을 클릭해도 대화상자는 사라지지 않음 -->
<!-- data-bs-backdrop="static" data-bs-keyboard="false" 속성 -->
<div class="modal fade" id="myDialogModal2" tabindex="-1" 
		data-bs-backdrop="static" data-bs-keyboard="false"
		aria-labelledby="myDialogModalLabel2" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel2">대화상자제목</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
        		<h4>대화상자</h4>
        		<p>대화상자 밖을 클릭해도 대화상자는 사라지지 않는다.</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btnClose ">닫기</button>
				<button type="button" class="btn btn-primary">등록하기</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal 3 : 세로 중앙 대화상자 - modal-dialog-centered -->
<div class="modal fade" id="myDialogModal3" tabindex="-1" 
		aria-labelledby="myDialogModalLabel3" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel3">대화상자제목</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
        		<h4>대화상자</h4>
        		<p>세로 중앙 대화상자</p>
			</div>
		</div>
	</div>
</div>

<!-- Modal 4 : 스크롤 가능한 모달 - modal-dialog-scrollable -->
<div class="modal fade" id="myDialogModal4" tabindex="-1" aria-labelledby="myDialogModalLabel4" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel4">대화상자제목</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
        		<h4>대화상자</h4>
        		<div style="height: 650px;">
        			<p>스크롤 가능한 모달 입니다.</p>
        		</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>