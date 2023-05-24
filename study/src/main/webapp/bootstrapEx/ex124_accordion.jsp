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
		<h5>아코디언 예제</h5>
	</div>
</header>
	
<main>
	<div class="container mb-2 pt-3">
	
		<div class="accordion" id="accordionExample">
		
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="heading-1">
		      <button class="accordion-button bg-light collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse-1" aria-expanded="false" aria-controls="collapse-1">
		        자바란 ? 
		      </button>
		    </h2>
		    <div id="collapse-1" class="accordion-collapse collapse " aria-labelledby="heading-1" data-bs-parent="#accordionExample">
		      <div class="accordion-body">
		      	<p> 자바는 ~ </p>
		      </div>
		    </div>
		  </div>
		
		
		<div class="accordion-item">
		    <h2 class="accordion-header" id="heading-2">
		      <button class="accordion-button bg-light collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse-2" aria-expanded="false" aria-controls="collapse-2">
		        웹프로그래밍이란 ? 
		      </button>
		    </h2>
		    <div id="collapse-2" class="accordion-collapse collapse " aria-labelledby="heading-2" data-bs-parent="#accordionExample">
		      <div class="accordion-body">
		      	<p> 웹프로그래밍은 ~ </p>
		      </div>
		    </div>
		  </div>
		
		</div>
		
	</div>
		
	
</main>

<footer>
</footer>

</body>
</html>