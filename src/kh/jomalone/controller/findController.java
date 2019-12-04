package kh.jomalone.controller;

import java.io.IOException;
import java.math.BigInteger;
import java.security.SecureRandom;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.jomalone.DAO.MembersDAO;
import kh.jomalone.Util.SendMail;
import kh.jomalone.Util.encrypt;

@WebServlet("*.find")
public class findController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI().substring(request.getContextPath().length());
		System.out.println(cmd);
		MembersDAO dao = MembersDAO.getInstance();
		
		try {
		if(cmd.contentEquals("/Member/id.find")) {
				String name = request.getParameter("name");
				String phone = request.getParameter("phone");
				String id = dao.findid(name, phone);
				
				if(id != null) {
					String subid = id.substring(0,id.length()-2)+"**";
					System.out.println(subid);
					response.getWriter().append("{ \"id\" : \"" + subid + "\"}");	
				}else if(id == null){
					System.out.println("nu");
					response.getWriter().append("{\"nullid\" : \"nullid\"}");
				}
				
				
			}else if(cmd.contentEquals("/Member/pw.find")) {
	    		
	    		String toEmail = request.getParameter("email");
	    		String id = request.getParameter("id");
	    		
	    		boolean result = dao.isEmailExist(toEmail,id);
	    		System.out.println(result);
	    		
	    		if(result) {
	    			SecureRandom random = new SecureRandom();
	    			String randomPw = new BigInteger(36, random).toString();
	    			
	    			String encryptrandPw = encrypt.encrypt(randomPw);
	    			System.out.println("tempPw : " + encryptrandPw);
	    			System.out.println(id);
	    			
	    			int result1 = dao.changePw(encryptrandPw,id,toEmail);
	    			System.out.println("result1 : " + result1);
	    			System.out.println(toEmail);
	    			
	    			SendMail send = new SendMail();
	    			send.pwsendMail(toEmail, randomPw);
	    			request.setAttribute("result", result);
	    			request.getRequestDispatcher("findpw.jsp").forward(request, response);
	    			
	    		}else {
	    			request.setAttribute("result", result);
	    			request.getRequestDispatcher("findpw.jsp").forward(request, response);
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
