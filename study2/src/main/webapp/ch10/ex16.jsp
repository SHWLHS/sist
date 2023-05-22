<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	request.setCharacterEncoding("utf-8");

	Map<String, Object> map = new HashMap<>();
	
	map.put("name","다자바");
	map.put("age","20");
	map.put("subject","스프링");
	
	List<Map<String, Object>> listMap = new ArrayList<>();
	Map<String, Object> m;
	
	m = new HashMap<>();
	m.put("name","하하하");
	m.put("city","서울");
	listMap.add(m);

	m = new HashMap<>();
	m.put("name","이순신");
	m.put("city","바다");
	listMap.add(m);

	m = new HashMap<>();
	m.put("name","가가가");
	m.put("city","경기");
	listMap.add(m);
	
	request.setAttribute("map", map);
	request.setAttribute("list", listMap);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>


<jsp:forward page="ex16_ok.jsp"/>

</body>
</html>