package kh.jomalone.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.jomalone.DAO.MembersDAO;
import kh.jomalone.DTO.MembersDTO;
import kh.jomalone.Util.encrypt;

@WebServlet("*.sign")
public class SignController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI().substring(request.getContextPath().length());
		System.out.println(cmd);
		request.setCharacterEncoding("UTF8");
		MembersDAO dao = MembersDAO.getInstance();
		try {
			if(cmd.contentEquals("/Member/dupl.sign")) {
				System.out.println(request.getParameter("id"));
				String id = request.getParameter("id");

				boolean result = dao.isIdExist(id);
				System.out.println(result);
				response.getWriter().append("{\"result\" : \""+ result +"\"}");
				
			}else if(cmd.contentEquals("/Member/signup.sign")) {
				String id = request.getParameter("id");
				String name  = request.getParameter("name");
				String pw = encrypt.encrypt(request.getParameter("pw"));
				String phone1 = request.getParameter("phone1");
				String phone2 = request.getParameter("phone2");
				String phone3 = request.getParameter("phone3");
				String email1 = request.getParameter("email1");
				String email2 = request.getParameter("email2");
				if(email2.contentEquals("input")) {
					email2 = request.getParameter("writeemail");
				}
				System.out.println(email2);
				String zip_code = request.getParameter("zip_code");
				String address1 = request.getParameter("address1");
				String address2 = request.getParameter("address2");
				String year = request.getParameter("year");
				String month = request.getParameter("month");
				String day = request.getParameter("day");
				String gender = request.getParameter("gender");
				String agree_s = request.getParameter("agree_service_check");
				String agree_p = request.getParameter("agree_privacy_check");
				
				System.out.println(year);
				System.out.println(month);
				System.out.println(gender);
				System.out.println(agree_s);
				System.out.println(agree_p);
				MembersDTO dto = new MembersDTO(id,"normal",pw,name,phone1,phone2,phone3,email1,email2,
						zip_code,address1,address2,year,month,day,gender,null,null,null,agree_s,agree_p);
				int result = dao.signup(dto);
				request.setAttribute("result", result);
				request.getRequestDispatcher("/Member/login.jsp").forward(request, response);
				
			}else if(cmd.contentEquals("/Member/check.sign")) {
				String pw = encrypt.encrypt(request.getParameter("pw"));
				System.out.println(pw);
				
				String loginInfo = (String)request.getSession().getAttribute("loginInfo");
				MembersDTO dto = dao.selectById(loginInfo);
				String id = dto.getId();
				String checkpw = dao.checkpw(id);
				System.out.println("checkpw : " + checkpw);
				System.out.println(id);
				System.out.println(loginInfo);
				
				if(pw.contentEquals(checkpw)) {
					int result = dao.delete(id);
					dao.updatedel_yn(id);
					request.getSession().invalidate();
					request.setAttribute("result", result);
					request.getRequestDispatcher("delresult.jsp").forward(request, response);
				}else {
					request.getRequestDispatcher("delresult.jsp").forward(request, response);
				}
			
			}else if(cmd.contentEquals("/Member/del.sign")) {
				String id = (String)request.getSession().getAttribute("loginInfo");
				int result = dao.delete(id);
				dao.updatedel_yn(id);
				request.getSession().invalidate();
				request.setAttribute("result", result);
				request.getRequestDispatcher("delresult.jsp").forward(request, response);
			}
				
		}catch(Exception e) {
			e.printStackTrace();
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}