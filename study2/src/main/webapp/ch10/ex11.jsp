<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>JSTL : if</h3>

<form action="ex11.jsp" method="post">
	<p>
		<input type="text" name="num" placeholder="숫자" required="required" pattern="\d+">
		<button type="submit">확인</button>
	</p>
</form>
<!-- c:if 태그는 조건이 참인 경우 실행하며 else 구문은 없다. -->

<!-- 처음에 param.num이 값이 안들어가있어서 null , null은 0이 되므로 짝수로 계산되서 짝수라고 나옴 -->
<!-- param.num이 널이 아니면 밑에있는것 출력 -->
<c:if test="${not empty param.num}">
	<p>	<!-- 첫번째 방법 -->
		${param.num} : ${param.num%2 ==0 ? "짝수":"홀수" }
	</p>
	
	<p>	<!-- 두번째 방법 -->
		${param.num} : 
		<c:if test="${param.num%2 == 0 }">짝수</c:if> <!--test(예약어) test의 내용이 참이면 내용 출력 -->
		<c:if test="${param.num%2 == 1 }">홀수</c:if>
	</p>
</c:if>
</body>
</html>