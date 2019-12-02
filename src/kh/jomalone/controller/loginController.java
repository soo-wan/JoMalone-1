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
import kh.jomalone.Util.encrypt;

@WebServlet("*.log")
public class loginController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI().substring(request.getContextPath().length());
		System.out.println(cmd);
		MembersDAO dao = MembersDAO.getInstance();
		request.setCharacterEncoding("UTF8");
		
		try {
			if(cmd.contentEquals("/Member/login.log")) {
				String id = request.getParameter("id");
				String pw = encrypt.encrypt(request.getParameter("pw"));
				System.out.println(id);
				System.out.println(pw);
				
				boolean result = dao.login(id, pw);
				System.out.println(result);
				
				
				if(result) {
					if(id.contentEquals("admin1")) {
						request.getSession().setAttribute("AdminId", id);
						String admin = (String)request.getSession().getAttribute("AdminId");
						System.out.println(admin);
					}else {
						request.getSession().setAttribute("loginInfo", id);
						String info = (String)request.getSession().getAttribute("loginInfo");
						MembersDTO dto = dao.selectById(info);
						String name = dto.getName();
						request.getSession().setAttribute("name", name);
						
						System.out.println(name);
					}
					response.getWriter().append("{\"result\" : \""+ result +"\"}");
	
				}else {
					response.getWriter().append("{\"result\" : \""+ result +"\"}");
				}
			}else if(cmd.contentEquals("/logout.log")) {
				request.getSession().invalidate();
				response.sendRedirect("/JoMalone/home.jsp");
				
			}

		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}