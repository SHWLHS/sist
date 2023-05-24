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

<style type="text/css">
.box {
	border: 1px solid #ccc;
	margin: 10px auto;
	padding: 20px;
	max-width: 800px;
}
</style>

</head>
<body>

<header>
	<div class="container-fluid mb-2 p-3 bg-dark text-white">
		<h5>align</h5>
	</div>
</header>
	
<main>
	<div class="container mb-3">
		<div class="box">
			<p> 문자열 정렬 </p>
			<div class="row">
				<div class="col border bg-light p-3 text-start ">
					왼쪽
				</div>
				<div class="col border bg-light p-3 text-center ">
					가운데
				</div>
				<div class="col border bg-light p-3 text-end ">
					오른쪽
				</div>
			</div>
	  	</div>
		<hr>
		
		<p> 블록 태그의 수직 정렬 : flexbox 유틸리티 사용 </p>
		<div class="box">
			<div class="d-flex flex-wrap align-content-start" style="height: 100px;">
				<div class="border bg-light p-2">
					위쪽
				</div>
			</div>
	  	</div>
		<div class="box">
			<div class="d-flex flex-wrap align-content-center" style="height: 100px;">
				<div class="border bg-light p-2">
					가운데
				</div>
			</div>
	  	</div>
		<div class="box">
			<div class="d-flex flex-wrap align-content-end" style="height: 100px;">
				<div class="border bg-light p-2">
					아래쪽
				</div>
			</div>
	  	</div>
		<div class="box">
			<div class="d-flex flex-wrap align-content-center" style="height: 100px;">
				<div class="border bg-light p-2 w-100">
					가운데
				</div>
			</div>
	  	</div>
		<hr>	  	

		<div class="box">
			<p> 인라인, 인라인 블록, 인라인 테이블 및 테이블 셀 요소의 수직 정렬 </p>
			<div class="row">
				<div class="col border bg-light p-3 text-start">
					<span class="align-baseline">baseline</span>
					<span class="align-top">top</span>
					<span class="align-middle">middle</span>
					<span class="align-bottom">bottom</span>
					<span class="align-text-top">text-top</span>
					<span class="align-text-bottom">text-bottom</span>
				</div>
			</div>
			
	  	</div>
	  	
	</div>
</main>

<footer>
</footer>

</body>
</html>