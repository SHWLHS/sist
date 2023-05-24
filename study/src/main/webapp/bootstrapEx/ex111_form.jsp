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
		<h5>Form Control 예제</h5>
	</div>
</header>
	
<main>
	<div class="container mb-2 pt-3">
		<div class="row justify-content-center">
			<div class="col-6">
				<form>
					<table class="table align-middle">
						<tbody class="text-center">
							<tr style="border-top: 2px solid #212529;">
								<td class="table-light col-sm-2">제목</td>
								<td>
									<input type="text" name="title" class="form-control">
								</td>
							</tr>
							<tr>
								<td class="table-light col-sm-2">이름</td>
								<td class="text-start">
									<p class="form-control-plaintext">홍길동</p>
								</td>
							</tr>
							
							<tr>
								<td class="table-light col-sm-2">성별</td>
								<td class="text-start">
									<div class="form-check form-check-inline">
										<input type="radio" name="gender" id="radio1" value="M" checked="checked" class="form-check-input">
										<label class="form-check-label" for="radio1">남자</label>
									</div>
									<div class="form-check form-check-inline">
										<input type="radio" name="gender" id="radio2" value="F" class="form-check-input">
										<label class="form-check-label" for="radio2">여자</label>
									</div>
								</td>
							</tr>

							<tr>
								<td class="table-light col-sm-2">전화번호</td>
								<td>
									<div class="row">
										<div class="col-3 pe-0">
											<input type="text" name="tel1" class="form-control">
										</div>
										<div class="col-auto">
											<p class="form-control-plaintext text-center">-</p>
										</div>
										<div class="col-3 px-0">
											<input type="text" name="tel2" class="form-control">
										</div>
										<div class="col-auto">
											<p class="form-control-plaintext text-center">-</p>
										</div>
										<div class="col-3 px-0">
											<input type="text" name="tel3" class="form-control">
										</div>
									</div>
								</td>
							</tr>

							<tr>
								<td class="table-light col-sm-2">이메일</td>
								<td>
									<div class="row">
										<div class="col input-group">
											<input type="text" name="email1" class="form-control" maxlength="30">
										    <span class="input-group-text p-1" style="border: none; background: none;">@</span>
											<input type="text" name="email2" class="form-control" maxlength="30">
										</div>		
									</div>
								</td>
							</tr>
							
							<tr>
								<td class="table-light col-sm-2">메일수신</td>
								<td class="text-start">
									<input type="checkbox" id="mailAgree" name="mailAgree"
										 class="form-check-input" checked="checked">
									<label class="form-check-label" for="mailAgree">동의</label>
								</td>
							</tr>
							
							<tr>
								<td class="table-light col-sm-2">과목</td>
								<td>
									<select name="subject" class="form-select">
										<option value="">선택</option>
										<option value="자바">자바</option>
										<option value="오라클">오라클</option>
										<option value="웹">웹</option>
										<option value="기타">기타</option>
									</select>
								</td>
							</tr>

							<tr>
								<td class="table-light col-sm-2">지역</td>
								<td>
									<input name="city" id="city" class="form-control" list="datalistOptions" placeholder="지역 선택">
									<datalist id="datalistOptions">
										<option value="서울">
										<option value="인천">
										<option value="경기">
										<option value="기타">
									</datalist>
								</td>
							</tr>

							<tr>
								<td class="table-light col-sm-2">색상</td>
								<td>
									<input type="color" name="color" id="color" class="form-control form-control-color" value="#563d7c" title="색상 선택">
								</td>
							</tr>
							
							<tr>
								<td class="table-light col-sm-2">파일</td>
								<td>
									<input type="file" name="selectFile" class="form-control">
								</td>
							</tr>

							<tr>
								<td class="table-light col-sm-2">메모</td>
								<td>
									<textarea name="memo" class="form-control"></textarea>
								</td>
							</tr>
							
						</tbody>
					</table>
				</form>
			</div>
		</div>
	</div>

</main>

<footer>
</footer>

</body>
</html>