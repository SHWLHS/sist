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

<h3> JSTL - fmt 태그 : 숫자, 날짜, 시간을 포맷팅 하는 기능과 국제화, 다국어 지원</h3>

<p> default locale : <%=response.getLocale() %></p>
<p> default locale : ${pageContext.response.locale }</p>
<!-- 한국 : ko_KR -->


<h3>통화 기호</h3>
<p> 기본 통화기호 : <fmt:formatNumber value="12345.6789" type="currency"/> </p>
<p>
	<!-- $(미국) 로 통화기호 변경 -->
	<fmt:setLocale value="en_US"/>
	en_US(미국) 통화기호 : <fmt:formatNumber value="12345.6789" type="currency"/> 
</p>

<p>
	<!-- 엔화(일본) 로 통화기호 변경 -->
	<fmt:setLocale value="ja_JP"/>
	ja_JP(일본) 통화기호 : <fmt:formatNumber value="12345.6789" type="currency"/> 
</p>

<p>
	<!-- 한국 통화기호 변경 -->
	<fmt:setLocale value="ko_KR"/>
	한국 통화기호 : <fmt:formatNumber value="12345.6789" type="currency"/> 
</p>
<hr>

<h3>숫자</h3>
<p>number : <fmt:formatNumber value="12345.6789" type="number" /></p><!-- 12,345.679  -->
<p>currency : <fmt:formatNumber value="12345.6789" type="currency" /></p><!--  ₩12,346 -->
<p>currency : <fmt:formatNumber value="12345.6789" type="currency" currencySymbol="￦" /></p><!-- ￦12,346 -->
<p>percent : <fmt:formatNumber value="0.759" type="percent" /></p><!-- 76% -->
<p>pattern : <fmt:formatNumber value="12345.6789" pattern=".0" /></p><!-- 12345.7 -->
<p>pattern : <fmt:formatNumber value="12345.6789" pattern="#,##0.0" /></p><!-- 12,345.7 -->
<p>pattern : <fmt:formatNumber value="0.6789" pattern="#,##0.0" /></p><!-- 0.7  -->
<p>pattern : <fmt:formatNumber value="0.6789" pattern="#,###.0" /></p><!-- .7  -->
<p>pattern : <fmt:formatNumber value="12345.6789" pattern="￦#,##0.0" /></p><!--  ￦12,345.7  -->


<h3>날짜</h3>
<c:set var="now" value="<%=new java.util.Date() %>"/> <!-- 자바는 기본으로 미국형식 -->
<p>${now }</p> <!-- Thu Apr 27 15:13:14 KST 2023  -->
<p> date : <fmt:formatDate value="${now }" type="date"/></p> <!-- date : 2023. 4. 27. -->
<p> time : <fmt:formatDate value="${now }" type="time"/></p> <!-- time : 오후 3:13:14 -->
<p> both : <fmt:formatDate value="${now }" type="both"/></p> <!-- both : 2023. 4. 27. 오후 3:13:14 -->
<p> <fmt:formatDate value="${now }" type="both" dateStyle="full" timeStyle="full"/></p>
<!-- 2023년 4월 27일 목요일 오후 3시 13분 14초 대한민국 표준시 -->


</body>
</html>