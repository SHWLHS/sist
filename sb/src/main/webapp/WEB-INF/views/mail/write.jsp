<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">

<script type="text/javascript">
function sendOk() {
    const f = document.mailForm;
    let str;
	
    str = f.senderName.value.trim();
    if(!str) {
        alert("이름을 입력하세요. ");
        f.senderName.focus();
        return;
    }
    
	if(!f.senderEmail.value.trim()) {
        alert("E-Mail을 입력하세요. ");
        f.senderEmail.focus();
        return;
	}
    
	if(!f.receiverEmail.value.trim()) {
        alert("정상적인 E-Mail을 입력하세요. ");
        f.receiverEmail.focus();
        return;
	}
    
	str = f.subject.value.trim();
    if(!str) {
        alert("제목을 입력하세요. ");
        f.subject.focus();
        return;
    }

	str = f.content.value.trim();
    if(!str) {
        alert("내용을 입력하세요. ");
        f.content.focus();
        return;
    }

	f.action="${pageContext.request.contextPath}/mail/send_ok.do";
	f.submit();
}
</script>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
	
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3><i class="bi bi-envelope"></i> 메일 보내기 </h3>
			</div>
			
			<div class="body-main">
				<form name="mailForm" method="post">
					<table class="table write-form mt-5">
						<tr>
							<td class="table-light col-sm-3" scope="row">보내는 사람 이름</td>
							<td>
								<input type="text" name="senderName" class="form-control" value="${sessionScope.member.userName}">
							</td>
						</tr>
	        
						<tr>
							<td class="table-light col-sm-3" scope="row">보내는 사람 E-Mail</td>
	 						<td>
								<input type="text" name="senderEmail" class="form-control">
							</td>
						</tr>
	
						<tr>
							<td class="table-light col-sm-3" scope="row">받는 사람 E-Mail</td>
							<td>
								<input type="text" name="receiverEmail" class="form-control">
							</td>
						</tr>

						<tr>
							<td class="table-light col-sm-3" scope="row">제 목</td>
							<td>
								<input type="text" name="subject" class="form-control">
							</td>
						</tr>
	
						<tr>
							<td class="table-light col-sm-3" scope="row">내 용</td>
							<td>
								<textarea name="content" class="form-control"></textarea>
							</td>
						</tr>
					</table>
					
					<table class="table table-borderless">
	 					<tr>
							<td class="text-center">
								<button type="button" class="btn btn-dark" onclick="sendOk();">메일전송&nbsp;<i class="bi bi-check2"></i></button>
								<button type="reset" class="btn btn-light">다시입력</button>
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/';">전송취소&nbsp;<i class="bi bi-x"></i></button>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>