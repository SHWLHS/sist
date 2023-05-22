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

<h3>AJAX - POST : XML </h3>

<div>
	<p> 이름 : <input type="text" id="name"> </p>
	<p> 내용 : <textarea rows="5" cols="50" id="content"></textarea> </p>
	<p><button type="button" onclick="sendOk();">결과</button></p>
</div>
<hr>

<div class="result-layout"></div>

<script type="text/javascript">
var httpReq = null;//전역변수로 설정

function sendOk(){
	let a = document.querySelector("#name").value;
	let b = document.querySelector("#content").value;
	
	let url = "ex04_ok.jsp";
	let query = "name="+a+"&content="+encodeURIComponent(b);//
	
	
	//AJAX 객체 생성
	httpReq= new XMLHttpRequest();//통신할수있는객체
	
	//서버에서 처리하고 결과를 전송할때 호출할 자바 스크립트 함수 지정
	httpReq.onreadystatechange = callback;//서버가 결과 처리하고 돌아오면 callback 함수로 가게끔 설정
	
	//open - AJAX 요청 형식 지정
	httpReq.open("POST",url,true);//true는 비동기
	
	//post 방식은 필수로해야하는것
	httpReq.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	
	//send
	httpReq.send(query);//서버전송 send에 query넣어주기
	
	
}

function callback(){
	//console.log(httpReq.readyState,httpReq.status);
	
	if(httpReq.readyState === 4){//요청 상태 : 4 -  모든 응답 요청 완료
		if(httpReq.status === 200){//응답 상태 코드 : 200 - 성공
			printData();
		}
	}
}

function printData(){
	//XML
	let xmlDoc = httpReq.responseXML;
	//console.log(xmlDoc);
	
	
	//getElementsByTagName : 반환값 배열
	let root = xmlDoc.getElementsByTagName("guest")[0];//없어도 가능
	let dataCount = xmlDoc.getElementsByTagName("dataCount")[0].firstChild.nodeValue;
	
	let out = "<p>데이터 개수 : " + dataCount + "</p>";
	
	let records = root.getElementsByTagName("record");
	for(let item of records){
		let num = item.getAttribute("num");
		let name = item.getElementsByTagName("name")[0].firstChild.nodeValue;
		let content = item.getElementsByTagName("content")[0].firstChild.nodeValue;
		
		out += "<p>번호 : "+ num + "<br>";
		out += "<p>이름 : "+ name + "<br>";
		out += "<p>내용 : "+ content + "</p>";
		out += "<hr>";
	}
	
	
	document.querySelector(".result-layout").innerHTML = out

}

</script>



</body>
</html>