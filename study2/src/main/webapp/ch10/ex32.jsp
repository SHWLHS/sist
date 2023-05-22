<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> JSTL - function 태그</h3>
<c:set var="str" value="seoul korea"/>
<p> ${fn:contains(str,'kor')? "kor존재":"kor없음" }</p> <!-- EL에서 쌍따옴표,홑따옴표 상관없음 -->
<p> ${fn:containsIgnoreCase(str,'SEOUL')? "SEOUL존재":"SEOUL없음" }</p> <!-- containsIgnoreCase대소문자 구분  -->
<p> ${fn:startsWith(str,'kor')? "kor로 시작":"kor로 시작 안함" }</p> 
<p> ${fn:endsWith(str,'korea')? "korea로 종료":"korea로 종료 안함" }</p> 
<p> ${fn:indexOf(str,'kor')}</p> 
<p> ${fn:substring(str,6,9)}</p> 
<p> ${fn:substringAfter(str,"seoul")}</p> 
<p> ${fn:substringBefore(str,"korea")}</p> 
<p> ${fn:length(str)}</p> 
<p> ${fn:replace(str,"korea","한국")}</p> 
<p> ${fn:toUpperCase(str)}</p> 



</body>
</html>