package kh.jomalone.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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
				String[] seqString = request.getParameterValues("seq");
				String[] prod_name = request.getParameterValues("prod_name");
				String[] priceString = request.getParameterValues("price");
				String[] prod_quantityString = request.getParameterValues("prod_quantity");
				String mem_id = "test";
				int seq = 0;
				int price = 0;
				int prod_quantity = 0 ;
				List<CartDTO> list = new ArrayList<>();
				for (int i = 0; i < priceString.length; i++) {
					seq = Integer.parseInt(seqString[i]);
					price = Integer.parseInt(priceString[i]);
					prod_quantity = Integer.parseInt(prod_quantityString[i]);
					CartDTO dto = new CartDTO("test",seq,"테스트",prod_name[i],prod_quantity,price);				
					boolean result = dao.checkProdExist(mem_id, prod_name[i]);
					if(result) {
						dao.sumProdQuantity(prod_quantity, mem_id, prod_name[i]);
					}
					else {
						dao.insertCart(dto);
					}
					list.add(dto);
				}
				response.sendRedirect("list.ca");
			}
			else if(cmd.contentEquals("/list.ca")) {
				String mem_id = "test"; // mem_id 받는 부분
				List<CartDTO> list = dao.selectCart(mem_id); 
				request.setAttribute("list",list);
				request.getRequestDispatcher("Cart/list.jsp").forward(request, response);
			}
			else if(cmd.contentEquals("/delete.ca")) {
				int seq = Integer.parseInt(request.getParameter("seq"));
				dao.deleteCart(seq);
				response.sendRedirect("list.ca");
			}
			else if(cmd.contentEquals("/update.ca")) {
				int prod_quantity = Integer.parseInt(request.getParameter("prod_quantity"));
				int seq = Integer.parseInt(request.getParameter("seq"));
				dao.updateProdQuantity(prod_quantity, seq);
				response.sendRedirect("list.ca");
			}
			else if(cmd.contentEquals("/deleteAll.ca")) {
				dao.deleteAllCart();
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
