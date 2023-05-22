<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String name = request.getParameter("name");
	String content = request.getParameter("content");
	
	//JSON 형식-1 : {"이름1":"값1", "이름2":"값2", "이름3":"값3"}
	//JSON 형식-2 : {"이름" : [{"이름1":"값1", "이름2":"값2"},{"이름1":"값1", "이름2":"값2"}]}
	
	/*
	StringBuilder sb = new StringBuilder();
	sb.append("{");
	sb.append(" \"name\":\" "+name+ " \" ");
	sb.append(",\"content\":\" "+content+" \" ");
	sb.append("}");
	out.print(sb.toString());
	*/
	
	JSONObject job = new JSONObject();//{}만듦
	job.put("count",5);//"count":"5"를 만들어서 {}넣음
	
	JSONArray jarr = new JSONArray();//배열 []만듦
	for(int i=1; i<=5; i++){
		JSONObject ob = new JSONObject();// {} 만듦
		ob.put("num",i); //"num":"i"
		ob.put("name",(char)(i+64)+"-"+name);//"name":"name"
		ob.put("content",(char)(i+64)+"-"+content);//"content":"content"
		
		jarr.put(ob);//ob를 배열에 넣음
		
	}
	
	job.put("list",jarr);//"list":"배열(jarr)" 
	
	out.print(job.toString());

%>
