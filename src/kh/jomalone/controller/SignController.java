package kh.jomalone.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.jomalone.DAO.MembersDAO;
import kh.jomalone.DTO.MembersDTO;

@WebServlet("*.sign")
public class SignController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI().substring(request.getContextPath().length());
		System.out.println(cmd);
		request.setCharacterEncoding("UTF8");
		try {
			if(cmd.contentEquals("/dupl.sign")) {
				System.out.println(request.getParameter("id"));
				MembersDAO dao = MembersDAO.getInstance();
				String id = request.getParameter("id");

				boolean result = dao.isIdExist(id);
				System.out.println(result);
				response.getWriter().append("{\"result\" : \""+ result +"\"}");
				
			}else if(cmd.contentEquals("/signup.sign")) {
				String id = request.getParameter("id");
				String name  = request.getParameter("name");
				String pw = request.getParameter("pw");
				String phone1 = request.getParameter("phone1");
				String phone2 = request.getParameter("phone2");
				String phone3 = request.getParameter("phone3");
				String email1 = request.getParameter("email1");
				String email2 = request.getParameter("email2");
				if(email2.contentEquals("input")) {
					email2 = request.getParameter("writeemail");
					email2 = "@"+email2;
				}
				System.out.println(email2);
				String zip_code = request.getParameter("zipcode");
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
				MembersDTO dto = new MembersDTO(id,"normal",null,pw,name,phone1,phone2,phone3,email1,email2,
						zip_code,address1,address2,year,month,day,gender,null,null,null,agree_s,agree_p);
				
				MembersDAO dao = MembersDAO.getInstance();
				int result = dao.signup(dto);
	
			}

		}catch(Exception e) {
			e.printStackTrace();
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}