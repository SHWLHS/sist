<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	//컴퓨터시스템 날짜 구하기
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

</head>
<body>

<div class="calendar">
	<div class="title">
		<a href="calendar.jsp?year=<%=year%>&month=<%=month-1%>">&lt;</a>
		<label><%=year %>년 <%=month %>월</label>
		<a href="calendar.jsp?year=<%=year%>&month=<%=month+1%>">&gt;</a>
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
		<%	//지난달 날짜를 연하게 출력하기
			Calendar precal = (Calendar)cal.clone();//clone() : 다른주소로 같은 값복제
			precal.add(Calendar.DATE,-(week-1));
			int preDate = precal.get(Calendar.DATE);
			out.print("<tr>");
			for(int i =1; i<week; i++){
				//out.print("<td>&nbsp;</td>");
				out.print("<td class='gray'>"+(preDate++)+"</td>");
			}
			
			//1일~말일
			int lastDay = cal.getActualMaximum(Calendar.DATE);//getActualMaximum : 월의 마지막 날짜
			String cls;
			for(int i=1; i<=lastDay; i++){
				cls = year==ty&&month==tm&&i==td ? "today" : "";
				
				out.print("<td class='"+cls+"'>"+i+"</td>");
				
				//마지막날짜가 맞으면 tr닫기
				if(lastDay!=i && (++week)%7==1){
					out.print("</tr><tr>");
					
				}
			}
			
			//다음달 날짜를 연하게 출력하기
			int n=1;
			for(int i=(week-1)%7; i<6; i++){
				//out.print("<td>&nbsp;</td>");
				out.print("<td class='gray'>"+(n++)+"</td>");
			}
			out.print("</tr>");
		
		%>
		
		</tbody>
	</table>
	
	<div class="footer">
		<a href="calendar.jsp">오늘날짜로</a>
	</div>

</div>

</body>
</html>