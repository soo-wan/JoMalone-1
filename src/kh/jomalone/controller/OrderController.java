package kh.jomalone.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import kh.jomalone.DAO.CartDAO;
import kh.jomalone.DAO.MembersDAO;
import kh.jomalone.DTO.CartDTO;
import kh.jomalone.DTO.MembersDTO;

@WebServlet("*.or")
public class OrderController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String requestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String cmd = requestURI.substring(contextPath.length());
		CartDAO dao = CartDAO.getInstance();
		MembersDAO daoO = MembersDAO.getInstance(); 
		try {
			// 주문 선택 삭제
			if(cmd.contentEquals("/orderSelectDelete.or")) { 
				String[] seqs = request.getParameterValues("seq");
				seqs[0]=seqs[0].replaceAll("\"", "");
				String regex = "(\\d+)";
				Pattern p = Pattern.compile(regex);
				Matcher m = p.matcher(seqs[0]);
				int seq=0;
				while(m.find()) {
					seq = Integer.parseInt(m.group());
					dao.deleteCart(seq);
				}
				response.sendRedirect("list.ca");
			}
			
			// 전체 주문
			else if(cmd.contentEquals("/orderAll.or")) { 
				String mem_id = (String)request.getSession().getAttribute("loginInfo");
				List<CartDTO> list = dao.allOrder(mem_id); 
				request.setAttribute("list",list);
				request.getRequestDispatcher("Product/order.jsp").forward(request, response);				
			} 
			
			// 선택 주문
			else if(cmd.contentEquals("/orderSelect.or")) { 
				String[] seqs = request.getParameterValues("seq");
				for (int i = 0;  i < seqs.length; i++) {
					System.out.println(seqs[i]);
				}
				seqs[0]=seqs[0].replaceAll("\"", "");
				String regex = "(\\d+)"; 
				Pattern p = Pattern.compile(regex);
				Matcher m = p.matcher(seqs[0]);
				int seq=0;
				List<CartDTO> list = new ArrayList<>();
				while(m.find()) {
					seq = Integer.parseInt(m.group());
					//System.out.println(seq);
					CartDTO listSelect = dao.selectOrder(seq);
					list.add(listSelect);
				}
				for (CartDTO dto : list) {
					System.out.println(dto.getMem_id());
					System.out.println(dto.getProd_name());
					System.out.println(dto.getProd_quantity());
				}
				request.setAttribute("list",list);
				request.getRequestDispatcher("Product/order.jsp").forward(request, response);		
			}
			
			//회원정보 일치
			else if(cmd.contentEquals("/memberSame.or")) { 
				String mem_id = (String)request.getSession().getAttribute("loginInfo");
				Gson gson = new Gson();
				MembersDTO dto = daoO.selectById(mem_id);
				JsonObject object = new JsonObject();
				object.addProperty("name", dto.getName());
				object.addProperty("zip_code", dto.getName());
				object.addProperty("address1", dto.getAddress1());
				object.addProperty("address2", dto.getAddress2());
				object.addProperty("phone1", dto.getPhone1());
				object.addProperty("phone2", dto.getPhone2());
				object.addProperty("phone3", dto.getPhone3());
				request.setAttribute("dto", dto);
				String Json = gson.toJson(object);
				response.getWriter().append(Json);
			}
			else if(cmd.contentEquals("/orderUpdate.or")) {
					int prod_quantity = Integer.parseInt(request.getParameter("prod_quantity"));
					int seq = Integer.parseInt(request.getParameter("seq"));
					System.out.println(prod_quantity + " : " + seq);
					dao.updateProdQuantity(prod_quantity, seq);
					response.sendRedirect("Product/order.jsp");
				}
		}
		catch(Exception e){
			e.printStackTrace();
			response.sendRedirect("error.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
