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
.body-main {
	max-width: 700px;
	padding-top: 15px;
}

.table-article tr>td { padding-left: 5px; padding-right: 5px; }

.reply { clear: both; padding: 20px 0 10px; }
.reply .bold { font-weight: 600; }

.reply .form-header { padding-bottom: 7px; }
.reply-form  tr>td { padding: 2px 0 2px; }
.reply-form textarea { width: 100%; height: 75px; }
.reply-form button { padding: 8px 25px; }

.reply .reply-info { padding-top: 25px; padding-bottom: 7px; }
.reply .reply-info  .reply-count { color: #3EA9CD; font-weight: 700; }

.reply .reply-list tr>td { padding: 7px 5px; }
.reply .reply-list .bold { font-weight: 600; }

.reply .deleteReply, .reply .deleteReplyAnswer { cursor: pointer; }
.reply .notifyReply { cursor: pointer; }

.reply-list .list-header { border: 1px solid #ccc; background: #f8f8f8; }
.reply-list tr>td { padding-left: 7px; padding-right: 7px; }

.reply-answer { display: none; }
.reply-answer .answer-left { float: left; width: 5%; }
.reply-answer .answer-right { float: left; width: 95%; }
.reply-answer .answer-list { border-top: 1px solid #ccc; padding: 0 10px 7px; }
.reply-answer .answer-form { clear: both; padding: 3px 10px 5px; }
.reply-answer .answer-form textarea { width: 100%; height: 75px; }
.reply-answer .answer-footer { clear: both; padding: 0 13px 10px 10px; text-align: right; }

.answer-article { clear: both; }
.answer-article .answer-article-header { clear: both; padding-top: 5px; }
.answer-article .answer-article-body { clear:both; padding: 5px 5px; border-bottom: 1px solid #ccc; }


</style>
<script type="text/javascript">
<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
	function deleteBoard() {
	    if(confirm("게시글을 삭제 하시 겠습니까 ? ")) {
		    let query = "num=${dto.num}&${query}";
		    let url = "${pageContext.request.contextPath}/bbs/delete.do?" + query;
	    	location.href = url;
	    }
	}
</c:if>
</script>

<script type="text/javascript">

function login(){
	location.href = " ${pageContext.request.contextPath}/member/login.do ";
}



//좋아요 기능 구현
function ajaxFun(url,method,query,dataType,fn){//3.
	$.ajax({
		type : method,	//메소드(요청방식)-> (get, post, put, delete)
		url : url,		//요청 받을 서버 주소
		data : query,	//서버에 전송할 파라미터
		dataType : dataType,	//서버에서 응답하는 형식(json, xml, text)
		success : function(data){ //성공 , data = json
			fn(data);
		},
		beforeSend : function(jqXHR){ //서버전송 전
			jqXHR.setRequestHeader("AJAX",true); // 사용자 정의 헤더
		},
		error : function(jqXHR){
			if(jqXHR.status === 403){
				login();
				return false;
			}else if(jqXHR.status === 400){
				alert("요청 처리가 실패 했습니다.");
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
	
}

//게시글 공감 여부
$(function(){
	$(".btnSendBoardLike").click(function(){
		const $i = $(this).find("i");
		let isNoLike = $i.css("color")=="rgb(0, 0, 0)";
		let msg = isNoLike ? "게시글에 공감하십니까? " : "게시글 공감을 취소하시겠습니까?";
		
		if(! confirm(msg)){
			return false;
		}
		
		let url = "${pageContext.request.contextPath}/bbs/insertBoardLike.do";
		let num = "${dto.num}";
		let qs = "num="+num+"&isNoLike="+isNoLike;
		
		const fn = function(data){
			let state = data.state;
			if(state === "true"){
				let color = "black";
				if(isNoLike){
					color = "blue";
				}
				$i.css("color",color);
				
				let count = data.boardLikeCount;
				$("#boardLikeCount").text(count);
				
			}else if(state ==="liked"){
				alert("좋아요는 한번만 가능합니다.");
			}
		};
		
		ajaxFun(url,"post",qs,"json",fn);
		
		
		
	});
});
	

//댓글 리스트 및 페이징
$(function(){
	listPage(1);
});

function listPage(page){
	let url = "${pageContext.request.contextPath}/bbs/listReply.do";
	let qs = "num=${dto.num}&pageNo="+page;
	let selector = "#listReply";
	
	const fn = function(data){
		$(selector).html(data);
	}
	
	ajaxFun(url, "get", qs, "text", fn);
		//ajaxFun(url,"get"qs,"html",fn); //가능
}
	
	
//댓글 등록
$(function(){
	$(".btnSendReply").click(function(){
		let num = "${dto.num}";
		const $tb = $(this).closest("table");
		let content = $tb.find("textarea").val().trim();
		
		if(! content){
			$tb.find("textarea").focus();
			return false;
		}
		
		content = encodeURIComponent(content);
		
		let url = "$(pageContext.request.contextPath)/bbs/insertReply.do";
		let qs = "num="+num+"&content="+content+"&answer=0";
		
		const fn = function(data){
			$tb.find("textarea").val("");
			let state = data.state;
			if(state === "true"){
				listPage(1);
			}else {
				alert("댓글을 추가하지 못했습니다.");
			}
		}
		
		ajaxFun(url,"post",qs,"json",fn);
		
	});
});



//댓글의 답글 리스트
function listReplyAnswer(answer){
	let url = "${pageContext.request.contextPath}/bbs/listReplyAnswer.do";
	let qs = "answer="+answer;
	let selector = "#listReplyAnswer"+answer;
	
	const fn =  function(data){
		$(selector).html(data);
	};
	
	ajaxFun(url,"get",qs,"text",fn);
	
}

//댓글별 답글 개수
function countReplyAnswer(answer){
	let url = "${pageContext.request.contextPath}/bbs/countReplyAnswer.do";
	let qs = "answer="+answer;
	
	const fn = function(data){
		let count = data.count;
		let selector = "#answerCount"+answer;
		$(selector).html(count);
	};
		
	ajaxFun(url,"post",qs,"json",fn);
}



//답글 버튼(댓글별 답글 등록 폼 및 답글 리스트)
$(function(){
	$("#listReply").on("click",".btnReplyAnswerLayout",function(){
		
		const $trAnswer = $(this).closest("tr").next();
		
		let isVisible = $trAnswer.is(":visible");
		let replyNum = $(this).attr("data-replyNum");
		
		if(isVisible){
			$trAnswer.hide();
		}else{
			$trAnswer.show();//답글 창이 열릴때
			
			//답글 리스트
			listReplyAnswer(replyNum);
			
			//답글 개수
			countReplyAnswer(replyNum);
			
		}
		
		
	});
});


//답글 등록 버튼
$(function(){
	$("#listReply").on("click",".btnSendReplyAnswer",function(){
		
		let num = "${dto.num}";
		let replyNum = $(this).attr("data-replyNum");
		const $td = $(this).closest("td");
		
		let content = $td.find("textarea").val().trim();
		if(! content){
			$td.find("textarea").focus();
			return false;
		}
		
		content = encodeURIComponent(content);
		
		let url = "${pageContext.request.contextPath}/bbs/insertReply.do";
		let qs = "num="+num+"&content="+content+"&answer="+replyNum;
		

		const fn =  function(data){
			let state = data.state;
			
			$td.find("textarea").val("");
			
			if(state === "true"){
				listReplyAnswer(replyNum);
				countReplyAnswer(replyNum);
				
			}
		};
		
		ajaxFun(url,"post",qs,"json",fn);
		
	});
});

//댓글 삭제
$(function(){
	$("#listReply").on("click",".deleteReply",function(){
		if(! confirm("게시글을 삭제 하시겠습니까?")){
			return false;
		}
		
		let replyNum = $(this).attr("data-replyNum");
		let page = $(this).attr("data-pageNo");
		
		let url = "${pageContext.request.contextPath}/bbs/deleteReply.do";
		let qs = "replyNum="+replyNum;
		
		const fn = function(data){
			listPage(page);
		};
		
		ajaxFun(url,"post",qs,"json",fn);
		
	});
});


//댓글의 답글 삭제
$(function(){
	$("#listReply").on("click",".deleteReplyAnswer",function(){
		if(! confirm("게시글을 삭제 하시겠습니까?")){
			return false;
		}
		
		let replyNum = $(this).attr("data-replyNum");
		let answer = $(this).attr("data-answer");
		
		let url = "${pageContext.request.contextPath}/bbs/deleteReply.do";
		let qs = "replyNum="+replyNum;
		
		const fn = function(data){
			listReplyAnswer(answer);
			countReplyAnswer(answer);
		};
		
		ajaxFun(url,"post",qs,"json",fn);
		
	});
});




</script>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>
	
<main>
	<div class="container body-container">
	    <div class="body-title">
			<h2><i class="fa-regular fa-square"></i> 게시판 </h2>
	    </div>
	    
	    <div class="body-main mx-auto">
			<table class="table table-border table-article">
				<thead>
					<tr>
						<td colspan="2" align="center">
							${dto.subject}
						</td>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td width="50%">
							이름 : ${dto.userName}
						</td>
						<td align="right">
							${dto.reg_date} | 조회 ${dto.hitCount}
						</td>
					</tr>
					
					<tr style="border-bottom: none;">
						<td colspan="2" valign="top" height="200" >
							${dto.content}
						</td>
					</tr>
					
					<tr>
						<td colspan="2" align="center" style="border-bottom: 20px">
							<button type="button" class="btn btnSendBoardLike" title="좋아요">
								<i class="fas fa-thumbs-up" style="color:${isUserLike? 'blue':'black'}"></i>&nbsp; &nbsp; 
									<span id="boardLikeCount">${dto.boardLikeCount }</span> 
							</button>
						</td>
					</tr>
					
					
					<tr>
						<td colspan="2">
							이전글 :
							<c:if test="${not empty preReadDto}">
								<a href="${pageContext.request.contextPath}/bbs/article.do?${query}&num=${preReadDto.num}">${preReadDto.subject}</a>
							</c:if>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							다음글 :
							<c:if test="${not empty nextReadDto}">
								<a href="${pageContext.request.contextPath}/bbs/article.do?${query}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
			
			<table class="table">
				<tr>
					<td width="50%">
						<c:choose>
							<c:when test="${sessionScope.member.userId==dto.userId}">
								<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/bbs/update.do?num=${dto.num}&page=${page}';">수정</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn" disabled="disabled">수정</button>
							</c:otherwise>
						</c:choose>
				    	
						<c:choose>
				    		<c:when test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
				    			<button type="button" class="btn" onclick="deleteBoard();">삭제</button>
				    		</c:when>
				    		<c:otherwise>
				    			<button type="button" class="btn" disabled="disabled">삭제</button>
				    		</c:otherwise>
				    	</c:choose>
					</td>
					<td align="right">
						<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/bbs/list.do?${query}';">리스트</button>
					</td>
				</tr>
			</table>

			<div class="reply">
				<form name="replyForm" method="post">
					<div class='form-header'>
						<span class="bold">댓글쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가해 주세요.</span>
					</div>
					
					<table class="table reply-form">
						<tr>
							<td>
								<textarea class='form-control' name="content"></textarea>
							</td>
						</tr>
						<tr>
						   <td align='right'>
								<button type='button' class='btn btnSendReply'>댓글 등록</button>
							</td>
						 </tr>
					</table>
				</form>
				
				<div id="listReply"></div>
			</div>





	    </div>
	</div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>