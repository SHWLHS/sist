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
		<h5>Offcanvas 예제</h5>
	</div>
</header>
	
<main>
	<div class="container mb-2 pt-3">
		<p> 오프캔버스는 JavaScript로 뷰포트의 왼쪽, 오른쪽, 혹은 아래쪽에서 표시되는 사이드바 컴포넌트이다. </p>
	</div>

	<div class="container mb-2 pt-3">
		<p>
			<a class="btn btn-primary" data-bs-toggle="offcanvas" href="#myOffcanvas" role="button" aria-controls="myOffcanvas">
				상품 검색
			</a>
		</p>
	</div>
</main>
<!-- 오프캔버스 -->
<div class="offcanvas offcanvas-start" tabindex="-1" id="myOffcanvas" aria-labelledby="offcanvasLabel">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" id="offcanvasLabel">상품검색</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
  	<div>
  		상품을 검색합니다.
  	</div>
	<!-- 드롭다운 -->
	<div class="dropdown">
	  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
	  	선택
	  </button>
	  <ul class="dropdown-menu">
	    <li><a class="dropdown-item" href="#">아동용</a></li>
	    <li><a class="dropdown-item" href="#">남성용</a></li>
	    <li><a class="dropdown-item" href="#">여성용</a></li>
	  </ul>
	</div>
  </div>
</div>

<footer>
</footer>

</body>
</html>