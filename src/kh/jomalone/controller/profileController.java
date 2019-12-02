package kh.jomalone.controller;

import java.io.IOException;

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
		
		try {
		if(cmd.contentEquals("/Member/profile.my")) {
			String id =(String)request.getSession().getAttribute("loginInfo");
			MembersDTO dto =dao.selectById(id);
			request.setAttribute("dto",dto);
			
			String[] phonearr = dto.phonesplit(dto.getPhone());
			request.setAttribute("phone1", phonearr[0]);
			request.setAttribute("phone2", phonearr[1]);
			request.setAttribute("phone3", phonearr[2]);
			String[] emailarr = dto.emailsplit(dto.getEmail());
			request.setAttribute("email1", emailarr[0]);
			request.setAttribute("email2", emailarr[1]);
			String[] birtharr = dto.birthsplit(dto.getBirth());
			request.setAttribute("year", birtharr[0]);
			request.setAttribute("month", birtharr[1]);
			request.setAttribute("day", birtharr[2]);
			
			request.getRequestDispatcher("profile22.jsp").forward(request, response);
			}else if(cmd.contentEquals("/Member/modi.my")) {
				
				String id = (String)request.getSession().getAttribute("loginInfo");
				String pw = request.getParameter("pw");
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
				MembersDTO dto = new MembersDTO(id,pw,phone1,phone2,phone3,email1,email2,zip_code,address1,address2,year,month,day,gender);
				System.out.println(dto.phone());
				System.out.println(id);
				System.out.println(dto.birth());
				System.out.println(dto.email());
				System.out.println(dto.getPw());
				System.out.println(gender);
				
				int result = dao.modifyInfo(dto);
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
