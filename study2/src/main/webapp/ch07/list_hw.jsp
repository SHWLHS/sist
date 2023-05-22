<%@page import="com.util.MyUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");

	//파라미터로 넘어온 페이지 번호(주의 page는 JSP 예약어로 변수로는 사용 불가)
	String pageNum = request.getParameter("page");
	
	int current_page = 1;
	if(pageNum != null){
		current_page = Integer.parseInt(pageNum);
	}
	
	MyUtil util  = new MyUtil();
	
	int dataCount = 965;
	int size = 10;
	int total_page = util.pageCount(dataCount, size);
	if(current_page > total_page){//웹은 정적이라 한번클릭하면 업데이트가 안됨(새로고침해야함) 만약 페이지가 없어졌으면 마지막페이지로 들어가게끔 설정
		current_page = total_page;
	}
	
	String listUrl = "list_hw.jsp";
	String paging = util.pagingUrl(current_page, total_page, listUrl);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>study</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
* { padding: 0; margin: 0; }
*, *::after, *::before { box-sizing: border-box; }

body {
	font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
	font-size: 14px;
	color: #222;
}

a { color: #222; text-decoration: none; cursor: pointer; }
a:active, a:hover { color: #f28011; text-decoration: underline; }

.container { width: 700px; margin: 30px auto; }

/* paginate */
.page-navigation { clear: both; padding: 20px 0; text-align: center; }

.paginate {
	text-align: center;
	white-space: nowrap;
	font-size: 14px;	
}
.paginate a {
	border: 1px solid #ccc;
	color: #000;
	font-weight: 600;
	text-decoration: none;
	padding: 3px 7px;
	margin-left: 3px;
	vertical-align: middle;
}
.paginate a:hover, .paginate a:active {
	color: #6771ff;
}
.paginate span {
	border: 1px solid #e28d8d;
	color: #cb3536;
	font-weight: 600;
	padding: 3px 7px;
	margin-left: 3px;
	vertical-align: middle;
}
.paginate :first-child {
	margin-left: 0;
}
</style>

</head>
<body>

<div class="container">
	<h3> 페이징 처리 테스트 </h3>
	
	<div class="page-navigation">
		<%=paging %>
	</div>
</div>

</body>
</html>