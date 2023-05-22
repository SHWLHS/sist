<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
	int num1 = Integer.parseInt(request.getParameter("num1"));
	int num2 = Integer.parseInt(request.getParameter("num2"));
	String operator = request.getParameter("operator");
	String result= "";
	
	switch(operator){
	case "+" : result = String.format("%d + %d = %d", num1,num2,num1+num2); break; 
	case "-" : result = String.format("%d - %d = %d", num1,num2,num1-num2); break; 
	case "*" : result = String.format("%d * %d = %d", num1,num2,num1*num2); break; 
	case "/" : result = String.format("%d / %d = %d", num1,num2,num1/num2); break; 
	}
	
	
	/*
	if(operator.equals("+")){
		result =String.format("%d + %d = %d", num1,num2,num1+num2);
	} else if(operator.equals("-")){
		result =String.format("%d - %d = %d", num1,num2,num1-num2);
	} else if(operator.equals("*")){
		result =String.format("%d * %d = %d", num1,num2,num1*num2);
	} else if(operator.equals("/")){
		result =String.format("%d / %d = %d", num1,num2,num1/num2);
	} 
	*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p>결과 : <%=result %></p>



</body>
</html>