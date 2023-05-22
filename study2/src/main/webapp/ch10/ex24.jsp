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

<h2>c:import 태그</h2>
<!-- 
	jsp:include 액션 태그와 유사
	서버 내부 및 외부 자원의 내용을 포함할 수 있다.
 -->
 
 <!-- 내부 자원 포함 -->
 <c:set var="url" value="ex22.jsp" />
 <c:import var="u" url="${url }" />
 <h3> <c:out value="${url }"/>소스 보기</h3>
 <c:out value="${u}"/>
 <hr>
 
 <h3> <c:out value="url"/> 실행결과 보기 </h3>
 <c:out value="${u}" escapeXml="false"/>
 <hr>
 
 <h3> c:import 태그에서 var 속성이 없으면 바로 실행 결과 출력</h3>
 <c:import  url="${url }" />
 <hr>
 
 
 
  <!-- 외부 자원 포함 -->
 <c:set var="url" value="https://www.naver.com" />
 <c:import var="u" url="${url }" />
 <h3> <c:out value="url"/>소스 보기</h3>
 <c:out value="${u}"/>
 <hr>
 
 <h3> <c:out value="url"/> 실행결과 보기 </h3>
 <c:out value="${u}" escapeXml="false"/>
 <hr>
 
 <h3> c:import 태그에서 var 속성이 없으면 바로 실행 결과 출력</h3>
 <c:import  url="${url }" />
 <hr>


</body>
</html>