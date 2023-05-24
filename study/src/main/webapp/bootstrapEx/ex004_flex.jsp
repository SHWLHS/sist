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
		<h5>Flex</h5>
	</div>
</header>
	
<main>
	<div class="container mb-3">
		<div class="box">
			<p> d-flex : 플랙스 컨테이너(블록), d-inline-flex : 플랙스 컨테이너(인라인) </p>
			<p> flex-wrap : 한줄이 꽉찬 경우 줄바꿈(기본 : flex-nowrap)</p>
			
			<div class="d-flex flex-wrap">
			  <div class="p-2 border bg-light col-3">A</div>
			  <div class="p-2 border bg-light col-3">B</div>
			  <div class="p-2 border bg-light col-3">C</div>
			  <div class="p-2 border bg-light col-3">D</div>
			  <div class="p-2 border bg-light col-3">E</div>
			</div>

	  	</div>
	  	
		<div class="box">
			<p> order-0 ~ order-5,  order-first, order-last .. : 출력 순서</p>

			<div class="d-flex flex-wrap">
			  <div class="p-2 border bg-light col-3 order-2">A</div>
			  <div class="p-2 border bg-light col-3 order-1">B</div>
			  <div class="p-2 border bg-light col-3 order-0">C</div>
			</div>

	  	</div>

	</div>
</main>

<footer>
</footer>

</body>
</html>