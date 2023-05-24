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
		<h5>margin과 padding</h5>
	</div>
</header>
	
<main>
	<div class="container mb-3">
		<div class="box">
			<p> m : margin, p : padding</p>
			<p> t : top, b : bottom, s : left, e : right, x : left와 right, y : top와 bottom </p>
			<p> 값 : 0~5, auto </p>
			<p> 사용 예 - 마진 top : mt-3 </p>
	  	</div>

		<div class="box">
			<div class="row">
				<div class="col border bg-light">A</div>
				<div class="col border bg-light">B</div>
				<div class="col border bg-light">C</div>
			</div>
			
			
			<div class="row mx-3 mt-3">
				<div class="col border bg-light py-3">A</div>
				<div class="col border bg-light ps-5">B</div>
			</div>

			
			<div class="row mt-3">
				<div class="col border bg-light p-3">A</div>
				<div class="col border bg-light p-3">B</div>
			</div>

		</div>
	  	
	</div>
</main>

<footer>
</footer>

</body>
</html>