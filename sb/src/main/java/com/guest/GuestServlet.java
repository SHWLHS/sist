package com.guest;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.member.SessionInfo;
import com.util.MyServlet;
import com.util.MyUtil;
import com.util.MyUtilBootstrap;

@WebServlet("/guest/*")
public class GuestServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
		
		// uri에 따른 작업 구분
		if (uri.indexOf("main.do") != -1) {
			main(req, resp);
		} else if (uri.indexOf("list.do") != -1) {
			list(req, resp);
		} else if (uri.indexOf("insert.do") != -1) {
			writeSubmit(req, resp);
		} else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		}
	}
	
	protected void main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/guest/guest.jsp");
	}

	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 방명록 리스트
		GuestDAO dao = new GuestDAO();
		MyUtil util = new MyUtilBootstrap();
		JSONObject job = new JSONObject();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			// 넘어온 페이지
			String page = req.getParameter("pageNo");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			int dataCount = dao.dataCount();
			
			// 전체페이지수 구하기
			int size = 5;
			int total_page = util.pageCount(dataCount, size);
			
			// 전체페이지보다 표시할 페이지가 큰경우
			if(total_page < current_page) {
				current_page = total_page;
			}
			
			// 데이터 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<GuestDTO> list = dao.listGuest(offset, size);
			
			for(GuestDTO dto : list) {
				dto.setContent(dto.getContent().replaceAll(">", "&gt;"));
				dto.setContent(dto.getContent().replaceAll("<", "&lt;"));
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
				
				if(info != null && (info.getUserId().equals("admin") || info.getUserId().equals(dto.getUserId()))) {
					dto.setDeletePermit(true);
				}
			}
			
			// String paging = util.pagingMethod(current_page, total_page, "listPage");

			job.put("list", list);
			job.put("dataCount", dataCount);
			job.put("pageNo", current_page);
			job.put("total_page", total_page);
			// job.put("paging", paging);
			job.put("state", "true");

		} catch (Exception e) {
			job.put("state", "false");
			e.printStackTrace();
		}
		
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.println(job.toString());
		
	}
	
	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 방명록 저장
		GuestDAO dao = new GuestDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		if (info == null) { // 로그인되지 않은 경우
			resp.sendError(403);
			return;
		}

		String state = "false";
		try {
			GuestDTO dto = new GuestDTO();
			dto.setUserId(info.getUserId());
			dto.setContent(req.getParameter("content"));
			dao.insertGuest(dto);
			state = "true";
		} catch (Exception e) {
			e.printStackTrace();
		}

		JSONObject job = new JSONObject();
		job.put("state", state);

		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
	}
	
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 방명록 삭제
		GuestDAO dao = new GuestDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if (info == null) {
			resp.sendError(403);
			return;
		}
		
		String state = "false";
		try {
			long num = Long.parseLong(req.getParameter("num"));

			dao.deleteGuest(num, info.getUserId());
			state = "true";
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		JSONObject job = new JSONObject();
		job.put("state", state);

		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
	}
}
