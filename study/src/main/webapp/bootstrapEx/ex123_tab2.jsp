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

<style type="text/css">
.nav-tabs .nav-link{
	min-width: 170px;
	background: #f3f5f7;
	border-radius: 0;
	border-right: 1px solid #dbdddf;
	color: #333333;
	font-weight: 600;
}

.nav-tabs .nav-link.actice{
	background: #3d3d4f;
	color: #ffffff;
}

.tab-pane{
	padding: 5px;
	min-height: 300px;
}


</style>


<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">

$(function(){
	$("#nav-1").load("ex.jsp");//실행과 동시에 서버에 AJAX로 출력할 내용 가져오기
	
	//탭을 클릭할 경우
	$("button[role='tab']").on("click", function(){
		const tab = $(this).attr("aria-controls");
		let selector = "#nav-" + tab;
		
		let url = "ex.jsp";
		if(tab == "1"){
			url = "ex.jsp";
		}else if(tab === "2"){
			url = "ex2.jsp";
		}else if (tab === "3"){
			url = "ex3.jsp";
		}
		
		$(selector).load(url); // AJAX로 각 주소별로 서버에서 출력할 내용 가져오기
		
	});
	
	$("button[role='tab']").on("show.bs.tab", function(){
		//탭이 변경 될때 마다 실행
		const tab = $(this).attr("aria-controls");
		
	});
	
	
});


</script>
</head>
<body>

<header>
	<div class="container-fluid mb-3 p-3 bg-secondary text-white">
		<h5>Tab 예제</h5>
	</div>
</header>
	
<main>
	<div class="container mb-2 pt-3">

		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="tab-1" data-bs-toggle="tab" data-bs-target="#nav-1" type="button" role="tab" aria-controls="1" aria-selected="true">첫번째</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="tab-2" data-bs-toggle="tab" data-bs-target="#nav-2" type="button" role="tab" aria-controls="2" aria-selected="true">두번째</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="tab-3" data-bs-toggle="tab" data-bs-target="#nav-3" type="button" role="tab" aria-controls="3" aria-selected="true">세번째</button>
			</li>
		</ul>

		<div class="tab-content pt-2" id="nav-tabContent">
			<div class="tab-pane fade show active" id="nav-1" role="tabpanel" aria-labelledby="nav-tab-1">
			</div>
			<div class="tab-pane fade" id="nav-2" role="tabpanel" aria-labelledby="nav-tab-2">
			</div>
			<div class="tab-pane fade" id="nav-3" role="tabpanel" aria-labelledby="nav-tab-2">
			</div>
		</div>

	</div>
</main>

<footer>
</footer>

</body>
</html>