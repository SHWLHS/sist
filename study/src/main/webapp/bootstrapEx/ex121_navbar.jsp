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

	<nav class="navbar navbar-expand-lg navbar-light"> <!-- fixed-top를 추가하면 상단 고정 -->
		<div class="container">
			<a class="navbar-brand" href="#"><i class="bi bi-app-indicator"></i></a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
				
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mx-auto flex-nowrap"> <!-- ms-auto : 우측으로 정렬 -->
					<li class="nav-item">
						<a class="nav-link active" aria-current="page" href="#">홈</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#">신상품</a>
					</li>

					<li class="nav-item">
						<a class="nav-link" href="#">베스트 상품</a>
					</li>

					<li class="nav-item">
						<a class="nav-link" href="#">이월 상품</a>
					</li>

					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
							고객센터
						</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="#">자주하는질문</a></li>
							<li><a class="dropdown-item" href="#">공지사항</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">질문과답변</a></li>
						</ul>
					</li>
					
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
							마이페이지
						</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="#">나의쿠폰함</a></li>
							<li><a class="dropdown-item" href="#">주문배송조회</a></li>
							<li><a class="dropdown-item" href="#">취소반품조회</a></li>
							<li><a class="dropdown-item" href="#">쪽지함</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">정보관리</a></li>
						</ul>
					</li>
					
				</ul>
			</div>
			
		</div>
	</nav>

</header>
	
<main>
	<div class="container-fluid mb-2 p-3 bg-success text-white">
		<h5>메뉴</h5>
	</div>
	
	<div class="container">
		<div style="min-height: 700px;"></div>
	</div>

</main>

<footer></footer>

</body>
</html>