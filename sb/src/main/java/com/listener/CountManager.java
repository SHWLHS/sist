package com.listener;

import java.util.Calendar;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

//HttpSessionListener : 세션이 생성되거나 소멸될때 발생하는 이벤트를 처리하는 리스너
@WebListener
public class CountManager implements HttpSessionListener{//현재 접속자 
	private static int currentCount;
	private static long toDayCount;
	private static long yesterDayCount;
	private static long totalCount;
	
	public CountManager() {
		//자정이 되면 오늘 인원은 어제 인원으로 변경되고, 오늘인원은 0으로 변경한다
		TimerTask task = new TimerTask() {
			
			@Override
			public void run() {
				yesterDayCount = toDayCount; //어제 인원은 오늘인원으로 set
				toDayCount = 0; //오늘 인원은 0으로 초기화
			}
		};
		Timer timer = new Timer();
		Calendar cal = Calendar.getInstance();
		//내일 자정
		cal.add(Calendar.DATE, 1);//내일 지금시간
		cal.set(Calendar.HOUR, 0);//0시
		cal.set(Calendar.MINUTE, 0);//0분
		cal.set(Calendar.SECOND, 0);//0초
		cal.set(Calendar.MILLISECOND, 0);//밀리세컨드0
		
		//오늘밤 12시부터 시작해서, 밤 12시마다 1번씩 실행 ,cal.getTime():시작시간 , 100*60*60*24:하루
		timer.schedule(task, cal.getTime(), 100*60*60*24);
		
	}
	
	public static void init(long toDay, long yesterDay, long total) {
		toDayCount = toDay;
		yesterDayCount = yesterDay;
		totalCount = total;
	}

	
	//getter만 설정
	public static int getCurrentCount() {
		return currentCount;
	}

	public static long getToDayCount() {
		return toDayCount;
	}

	public static long getYesterDayCount() {
		return yesterDayCount;
	}

	public static long getTotalCount() {
		return totalCount;
	}

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		//세션이 만들어질 때
		HttpSession session = se.getSession();
		ServletContext context = session.getServletContext();
		
		//동기화 블럭(세션이 동시에 만들어질 가능성이 있기때문에 )
		synchronized (session) {
			currentCount++;//현재
			toDayCount++;//오늘
			totalCount++;//전체 접속자 수 증가
			
			//값들 저장
			context.setAttribute("currentCount", currentCount);
			context.setAttribute("toDayCount", toDayCount);
			context.setAttribute("totalCount", totalCount);
			context.setAttribute("yesterDayCount", yesterDayCount);
		}
		
		
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		//세션이 소멸될 때 
		HttpSession session = se.getSession();
		ServletContext context = session.getServletContext();
		
		synchronized (se) {
			currentCount--;
			if(currentCount < 0) {//0보다 작아질 경우 0으로 만듦(혹시몰라서)
				currentCount=0;
			}
			
			context.setAttribute("currentCount", currentCount);
			context.setAttribute("toDayCount", toDayCount);
			context.setAttribute("totalCount", totalCount);
			context.setAttribute("yesterDayCount", yesterDayCount);
			
			
		}
		
		
		
	}
	
	
	
	
	
	
}
