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
		<h5>Gutters</h5>
	</div>
</header>
	
<main>
	<div class="container mb-3">
		<div class="box">
			<p> 거터는 열 사이의 패딩으로, Bootstrap 그리드 시스템에서 콘텐츠의 간격을 맞추고 정렬하는 데에 사용 </p>
		</div>
	</div>
	
	<div class="container mb-3">
		<div class="box">
			<p> 수평거터 </p>
			
			<div class="row gx-3">
				<div class="col text-center">
					<div class="border bg-light p-4">A</div>
				</div>
				<div class="col text-center">
					<div class="border bg-light p-4">B</div>
				</div>
				<div class="col text-center">
					<div class="border bg-light p-4">C</div>
				</div>
			</div>


	  	</div>
		<hr>
		
		<div class="box">
			<p> 수직 거터 </p>

			<div class="row gy-6">
				<div class="col-6 text-center">
					<div class="border bg-light p-3">A</div>
				</div>
				<div class="col-6 text-center">
					<div class="border bg-light p-3">B</div>
				</div>
				<div class="col-6 text-center">
					<div class="border bg-light p-3">C</div>
				</div>
				<div class="col-6 text-center">
					<div class="border bg-light p-3">D</div>
				</div>
			</div>

	  	</div>
		<hr>
		
		<div class="box">
			<p> 수평 / 수직 거터 </p>

			<div class="row g-2">
				<div class="col-6 text-center">
					<div class="border bg-light p-3">A</div>
				</div>
				<div class="col-6 text-center">
					<div class="border bg-light p-3">B</div>
				</div>
				<div class="col-6 text-center">
					<div class="border bg-light p-3">C</div>
				</div>
				<div class="col-6 text-center">
					<div class="border bg-light p-3">D</div>
				</div>
			</div>

	  	</div>

	</div>
</main>

<footer>
</footer>

</body>
</html>