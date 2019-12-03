package kh.jomalone.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.jomalone.DAO.MembersDAO;
import kh.jomalone.DTO.MembersDTO;


@WebServlet("*.mem")
public class AdminMemController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI().substring(request.getContextPath().length());
		System.out.println(cmd);
		MembersDAO dao = MembersDAO.getInstance();
		request.setCharacterEncoding("UTF8");
		
		try {
		if(cmd.contentEquals("/admin.mem")) {
			String adminid = (String)request.getSession().getAttribute("AdminId");
			if(adminid != null) {
				List<MembersDTO> list = dao.selectAll();
				for(MembersDTO dto : list) {
					System.out.println(dto.getId());
				}
				request.setAttribute("list", list);
				request.getRequestDispatcher("/admin.jsp").forward(request, response);	
				
			}else {
				request.getRequestDispatcher("/admin.jsp").forward(request, response);	
			}
			
		}else if(cmd.contentEquals("/adminlogout.mem")) {
			request.getSession().invalidate();
			response.sendRedirect("home.jsp");
			
			
		}else if(cmd.contentEquals("/search.mem")) {
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String phone = request.getParameter("phone");
			
			System.out.println(id + name + phone);
				List<MembersDTO> list = dao.search(id,name,phone);	
				for(MembersDTO dto : list) {
					System.out.println(dto.getLogintype());
				}
				request.setAttribute("list", list);
				request.getRequestDispatcher("/admin.jsp").forward(request, response);	
			
			
			
			
			
			
			
			
		}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
