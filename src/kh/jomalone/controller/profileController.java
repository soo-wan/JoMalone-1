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


@WebServlet("*.my")
public class profileController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI().substring(request.getContextPath().length());
		System.out.println(cmd);
		request.setCharacterEncoding("UTF8");
		MembersDAO dao = MembersDAO.getInstance();
		
		try {
		if(cmd.contentEquals("/Member/profile.my")) {
			String id =(String)request.getSession().getAttribute("loginInfo");
			MembersDTO dto =dao.selectById(id);
			System.out.println(id);
			System.out.println(dto.getLogintype());
			request.setAttribute("dto",dto);
			request.getRequestDispatcher("profile22.jsp").forward(request, response);
			
		}else if(cmd.contentEquals("/Member/modi.my")) {
				
				String id = (String)request.getSession().getAttribute("loginInfo");
				MembersDTO dto = dao.selectById(id);
					String pw = encrypt.encrypt(request.getParameter("pw"));
					String phone1 = request.getParameter("phone1");
					String phone2 = request.getParameter("phone2");
					String phone3 = request.getParameter("phone3");
					String email1 = request.getParameter("email1");
					String email2 = request.getParameter("email2");
					String zip_code = request.getParameter("zip_code");
					String address1 = request.getParameter("address1");
					String address2= request.getParameter("address2");
					String year = request.getParameter("year");
					String month = request.getParameter("month");
					String day = request.getParameter("day");
					String gender = request.getParameter("gender");
					MembersDTO info = new MembersDTO(id,pw,phone1,phone2,phone3,email1,email2,zip_code,address1,address2,year,month,day,gender);
					int result = dao.modifyInfo(info);
					
				
				System.out.println(result);
				request.setAttribute("result", result);
				if(result > 0) {
					request.getRequestDispatcher("profileresult.jsp").forward(request, response);
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
