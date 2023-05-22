<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	request.setCharacterEncoding("utf-8");
%>

<%-- JSP 액션 태그 --%>

<%-- 
	Calculator calc = new Calculator(); 와 유사
	jsp:useBean -> 객체생성, id는 변수로써 역할 같은 변수명 있으면 에러
	class= ->클래스위치
 --%>
<jsp:useBean id="calc" class="ch05.calc.Calculator"/>


<%--
cal.setNum1(Integer.parseInt(request.getParameter("num1")));
cal.setNum2(Integer.parseInt(request.getParameter("num2")));
cal.setOperator(request.getParameter("operator")); 
	=>역할
	이름을 찾아서 데이터를 setter에 넘김
--%>
<jsp:setProperty name="calc" property="*"/>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>
<h3>액션태그(jsp:useBean)을 이용한 연산</h3>

<p><%=calc.toString() %></p>


</body>
</html>