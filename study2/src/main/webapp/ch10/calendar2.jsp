<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	//컴퓨터시스템 날짜 구하기(EL, JSTL로 바꾼것)
	request.setCharacterEncoding("utf-8");

	Calendar cal  = Calendar.getInstance();
	int ty = cal.get(Calendar.YEAR);
	int tm = cal.get(Calendar.MONTH) +1 ;
	int td = cal.get(Calendar.DATE);
	
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH) +1 ;
	
	String sy = request.getParameter("year");
	String sm = request.getParameter("month");
	
	//<>를 눌러야지 year나 month값이 넘어오는것 안넘어오면 null 넘어오면 null이 아님
	if(sy != null){//null이아니면 넘어온것
		year = Integer.parseInt(sy);
	}

	if(sm != null){//null이아니면 넘어온것
		month = Integer.parseInt(sm);
	}
	
	//달력 형식 맞춰주기 위해 cal객체에 다시 넣었다가 빼줌
	cal.set(year,month-1,1);
	year = cal.get(Calendar.YEAR);
	month = cal.get(Calendar.MONTH) +1 ;
	
	int week = cal.get(Calendar.DAY_OF_WEEK);//1(일)~7(토)
	int lastDate = cal.getActualMaximum(Calendar.DATE);
	
	
	
	Calendar preCal = (Calendar)cal.clone();
	preCal.add(Calendar.DATE,-(week-1));
	int preDate = preCal.get(Calendar.DATE);
	
	pageContext.setAttribute("ty",ty);
	pageContext.setAttribute("tm",tm);
	pageContext.setAttribute("td",td);
	
	pageContext.setAttribute("year", year);
	pageContext.setAttribute("month",month);
	pageContext.setAttribute("lastDate",lastDate);
	pageContext.setAttribute("preDate",preDate);

	pageContext.setAttribute("week",week);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
* { margin: 0; padding: 0; }
*, *::after, *::before { box-sizing: border-box; }

body { font-size: 14px; font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif; }

a { color: #000; text-decoration: none; cursor: pointer; }
a:active, a:hover { text-decoration: underline; color: #F28011; }

.btn {
	padding: 5px 10px;
	font-size: 14px; font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	color: #333; font-weight: 500;
	border: 1px solid #999; border-radius: 4px;
	background-color: #fff;
	cursor:pointer;
	vertical-align: baseline;
}
.btn:active, .btn:focus, .btn:hover {
	color:#333;
	background-color: #f8f9fa;
}
.btn[disabled], fieldset[disabled] .btn {
	pointer-events: none;
	cursor: default;
	opacity: .65;
}

.form-control {
	padding: 5px 5px; 
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	border: 1px solid #999; border-radius: 4px; background-color: #fff;
	vertical-align: baseline;
}
.form-control[readonly] { background-color:#f8f9fa; }

textarea.form-control { height: 170px; resize : none; }

.form-select {
	padding: 4px 5px; 
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	border: 1px solid #999; border-radius: 4px; background-color: #fff;
	vertical-align: baseline;
}
.form-select[readonly] { background-color:#f8f9fa; }

textarea:focus, input:focus { outline: none; }
input[type=checkbox], input[type=radio] { vertical-align: middle; }

/* table */
.table { width: 100%; border-spacing: 0; border-collapse: collapse; }
.table th, .table td { padding-top: 10px; padding-bottom: 10px; }

.table-border thead > tr { border-top: 2px solid #212529; border-bottom: 1px solid #ced4da; }
.table-border tbody > tr { border-bottom: 1px solid #ced4da; }
.table-border tfoot > tr { border-bottom: 1px solid #ced4da; }
.td-border td { border: 1px solid #ced4da; }

.border { border: 1px solid #ced4da; }
.border-top { border-top: 1px solid #ced4da; }
.border-bottom { border-bottom: 1px solid #ced4da; }

.text-left { text-align: left; padding-left: 10px; }
.text-right { text-align: right; padding-right: 10px; }
.text-center { text-align: center; }

.clear { clear: both; }
.clear:after { content:''; display:block; clear: both; }

/* layout */
.calendar { width: 280px; margin: 30px auto; }
.calendar .title{ padding: 7px; text-align: center; font-weight: 600; }

.calendar select.form-select { padding: 2px 6px; }

.calendar table thead tr:first-child { background: #f6f6f6; }
.calendar table td { padding: 10px; text-align: center; border: 1px solid #ced4da; }
.calendar table td:nth-child(7n+1) { color: red; }
.calendar table td:nth-child(7n) { color: blue; }
.calendar table td.gray { color: #ccc; }
.calendar table td.today{ font-weight:700; background: #E6FFFF; }

.calendar .footer{ height: 25px; line-height: 25px; text-align: right; font-size: 11px; }
</style>

<script type="text/javascript">
function change(){
	const f = document.calendarForm;
	f.action = "calendar2.jsp";//엑션을 주지 않아도 기본으로 자기자신
	f.submit();
}
</script>

</head>
<body>

<div class="calendar">
	<div class="title">
			<form name="calendarForm" method="post">
				
				<select name="year" class="form-select" onchange="change()">
				<c:forEach var="i" begin="${year-5 }" end="${year+5 }" >
					<option value="${i }"${ year==i? "selected='selected'":"" }>${i }년</option>
					</c:forEach>
				</select>
				
				<select name="month" class="form-select" onchange="change()">
				<c:forEach var="i" begin="1" end="12" >
					<option value="${i }"${ month==i? "selected='selected'":"" }>${i }월</option>
					</c:forEach>
				</select>
				
				
		</form>
	</div>
	
	<table class="table">
		<thead>
			<tr>
				<td>일</td>
				<td>월</td>
				<td>화</td>
				<td>수</td>
				<td>목</td>
				<td>금</td>
				<td>토</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<c:forEach var="i" begin="${preDate }" end="${preDate+week-2 }">
					<td class="gray">${i}</td>
				</c:forEach>	
				
				<c:forEach var="i" begin="1" end="${lastDate}">
					<c:set var="cls" value="${year == ty && month==tm && i==td?'today':'' }"/>
					<td class="${cls }">${i }</td>
					<c:set var="week" value="${week+1 }"/>
					<c:if test="${lastDay != i && week%7==1 }">
						<c:out value="</tr><tr>" escapeXml="false"/>
					</c:if>
				</c:forEach>
				
				<c:set var="n" value="1"/>
				<c:if test="${week%7!=1 }">
					<c:set var="w" value="${week%7==0? 7:week%7 }"/>
					<c:forEach var="i" begin="${w }" end="7">
						<td class="gray">${n }</td>
						<c:set var="n" value="${n+1 }"/>
					</c:forEach>
				</c:if>
			</tr>
		
		</tbody>
	</table>
	
	<div class="footer">
		<a href="calendar2.jsp">오늘날짜로</a>
	</div>

</div>

</body>
</html>