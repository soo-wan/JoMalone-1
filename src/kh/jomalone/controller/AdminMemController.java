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


@WebServlet("*.admin")
public class AdminMemController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI().substring(request.getContextPath().length());
		System.out.println(cmd);
		MembersDAO dao = MembersDAO.getInstance();
		request.setCharacterEncoding("UTF8");
		
		if(cmd.contentEquals("/member.admin")) {
			try {
			List<MembersDTO> list = dao.selectAll();
			for(MembersDTO dto : list) {
				System.out.println(dto.getId());
			}
			request.setAttribute("list", list);
			request.getRequestDispatcher("Member/adminmember.jsp").forward(request, response);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
