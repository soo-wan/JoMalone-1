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

import kh.jomalone.DAO.CartDAO;
import kh.jomalone.DTO.CartDTO;


@WebServlet("*.ca")
public class CartController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF8");
		String requestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String cmd = requestURI.substring(contextPath.length());
		CartDAO dao = CartDAO.getInstance();
		try {
			if(cmd.contentEquals("/insert.ca")) {
				int seq = Integer.parseInt(request.getParameter("seq"));
				String prod_name = request.getParameter("prod_name");
				int price = Integer.parseInt(request.getParameter("price"));
				int prod_quantity = Integer.parseInt(request.getParameter("prod_quantity"));
				String mem_id = (String)request.getSession().getAttribute("loginInfo");
				String mem_name = (String)request.getSession().getAttribute("name"); 
				List<CartDTO> list = new ArrayList<>();
				CartDTO dto = new CartDTO(mem_id,seq,mem_name,prod_name,prod_quantity,price);				
				boolean result = dao.checkProdExist(mem_id, prod_name);
				if(result) {
					dao.sumProdQuantity(prod_quantity, mem_id, prod_name);
				}
				else {
					dao.insertCart(dto);
				}
				list.add(dto);
				response.sendRedirect("list.ca");
			}
			else if(cmd.contentEquals("/list.ca")) {
				String mem_id = (String)request.getSession().getAttribute("loginInfo");
				List<CartDTO> list = dao.selectCart(mem_id); 
				//int seq = dao.checkboxSeq(seq);
				request.setAttribute("list",list);
				request.getRequestDispatcher("Product/cart.jsp").forward(request, response);
			}
			else if(cmd.contentEquals("/delete.ca")) {
				//PrintWriter pwr = response.getWriter();
				String seqString = request.getParameter("seq");
				seqString = seqString.substring(5);
				int seq = Integer.parseInt(seqString);
				List<Integer> list = new ArrayList<>();
				list.add(seq);
				for(int i : list) {
					dao.deleteCart(i);
				}
				response.sendRedirect("list.ca");
			}
			else if(cmd.contentEquals("/deletes.ca")) {
				String[] seqs = request.getParameterValues("seq");
				seqs[0]=seqs[0].replaceAll("\"", "");
				String regex = "(\\d+)";
				Pattern p = Pattern.compile(regex);
				Matcher m = p.matcher(seqs[0]);
				int seq=0;
//				seqs[0]=seqs[0].replaceAll("[", ""); 안됨
//				seqs[0]=seqs[0].replaceAll("]", ""); 안됨				
//				for (int i = 0; i < seqs.length; i++) {
//					seq = Integer.parseInt(seqs[i]);
//					//dao.deleteCart(seq);
//				}
				while(m.find()) {
					seq = Integer.parseInt(m.group());
					dao.deleteCart(seq);
				}
				response.sendRedirect("list.ca");
			}
			else if(cmd.contentEquals("/update.ca")) {
				int prod_quantity = Integer.parseInt(request.getParameter("prod_quantity"));
				int seq = Integer.parseInt(request.getParameter("seq"));
				dao.updateProdQuantity(prod_quantity, seq);
				response.sendRedirect("list.ca");
			}
			else if(cmd.contentEquals("/deleteAll.ca")) {
				String mem_id = (String)request.getSession().getAttribute("loginInfo");
				dao.deleteAllCart(mem_id);
				response.sendRedirect("list.ca");
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
