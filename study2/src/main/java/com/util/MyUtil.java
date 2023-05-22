package com.util;

public class MyUtil {
	/**
	 * 전체 페이지 수 구하기
	 * @param dataCount 총데이터 개수
	 * @param size		한화면에 출력할 데이터개수
	 * @return			전체 페이지 수
	 */
	public int pageCount(int dataCount, int size) {
		if(dataCount <= 0) {
			return 0;
		}
		return dataCount/ size + (dataCount % size >0? 1:0);
	}
	
	
	
	/**
	 * 페이징 처리(GET 방식)
	 * @param current_page	현재 화면에 표시되는 페이지(ex 3페이지)
	 * @param total_page	전체 페이지 수
	 * @param list_url		링크를 설정할 주소
	 * @return				페이징 처리 결과
	 */
	public String paging(int current_page, int total_page, String list_url) {
		StringBuilder sb = new StringBuilder();
		
		int numPerBlock = 10;
		int currentPageSetup;
		int n, page;
		
		if(current_page <1 || total_page <current_page) {
			return "";
		}
		
		if(list_url.indexOf("?") != -1) {//넘어온 주소에 물음표가 있으면 
			list_url +="&";
		}else {
			list_url += "?";
		}
		
		//currentPageSetup 표시할 첫페이지 - 1
		currentPageSetup = (current_page / numPerBlock) * numPerBlock;//1의자리 없애서 47->40이 됨
		if(current_page % numPerBlock ==0) {//나눠서 떨어지면 10빼기(ex. 60페이지일 경우 표시할첫페이지는 50이 되야함)
			currentPageSetup = currentPageSetup - numPerBlock;
		}
		
		sb.append("<div class='paginate'>");
		
		//처음 , 이전 (앞으로 10페이지)
		n = current_page - numPerBlock;
		if(total_page > numPerBlock && currentPageSetup >0) {//페이지수가 10페이지 이하이거나 첫페이지가 1이면 처음과 이전이 안나오게 설정
			sb.append("<a href='"+list_url+"page=1'>처음</a>");
			sb.append("<a href='"+list_url+"page="+n+"'>이전</a>");
		}
		//페이징
		page = currentPageSetup +1;
		while(page<= total_page && page <= (currentPageSetup+numPerBlock)) {
			if(page == current_page) {
				sb.append("<span>"+page+"</span>");
			}else {
				sb.append("<a href='"+list_url+"page="+page+"'>" + page+"</a>");
			}
			page++;
			
		}
		
		//다음(뒤로 10페이지), 마지막
		n = current_page + numPerBlock;
		if(n>total_page) n = total_page;
		if(total_page - currentPageSetup>numPerBlock) {
			sb.append("<a href='"+list_url+"page="+n+"'>다음</a>");
			sb.append("<a href='"+list_url+"page="+total_page+"'>끝</a>");
		}
		
		
		sb.append("</div>");
		
		
		return sb.toString();
	}
	
	
	//이전과 다음은 한페이지씩 이동 
	public String pagingUrl(int current_page, int total_page, String list_url) {
		StringBuilder sb = new StringBuilder();
		
		int numperBolck = 10;
		int n , page;
		
		if(current_page < 1 || total_page < current_page) {
			return "";
		}
		
		if(list_url.indexOf("?") != -1) {
			list_url +="&";
		}else {
			list_url +="?";
		}
		
		page = 1; //출력시작 페이지
		if(current_page > (numperBolck / 2) +1) {//current_page가 7이상이면
			page = current_page - (numperBolck / 2);//page = 현재페이지-5 ->현재페이지가 중앙에 오게 설정
			
			n = total_page - page;//n = 전체페이지 - 현재페이지-5 -> 마지막페이지때는 앞에 5개가 나오는게 아니라 뒤에 5개가 있을때까지만 가운데 오게 설정
			
			if( n < numperBolck) { //n이 10보다 작으면
				page = total_page - numperBolck + 1; //page = 총페이지 - 11
			}
			
			if(page < 1) page =1;// page가 0아래이면 1
		}
		
		sb.append("<div class='paginate'>");
		
		//처음
		if(page > 1) {//페이지가 2부터 처음보이기
			sb.append("<a href='"+list_url+"page=1' title='처음'>&#x226A</a>");
		}
		
		//이전(한페이지 앞)
		n = current_page -1;
		if(current_page > 1) {
			sb.append("<a href='"+list_url+"page="+n+"'title='이전'>&#x003C</a>");
		}
		
		n = page;
		while(page <= total_page && page < n + numperBolck) {
			if(page == current_page) {
				sb.append("<span>"+page+"</span>");
			}else {
				sb.append("<a href='"+list_url+"page="+page+"'>"+page+"</a>");
			}
			page++;
		}
		
		//다음(한페이지 뒤)
		n = current_page + 1;
		if(current_page < total_page) {
			sb.append("<a href='"+list_url+"page="+n+"'title='다음'>&#x003E</a>");
		}
		
		//마지막 페이지
		if(page <= total_page) {
			sb.append("<a href='"+list_url+"page="+total_page+"' title='끝'>&#x226B</a>");
		}
		
		
		sb.append("</div>");
		
		
		
		
		
		return sb.toString();
	}
	
}
