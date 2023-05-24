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
	padding: 10px;
	max-width: 800px;
}
</style>

</head>
<body>

<header>
	<div class="container-fluid mb-3 p-3 bg-secondary text-white">
		<h5>Table 예제</h5>
	</div>
</header>
	
<main>
	<div class="container mb-2 pt-3">
		<div class="box">
			<table class="table">
				<thead>
					<tr>
						<th>학번</th>
						<th>이름</th>
						<th>국어</th>
						<th>영어</th>
						<th>수학</th>
						<th>총점</th>
						<th>평균</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>1001</td>
						<td>너자바</td>
						<td>80</td>
						<td>70</td>
						<td>90</td>
						<td>240</td>
						<td>80</td>
					</tr>
					<tr>
						<td>1002</td>
						<td>서블릿</td>
						<td>75</td>
						<td>80</td>
						<td>60</td>
						<td>225</td>
						<td>75</td>
					</tr>
					<tr>
						<td>1003</td>
						<td>스프링</td>
						<td>80</td>
						<td>100</td>
						<td>90</td>
						<td>270</td>
						<td>90</td>
					</tr>
					<tr>
						<td>1004</td>
						<td>오라클</td>
						<td>85</td>
						<td>85</td>
						<td>85</td>
						<td>255</td>
						<td>85</td>
					</tr>
					<tr>
						<td>1005</td>
						<td>리액트</td>
						<td>80</td>
						<td>70</td>
						<td>60</td>
						<td>210</td>
						<td>70</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="box">
			<div class="row justify-content-center">
				<div class="col-8">
					<table class="table table-hover">
						<thead class="table-light text-center">
							<tr>
								<th>학번</th>
								<th>이름</th>
								<th>국어</th>
								<th>영어</th>
								<th>수학</th>
								<th>총점</th>
								<th>평균</th>
							</tr>
						</thead>
						<tbody class="text-center">
							<tr>
								<td>1001</td>
								<td>너자바</td>
								<td>80</td>
								<td>70</td>
								<td>90</td>
								<td>240</td>
								<td>80</td>
							</tr>
							<tr>
								<td>1002</td>
								<td>서블릿</td>
								<td>75</td>
								<td>80</td>
								<td>60</td>
								<td>225</td>
								<td>75</td>
							</tr>
							<tr>
								<td>1003</td>
								<td>스프링</td>
								<td>80</td>
								<td>100</td>
								<td>90</td>
								<td>270</td>
								<td>90</td>
							</tr>
							<tr>
								<td>1004</td>
								<td>오라클</td>
								<td>85</td>
								<td>85</td>
								<td>85</td>
								<td>255</td>
								<td>85</td>
							</tr>
							<tr>
								<td>1005</td>
								<td>리액트</td>
								<td>80</td>
								<td>70</td>
								<td>60</td>
								<td>210</td>
								<td>70</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	
		<div class="box">
			<div class="row justify-content-center">
				<div class="col-8">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>학번</th>
								<th>이름</th>
								<th>국어</th>
								<th>영어</th>
								<th>수학</th>
								<th>총점</th>
								<th>평균</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1001</td>
								<td>너자바</td>
								<td>80</td>
								<td>70</td>
								<td>90</td>
								<td>240</td>
								<td>80</td>
							</tr>
							<tr>
								<td>1002</td>
								<td>서블릿</td>
								<td>75</td>
								<td>80</td>
								<td>60</td>
								<td>225</td>
								<td>75</td>
							</tr>
							<tr>
								<td>1003</td>
								<td>스프링</td>
								<td>80</td>
								<td>100</td>
								<td>90</td>
								<td>270</td>
								<td>90</td>
							</tr>
							<tr>
								<td>1004</td>
								<td>오라클</td>
								<td>85</td>
								<td>85</td>
								<td>85</td>
								<td>255</td>
								<td>85</td>
							</tr>
							<tr>
								<td>1005</td>
								<td>리액트</td>
								<td>80</td>
								<td>70</td>
								<td>60</td>
								<td>210</td>
								<td>70</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>	

		<div class="box">
			<div class="row justify-content-center">
				<div class="col-8">
					<table class="table table-hover table-borderless">
						<thead>
							<tr>
								<th>학번</th>
								<th>이름</th>
								<th>국어</th>
								<th>영어</th>
								<th>수학</th>
								<th>총점</th>
								<th>평균</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1001</td>
								<td>너자바</td>
								<td>80</td>
								<td>70</td>
								<td>90</td>
								<td>240</td>
								<td>80</td>
							</tr>
							<tr>
								<td>1002</td>
								<td>서블릿</td>
								<td>75</td>
								<td>80</td>
								<td>60</td>
								<td>225</td>
								<td>75</td>
							</tr>
							<tr>
								<td>1003</td>
								<td>스프링</td>
								<td>80</td>
								<td>100</td>
								<td>90</td>
								<td>270</td>
								<td>90</td>
							</tr>
							<tr>
								<td>1004</td>
								<td>오라클</td>
								<td>85</td>
								<td>85</td>
								<td>85</td>
								<td>255</td>
								<td>85</td>
							</tr>
							<tr>
								<td>1005</td>
								<td>리액트</td>
								<td>80</td>
								<td>70</td>
								<td>60</td>
								<td>210</td>
								<td>70</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
			
	</div>
</main>

<footer>
</footer>

</body>
</html>