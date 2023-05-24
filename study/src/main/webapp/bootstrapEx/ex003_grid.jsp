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
			<p>행/열</p>
			
			 <div class="row row-cols-3 text-dark " >
			    <div class="col border bg-light p-2">
			      Column-1
			    </div>
			    <div class="col border bg-light p-2">
			      Column-2
			    </div>
			    <div class="col border bg-light p-2">
			      Column-3
			    </div>
			    <div class="col border bg-light p-2">
			      Column-4
			    </div>			    
			 </div>			

	  	</div>

		<div class="box">
			<p>행/열</p>

			 <div class="row row-cols-4 text-dark " >
			    <div class="col border bg-light p-2">
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
			 </div>	

	  	</div>
	  	
	  	
	  	
		<div class="box">
			<p>행/열</p>

			 <div class="row row-cols-3 text-dark " >
			    <div class="col p-1">
			      <div  class="border bg-light p-2">Column-1</div>
			    </div>
			    <div class="col p-1">
			      <div  class="border bg-light p-2">Column-2</div>
			    </div>
			    <div class="col p-1">
			      <div  class="border bg-light p-2">Column-3</div>
			    </div>
			    <div class="col p-1">
			      <div  class="border bg-light p-2">Column-4</div>
			    </div>		    
			 </div>	

	  	</div>	  	
	  	
	</div>
</main>

<footer>
</footer>

</body>
</html>