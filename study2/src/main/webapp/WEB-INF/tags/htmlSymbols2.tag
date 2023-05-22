<%@ tag body-content="scriptless" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="trim" %>

<%--몸체로 전달 받은 내용을 var 속성의 지정한 scope 영역에 저장 --%>
<jsp:doBody var ="content" scope="page"/>

<%--엔터는 처리하지 않음 --%>
<c:out value="${content }"/>
