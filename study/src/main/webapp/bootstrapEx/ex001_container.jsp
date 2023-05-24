<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<!-- cdn으로 사용하지말것 -->
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
	<div class="container-fluid mb-2 p-3 bg-primary text-white">
		<h5>Containers</h5>
	</div>
</header>
	
<main>
	<div class="container mb-2 pt-3">
		<p> 컨테이너는 지정된 기기 또는 뷰포트 내에서 콘텐츠를 포함하고 채우고 정렬하는 Bootstrap의 기본 컴포넌트이다. </p>
	</div>

	<div class="container mb-2 p-2 bg-light text-dark">
		<p>container-fluid : 컨테이너 플루이드는 뷰포트의 전체 너비에 걸쳐 있는 전체 너비 컨테이너</p>
		<p>container : 반응형 고정 너비 컨테이너. max-width가 각 중단점에서 변경</p>
	</div>
</main>

<footer>
</footer>

</body>
</html>