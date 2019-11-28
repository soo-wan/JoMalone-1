package kh.jomalone.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.jomalone.DAO.MembersDAO;

@WebServlet("*.log")
public class loginController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI().substring(request.getContextPath().length());
		System.out.println(cmd);
		request.setCharacterEncoding("UTF8");
		
		try {
			if(cmd.contentEquals("/Member/login.log")) {
				String id = request.getParameter("id");
				String pw = request.getParameter("pw");
				System.out.println(id);
				System.out.println(pw);
				
				MembersDAO dao = MembersDAO.getInstance();
				boolean result = dao.login(id, pw);
				System.out.println(result);
				
				if(result) {
					request.getSession().setAttribute("loginInfo", id);
					String info = (String)request.getSession().getAttribute("loginInfo");
					System.out.println(info);
					response.getWriter().append("{\"result\" : \""+ result +"\"}");
					
				}else {
					response.getWriter().append("{\"result\" : \""+ result +"\"}");
				}
			}

		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}