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

.guest-form textarea {
	width: 100%; height: 75px; resize: none;
}

.guest-list tr:nth-child(2n+1) {
	border: 1px solid #cccccc; background: #f8f9fa;
}
.guest-list .deleteGuest, .guest-list .notifyGuest {
	cursor: pointer;
}
.guest-list .deleteGuest:hover {
	text-decoration: underline; color: #f28011;
}

textarea::placeholder{
	opacity: 1; /* 파이어폭스에서 뿌옇게 나오는 현상 제거 */
	color: #333;
	text-align: center;
	line-height: 60px;
}
</style>

<script type="text/javascript">
function login() {
	location.href = "${pageContext.request.contextPath}/member/login.do";
}

function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data){
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status === 403) {
				login();
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다.");
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}

$(function(){
	listPage(1);
});

function listPage(page) {
	let url = "${pageContext.request.contextPath}/guest/list.do";
	let query = "pageNo=" + page;
	
	const fn = function(data) {
		printGuest(data);
	};
	ajaxFun(url, "get", query, "json", fn);
}

function printGuest(data) {
	let dataCount = data.dataCount;
	let pageNo = data.pageNo;
	let total_page = data.total_page;
	
	$(".guest-count").attr("data-pageNo", pageNo);
	$(".guest-count").attr("data-totalPage", total_page);
	
	$("#listGuest").show();
	$(".guest-count").html("방명록 " + dataCount + "개");
	
	$(".more-box").hide();
	if(parseInt(dataCount) === 0) {
		$(".guest-list-body").empty();
		return;
	}
	
	if(pageNo < total_page) {
		$(".more-box").show();
	}
	
	let out = "";
	/*
	for(let idx = 0; idx < data.list.length; idx++) {
		let num = data.list[idx].num;
	}
	*/
	for(let item of data.list) {
		let num = item.num;
		let userName = item.userName;
		let content = item.content;
		let reg_date = item.reg_date;
		let deletePermit = item.deletePermit;
		
		out += "<tr>";
		out += "    <td width='50%'><span style='font-weight: 600;'>" + userName + "</span></td>";
		out += "    <td width='50%' align='right'>" + reg_date;
		if(deletePermit) {
			out += "   | <span class='deleteGuest' data-num='" + num + "'>삭제</span>";
		} else {
			out += "   | <span class='notifyGuest' data-num='" + num + "'>신고</span>";
		}
		out += "    </td>";
		out += "</tr>";
		out += "<tr>";
		out += "    <td colspan='2' valign='top'>" + content + "</td>"; 
		out += "</tr>";
	}
	
	$(".guest-list-body").append(out);

}

$(function(){
	$(".btnSend").click(function(){
		let content = $("#content").val().trim();
		if(! content) {
			$("#content").focus();
			return false;
		}
		
		let url = "${pageContext.request.contextPath}/guest/insert.do";
		let query = "content=" + encodeURIComponent(content);
		// let query = $("form[name=guestForm]").serialize();
		
		const fn = function(data) {
			$("#content").val("");
			$(".guest-list-body").empty();
			listPage(1);
		};
		
		ajaxFun(url, "post", query, "json", fn);
		
	});
});

$(function(){
	$("body").on("click", ".deleteGuest", function(){
		if( ! confirm('게시글을 삭제 하시겠습니까 ? ')) {
			return false;
		}
		
		let num = $(this).attr("data-num");
		let url = "${pageContext.request.contextPath}/guest/delete.do";
		let query = "num=" + num;
		const fn = function(data) {
			$(".guest-list-body").empty();
			listPage(1);
		};
		ajaxFun(url, "post", query, "json", fn);
		
	});
});

$(function(){
	$(".more-box .more").click(function(){
		let pageNo = $(".guest-count").attr("data-pageNo");
		let total_page = $(".guest-count").attr("data-totalPage");
		
		if(pageNo < total_page) {
			pageNo++;
			listPage(pageNo);
		}
	});
})
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
				<h3><i class="bi bi-pencil-square"></i> 방명록 </h3>
			</div>
			
			<div class="body-main">
				
				<form name="guestForm" method="post">
					<div class="guest-form border border-secondary mt-5 p-3">
						<div class="p-1">
							<span class="fw-bold">방명록쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가해 주세요.</span>
						</div>
						<div class="p-1">
							<textarea name="content" id="content" class="form-control" placeholder="${empty sessionScope.member ? '로그인 후 등록 가능합니다.':''}"></textarea>
						</div>
						<div class="p-1 text-end">
							<button type="button" class="btnSend btn btn-dark" ${empty sessionScope.member ? "disabled='disabled'":""}> 등록하기 <i class="bi bi-check2"></i> </button>
						</div>
					</div>
				</form>

				<div id="listGuest">
					<div class='mt-4 mb-1'>
						<span class='guest-count fw-bold text-primary' data-pageNo="1" data-totalPage="1">방명록 0개</span>
					</div>
					
					<table class="guest-list table table-borderless">
						<tbody class="guest-list-body"></tbody>
					</table>
		
					<div class='more-box mt-2 text-end'>
						<span class="more btn btn-light">&nbsp;더보기&nbsp;<i class="bi bi-chevron-down"></i>&nbsp;</span>
					</div>
				</div>

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