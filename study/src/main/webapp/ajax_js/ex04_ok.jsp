<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String name = request.getParameter("name");
	String content = request.getParameter("content");

%>
<!-- xml은 내가만든태그! 루트가 하나 꼭 와야함 , 루트태그안에는 같은 태그가 와도 상관없음, 대소문자 정확하게하기 -->
<!-- <![CDATA[]]> : 태그가 아니라 문자열로 인식하는 것 -->
<guest>
	<dataCount>5</dataCount>
	<%for(int n=1; n<=5; n++) { %>
		<record num ="<%=n %>">
			<name><%=(char)(n+64)+"-"+name %></name>
			<content><![CDATA[<%=(char)(n+64)+"-"+content%>]]></content>
		</record>
	<%} %>
</guest>
