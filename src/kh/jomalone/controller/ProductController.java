package kh.jomalone.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.jomalone.DAO.ProductViewDAO;
import kh.jomalone.DTO.ProductDTO;


@WebServlet("*.prod")
public class ProductController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String requestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String cmd = requestURI.substring(contextPath.length());
		System.out.println(cmd);
		ProductViewDAO pdao = ProductViewDAO.getInstance();
		try {
			if (cmd.contentEquals("/prod.prod")) {
				System.out.println("prod 도착!");
				String prod_category = request.getParameter("prod_Category");
				String url = request.getParameter("url");
				List<ProductDTO> list = new ArrayList<>();
				System.out.println(prod_category);
				System.out.println(url);
				if(prod_category.contentEquals("LightFloral")) {
					prod_category = "Light Floral";
				}
				System.out.println(prod_category);
				System.out.println(url);
				list = pdao.selectProductByProdCategory(prod_category);
				request.setAttribute("list",list);
				request.getRequestDispatcher("Goods/"+url).forward(request, response);
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
