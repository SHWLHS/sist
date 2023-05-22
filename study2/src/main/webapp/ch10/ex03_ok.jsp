<%@page import="ch10.user.User"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<!-- 
	* EL의 주목적
		request, pageContext, session 등에서 설정한 속성(attribute)을 
		클라이언트에게 전송하기 위해 사용한다.
 -->

<h3>EL을 사용하지 않는 경우</h3>
<%	//다이렉트로 실행하면 setAttribute를 안한게 되어서 오류
	User user = (User)request.getAttribute("vo");//return타입이 오브젝트이기때문에 다운캐스팅
	String s = request.getParameter("city");//추가한 파라미터 가져옴
%>

<p> <%=user.getName() %>, <%=user.getAge() %> , <%=user.getSubject() %> </p> <!-- null이 그대로 출력 -->
<p> <%= s %> </p>
<hr>



<h3>EL을 사용한 경우</h3>
<!-- vo객체가 null일때 null을 출력 안하므로 다이렉트로 실행하여도 에러가 안남 -->
<!-- 필드값이 null 인 경우 아무것도 출력되지 않는다. -->
<p> ${ vo.name },${ vo.age }, ${ vo.age >= 19 ? "성인" : "미성년자" }, ${vo.subject} </p>

<!--  파라미터는 param 이라는 EL 내장 객체 사용  -->
<p> ${param.city }</p><!-- request.getParameter("city") 와 유사  -->



</body>
</html>