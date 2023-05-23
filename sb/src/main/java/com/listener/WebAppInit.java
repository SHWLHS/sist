package com.listener;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Properties;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

//ServletContextListener : 웹 컨테이너가 시작되거나 종료될 때 발생하는 이벤트를 처리하는 리스너
//WebListener라는 어노테이션을 붙여야 리스너로 인식가능
@WebListener
public class WebAppInit implements ServletContextListener{
	private String pathname = "/WEB-INF/userCount.properties";//여기 경로에 저장
	
		
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		//서버가 시작되는 시점에 호출
		
		//실제 경로
		pathname = sce.getServletContext().getRealPath(pathname);
		
		loadFile();//불러오기
		
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		//서버가 종료되는 시점에 호출
		
		saveFile();//저장하기
		
	}
	
	protected void loadFile() {
		//서버에 저장된 접속자 수 불러오기
		
		long toDay, yesterDay, total;
		Properties p = new Properties();
		
		File f = new File(pathname);
		if(! f.exists()) {//파일이 존재하지 않으면 
			return; //리턴
		}
		
		try (FileInputStream fis = new FileInputStream(f)){
			p.load(fis);
			
			toDay = Long.parseLong(p.getProperty("toDay"));
			yesterDay = Long.parseLong(p.getProperty("yesterDay"));
			total = Long.parseLong(p.getProperty("total"));
			
			CountManager.init(toDay, yesterDay, total);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
	protected void saveFile() {
		// 서버에 접속자수를 프로퍼티로(파일) 저장
		long toDay, yesterDay, total;
		Properties p = new Properties();
		
		
		try(FileOutputStream fos = new FileOutputStream(pathname)) {
			toDay = CountManager.getToDayCount();
			yesterDay = CountManager.getYesterDayCount();
			total = CountManager.getTotalCount();
			
			p.setProperty("toDay", Long.toString(toDay));
			p.setProperty("yesterDay", Long.toString(yesterDay));
			p.setProperty("total", Long.toString(total));
			
			p.store(fos, "count");//저장
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
}
