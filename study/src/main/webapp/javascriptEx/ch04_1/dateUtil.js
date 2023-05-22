



//날짜 형식 검사(올바르면 true, 올바르지 않으면 false)
function isValidDateFormat(date){
	let p = /^[12][0-9]{3}[\.|\-|\/]?[0-9]{2}[\.|\-|\/]?[0-9]{2}$/;
	if(! p.test(date)){//정규식이 틀리면 리턴
		return false;
	}
	
	date = date.replace(/(\.)|(\-)|(\/)/g,"");//. - / 를 없앰
	
	let y = parseInt(date.substring(0,4));
	let m = parseInt(date.substring(4,6));
	let d = parseInt(date.substring(6));
	
	if(m < 1 || m > 12){//1~12월이 아니면 리턴
		return false;
	}
	
	let lastDay = (new Date(y,m,0)).getDate();//마지막 날짜 구함
	if(d < 1 || d > lastDay){//1~마지막날짜가 아니면 리턴
		return false;
	}
	
	return true;
}

//날짜를 문자열로 변환
function dateToString(date){
	
	let y = date.getFullYear();
	
	let m = date.getMonth() + 1;
	if(m< 10) m = '0' + m;
	
	let d = date.getDate();
	if(d < 0 ) d ='0' + d;

	return `${y}-${m}-${d}`;
}

//기준일부터 몇일 후(기준일을 포함)
function daysLater(startDate, days){
	if(! isValidDateFormat(startDate)){
		throw '날짜 형식이 올바르지 않습니다.'
	}
	
	let y,m,d;
	let date = new Date();
	
	startDate = startDate.replace(/(\.)|(\-)|(\/)/g,"");
	y = parseInt(startDate.substring(0,4));
	m = parseInt(startDate.substring(4,6));
	d = parseInt(startDate.substring(6)) + parseInt(days) -1;//문자로 넘어올수있어서 숫자로 변경
	
	date.setFullYear(y,m-1,d); //이미 존재하는 데이터에 날짜를 변경?
	
	return dateToString(date);//함수를 따로 만들어서 바로 문자로 고쳐줌
	
}

//두 날짜사이에 간격 계산
function toDiffDays(startDate,endDate){
		if(! isValidDateFormat(startDate) || ! isValidDateFormat(endDate)){
		throw '날짜 형식이 올바르지 않습니다.'
	}
	
	startDate = startDate.replace(/(\.)|(\-)|(\/)/g,"");
	endDate = endDate.replace(/(\.)|(\-)|(\/)/g,"");
	
	let sy = parseInt(startDate.substring(0,4));
	let sm = parseInt(startDate.substring(4,6));
	let sd = parseInt(startDate.substring(6));
	
	let ey = parseInt(endDate.substring(0,4));
	let em = parseInt(endDate.substring(4,6));
	let ed = parseInt(endDate.substring(6));
	
	//endDate에서 startDate까지 날수 계산
	let date1 = new Date(sy,sm-1,sd);
	let date2 = new Date(ey,em-1,ed);
	
	let dif = date2.getTime() - date1.getTime();//밀리세컨드
	
	let day = Math.floor(dif / (24 * 3600 * 1000));//밀리세컨드를 일수로 고침
	
	return day +1;
	
	
}

//나이계산
function toAge(birth){
		if(! isValidDateFormat(birth)){
		throw '날짜 형식이 올바르지 않습니다.'
	}
	
	birth = birth.replace(/(\.)|(\-)|(\/)/g,"");
	
	let y = parseInt(birth.substring(0,4));
	let m = parseInt(birth.substring(4,6));
	let d = parseInt(birth.substring(6));
	
	let bd = new Date(y,m-1,d);//입력한 생년월일
	let nd = new Date();//현재날짜
	
	let age = nd.getFullYear() - bd.getFullYear();
	
	//생일의 월이 지금월보다 크거나 ,생일의 월이 지금월보다 같으면서 일이 클때
	if(bd.getMonth() > nd.getMonth() || 
		bd.getMonth() === nd.getMonth() && bd.getDate() > nd.getDate()){
			age--;
		}
	
	return age;
	
}











