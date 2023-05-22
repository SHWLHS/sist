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

<h3>JSTL : choose - 다중 선택 구문</h3>

<form action="ex12.jsp" method="post">
	<p>
		<input type="text" name="num" placeholder="숫자" required="required" pattern="\d+">
		<button type="submit">확인</button>
	</p>
</form>

<c:if test="${not empty param.num}">
	<p>
		<c:choose>
			<c:when test="${param.num%3==0 and param.num%4==0}">
				${param.num } : 3또는 4의 배수
			</c:when>
						<c:when test="${param.num%3==0}">
				${param.num } : 3의 배수
			</c:when>
						<c:when test="${param.num%4==0}">
				${param.num } : 4의 배수
			</c:when>
			<c:otherwise>
				${param.num } : 3또는 4의 배수가 아님
			</c:otherwise>
		</c:choose>
	</p>
	
</c:if>


</body>
</html>