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

</head>
<body>

<header>
	<div class="container-fluid mb-3 p-3 bg-secondary text-white">
		<h5>Carousel 예제</h5>
	</div>
</header>
	
<main>
	<div class="container mb-2 pt-3">
		<p> 캐러셀은 이미지나 텍스트의 슬라이드를 가로로 슬라이드시켜 여러 개를 표시하는 컴포넌트이다. </p>
	</div>
	
	<div class="container mb-2 pt-3">
		<div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
		  <div class="carousel-indicators">
		    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="첫번째 이미지"></button>
		    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="두번째 이미지"></button>
		    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="세번째 이미지"></button>
		 </div>
		 
	 	<div class="carousel-inner">
		 	<div class="carousel-item active">
		 		<img src="img/1.jpg" class="d-block w-100">
		 		<div class="carousel-caption d-none d-md-block">
		 			<h5>첫번째 이미지</h5>
		 		</div>
		 </div>
		 	
		 	
		 <div class="carousel-item">
	 		<img src="img/2.jpg" class="d-block w-100">
	 		<div class="carousel-caption d-none d-md-block">
	 			<h5>두번째 이미지</h5>
	 		</div>
		 </div>
		 
		 <div class="carousel-item">
	 		<img src="img/3.jpg" class="d-block w-100">
	 		<div class="carousel-caption d-none d-md-block">
	 			<h5>세번째 이미지</h5>
	 		</div>
		 </div>		 
		 	
	 	</div>
		 
		
		  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Previous</span>
		  </button>
		  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Next</span>
		  </button>
		  
		  
		</div>
		  
	</div>
</main>

<footer></footer>

</body>
</html>