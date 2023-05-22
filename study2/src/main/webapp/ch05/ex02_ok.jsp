<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
%>

<%-- Bean객체 생성 --%>
<jsp:useBean id="vo" class="ch05.user.User"/>

<%--생성된 Bean에 속성(프로퍼티 설정) --%>
<%--property="*"는 form input 요소의 name과 User클래스의 필드가 동일한 경우만 설정 --%>
<jsp:setProperty name="vo" property="*"/>

<%--form input 요소의 name과 User클래스의 필드가 다른 경우 설정 --%>
<%--보낸쪽의 이름 param, 받는쪽의 이름 property --%>
<jsp:setProperty name="vo" property="num" param="no"/>
<%
	String state = vo.getAge() >= 19? "성인":"미성년자";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p> 번호 : <%=vo.getNum() %></p>
<p> 이름 : <%=vo.getName() %></p>
<p> 나이 : <%=vo.getAge() %>, <%=state %></p>
<p> 좋아하는과목: <%=vo.getSubject() %></p>


</body>
</html>