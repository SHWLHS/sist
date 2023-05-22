<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<!-- 
	- form 태그 안에 <input type="text">가 하나만 존재하는 경우 (textarea도 없는 경우)
		:<input type="text">에서 엔터를 치면 submit 이벤트가 발생하여 서버로 전송된다.
	- 해결방법
		: onsubmit 이벤트에서 유효성 검사
	
	- 엔터를 눌러도 서버로 전송되지 못하도록 설정하는 방법
		:<input style="display: none;"> ->input태그를 안보이게 설정해서 하나 추가
		
 -->

<form name="searchForm" action="ex06_ok.jsp" method="post">
	<select name="condition">
		<option value="all">전체</option>
		<option value="name">작성자</option>
		<option value="date">등록일</option>
		<option value="subject">제목</option>
		<option value="content">내용</option>
	</select>
	<input type="text" name="keyword">
	<input style="display: none;">
	<button type="button" onclick="searchList()">검색</button>
</form>

<script type="text/javascript">
//form태그안에 input태그의 타입이 텍스트이면 하나만존재해도 텍스트박스에서 엔터누를때 서버로 넘어감
function searchList(){
	const f = document.searchForm;
	
	if(! f.keyword.value.trim()){
		f.keyword.focus();
		return;
	}
	f.submit();
}
</script>



</body>
</html>