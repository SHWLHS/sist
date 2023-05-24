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
		<h5>border / background</h5>
	</div>
</header>
	
<main>
	<div class="container mb-3">
		<div class="box">
			<p> border </p>
			<p> 테두리 방향 : border, border-top, border-end, border-bottom, border-start </p>
			<p> 테두리 특정 방향 제거 : border-0, border-top-0, border-end-0, border-bottom-0, border-start-0 </p>
			
			<div class="row gx-2">
				<div class="col text-center">
					<div class="border bg-light p-3">border</div>
				</div>
				<div class="col text-center">
					<div class="border-top border-primary bg-light p-3">border</div>
				</div>
				<div class="col text-center">
					<div class="border-start border-success bg-light p-3">border</div>
				</div>
				<div class="col text-center">
					<div class="border border-bottom-0 border-warning bg-light p-3">border</div>
				</div>
			</div>
	  	</div>
		<hr>
		
		<div class="box">
			<p> background </p>
			<div class="row mb-2 gx-2">
				<div class="col text-center">
					<div class="bg-primary text-white p-3">bg-primary</div>
				</div>
				<div class="col text-center">
					<div class="bg-secondary text-white p-3">bg-secondary</div>
				</div>
				<div class="col text-center">
					<div class="bg-success text-white p-3">bg-success</div>
				</div>
				<div class="col text-center">
					<div class="bg-danger text-white p-3">bg-danger</div>
				</div>
			</div>
			<div class="row gx-2">
				<div class="col text-center">
					<div class="bg-warning text-dark p-3">bg-warning</div>
				</div>
				<div class="col text-center">
					<div class="bg-info text-dark p-3">bg-info</div>
				</div>
				<div class="col text-center">
					<div class="bg-light text-dark p-3">bg-light</div>
				</div>
				<div class="col text-center">
					<div class="bg-dark text-white p-3">bg-dark</div>
				</div>
			</div>
	  	</div>
		<hr>
	  	
	</div>
</main>

<footer>
</footer>

</body>
</html>