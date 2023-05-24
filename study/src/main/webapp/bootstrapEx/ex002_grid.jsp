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
		<h5>Grid system :  flexbox 그리드를 사용하여 12개의 열 시스템, 6개의 기본 반응형 계층 제공</h5>
	</div>
</header>
	
<main>
	<div class="container mb-3">
		<div class="box">
			<p>
				클래스 접두어 : .col-, .col-sm-, .col-md-, .col-lg-, .col-xl-, .col-xxl-
			</p>
			<p>
				열 개수 : 12
			</p>
			<p>
				거터 너비	: 1.5rem (좌우로 각각 .75rem)
			</p>
		</div>

		<div class="box">
			<p>동일 너비</p>
			 
			 <div class="row bg-light text-dark" >
			    <div class="col border p-2">
			      Column-1
			    </div>
			    <div class="col border p-2">
			      Column-2
			    </div>
			    <div class="col border p-2">
			      Column-3
			    </div>
			 </div>
	  	
	  	</div>
	  	
		<div class="box">
			<p>max-width:540</p>
			
			 <div class="row bg-light text-dark" >
			    <div class="col-sm-2 border p-2">
			      Column-1
			    </div>
			    <div class="col-sm-2 border p-2">
			      Column-2
			    </div>
			    <div class="col-sm-2 border p-2">
			      Column-3
			    </div>
			 </div>
			 
	  	</div>
	
		<div class="box">
			<p>열의 너비 설정</p>

			<div class="row bg-light text-dark" >
			    <div class="col border p-2">
			      Column-1
			    </div>
			    <div class="col col-6 border p-2">
			      Column-2
			    </div>
			    <div class="col border p-2">
			      Column-3
			    </div>
			 </div>

	  	</div>
	  	
		<div class="box">
			<p>가변 너비 설정</p>
			
			<div class="row bg-light text-dark" >
			    <div class="col border p-2">
			      Column-1
			    </div>
			    <div class="col col-md-auto border p-2">
			      컨텐츠 내용만큼의 폭
			    </div>
			    <div class="col border p-2">
			      Column-3
			    </div>
			 </div>
	  	
	  	</div>
	  	
		<div class="box">
			<p>가변 너비 설정</p>

			<div class="row bg-light text-dark" >
			    <div class="col border p-2">
			      Column-1
			    </div>
			    <div class="col border p-2">
			      Column-2
			    </div>
			    <div class="col border p-2">
			      Column-3
			    </div>
			    <div class="col border p-2">
			      Column-4
			    </div>
			 </div>
			 
			 <div class="row bg-light text-dark mt-2" >
			    <div class="col-8 border p-2">
			      Column-1
			    </div>
			    <div class="col-4 border p-2">
			      Column-2
			    </div>
			 </div>


	  	</div>
	
		<div class="box">
			<p>거터(Gutters) : 열 사이의 패딩. 그리드 시스템에서 콘텐츠의 간격을 맞추고 정렬하는 데에 사용</p>
			<p>수평 거터</p>

			 <div class="row text-dark g-3" >
			    <div class="col border bg-light p-2">
			      Column-1
			    </div>
			    <div class="col border bg-light p-2">
			      Column-2
			    </div>
			 </div>

	  	</div>
	  	
	  	<div class="box">
			<p>수직 거터</p>

			 <div class="row text-dark gy-3" >
			    <div class="col-6 border bg-light p-2">
			      Column-1
			    </div>
			    <div class="col border bg-light p-2">
			      Column-2
			    </div>
			    <div class="col-6 border bg-light p-2">
			      Column-3
			    </div>
			    <div class="col border bg-light p-2">
			      Column-4
			    </div>
			    <div class="col-6 border bg-light p-2">
			      Column-5
			    </div>
			    <div class="col border bg-light p-2">
			      Column-6
			    </div>
			 </div>

	  	</div>
	  	
	</div>
</main>

<footer>
</footer>

</body>
</html>