<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="javax.management.StandardEmitterMBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.NumberFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

/* form-control */
.btn {
	color: #333;
	border: 1px solid #999;
	background-color: #fff;
	padding: 5px 10px;
	border-radius: 4px;
	font-weight: 500;
	cursor:pointer;
	font-size: 14px;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	vertical-align: baseline;
}
.btn:active, .btn:focus, .btn:hover {
	background-color: #f8f9fa;
	color:#333;
}
.btn[disabled], fieldset[disabled] .btn {
	pointer-events: none;
	cursor: default;
	opacity: .65;
}

.form-control {
	border: 1px solid #999; border-radius: 4px; background-color: #fff;
	padding: 5px 5px; 
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	vertical-align: baseline;
}
.form-control[readonly] { background-color:#f8f9fa; }

textarea.form-control { height: 170px; resize : none; }

.form-select {
	border: 1px solid #999; border-radius: 4px; background-color: #fff;
	padding: 4px 5px; 
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
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

.container { width: 500px; margin:30px auto; }

.title { width:100%; font-size: 16px; font-weight: bold; padding: 13px 0; }

.table-article td {border: 1px solid #ced4da; }
.table-article tr > td:first-child {
	text-align: center; background: #f8f9fa; width: 100px; text-align: right; padding-right: 10px; }
.table-article tr > td:nth-child(2) { padding-left: 10px; }
</style>


<%
	//post방식
	request.setCharacterEncoding("utf-8");
	
	//request로 값 가져오기
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String phone = request.getParameter("phone");
	int salary = Integer.parseInt(request.getParameter("salary"));
	int bonus = Integer.parseInt(request.getParameter("bonus"));
	
	int sum = salary+bonus;
	
	//3자리마다 콤마 붙여주기
	DecimalFormat dc = new DecimalFormat("###,###,###,###");
	String rsalary = dc.format(salary) ;
	String rbonus = dc.format(bonus) ;
	
	//나이 구하기
	
	int y = Integer.parseInt(birth.substring(0,4));
	int m = Integer.parseInt(birth.substring(4,6));
	int d = Integer.parseInt(birth.substring(8));
			
	Calendar cal = Calendar.getInstance();
			
	int age = cal.get(Calendar.YEAR)-y;
	if(m>cal.get(Calendar.MONTH)+1 || 
		(m == cal.get(Calendar.MONTH)+1 && d> cal.get(Calendar.DAY_OF_MONTH))) {
			age--;
		}

	//띠 구하기
	String [] ddi = new String[] {"원숭이","닭","개","돼지","쥐","소","범","토끼","용","범","말","양"};
	
	//세금 (기본급+수당이 300만원 이상이면 3%, 200만원 이상이면 2% 나머지는0)
	double tax = 0;
	
	if(sum >= 300){
		tax = sum*0.03;
	}else if(sum >= 200){
		tax = sum*0.02;
	}else{
		tax =0;
	}
	
	String rtax = dc.format(tax) ;
	
	//실급여 기본급+수당-세금
	int total = sum-(int)tax;
	
	String rtotal = dc.format(tax) ;

%>


</head>
<body>

<div class="container">
	<div class="title">
	    <h3><span>|</span> 인사관리</h3>
	</div>
	
	<table class="table table-border td-border table-article">
		<tr>
			<td>이름</td>
			<td><%=name %></td>
		</tr>
		<tr>
			<td>생년월일</td>
			<td><%=birth %>
		</tr>
		<tr>
			<td>띠</td>
			<td><%=ddi[y%12] %>띠  </td>
		</tr>
		<tr>
			<td>나이</td>
			<td><%=age %>살</td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><%=phone %></td>
		</tr>
		<tr>
			<td>기본급</td>
			<td>\<%=rsalary %>원</td>
		</tr>
		<tr>
			<td>수당</td>
			<td>\<%=rbonus %>원</td>
		</tr>
		<tr>
			<td>세금</td>
			<td>\<%=rtax %>원 </td>
		</tr>
		<tr>
			<td>실급여</td>
			<td>\<%=rtotal %>원 </td>
		</tr>
	</table>
	
	
</div>	

</body>
</html>