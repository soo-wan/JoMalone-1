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


@WebServlet("*.my")
public class profileController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI().substring(request.getContextPath().length());
		System.out.println(cmd);
		request.setCharacterEncoding("UTF8");
		MembersDAO dao = MembersDAO.getInstance();
		
		if(cmd.contentEquals("/Member/profile.my")) {
			try {
			String id =(String)request.getSession().getAttribute("loginInfo");
			MembersDTO dto =dao.selectById(id);
			request.getSession().setAttribute("dto", dto);
			request.getRequestDispatcher("profile22.jsp").forward(request, response);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
