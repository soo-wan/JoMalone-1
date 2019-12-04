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
			//로그인
			if(cmd.contentEquals("/Member/login.log")) {
				String id = request.getParameter("id");
				String pw = encrypt.encrypt(request.getParameter("pw"));
				System.out.println(id);
				System.out.println(pw);
				
				boolean result = dao.login(id, pw);
				System.out.println(result);
				
				//아이디,패스워드 맞으면 로그인.하고 ajax
				if(result) {
					if(id.contentEquals("admin1")) {
						request.getSession().setAttribute("adminId", id);
						String adminid = (String)request.getSession().getAttribute("adminId");
						MembersDTO dto = dao.selectById(adminid);
						dao.lastlogin(id);
						String name = dto.getName();
						request.getSession().setAttribute("name", name);
					}
					else{
						request.getSession().setAttribute("loginInfo", id);
						String info = (String)request.getSession().getAttribute("loginInfo");
						MembersDTO dto = dao.selectById(info);
						dao.lastlogin(id);
						String name = dto.getName();
						request.getSession().setAttribute("name", name);
					}
						
						response.getWriter().append("{\"result\" : \""+result+ "\"  , \"id\" : \""+ id +"\"}");
	
				}else { // 로그인안되면 ajax
					response.getWriter().append("{\"result\" : \""+ result +"\"}");
				}
			}else if(cmd.contentEquals("/logout.log")) {
				request.getSession().invalidate();
				response.sendRedirect("home.jsp");
				
			}

		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}