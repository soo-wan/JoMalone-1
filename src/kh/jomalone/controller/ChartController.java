package kh.jomalone.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.jomalone.DAO.BuyDAO;
import kh.jomalone.DTO.RankDTO;
import kh.jomalone.Util.Util;

@WebServlet("*.chart")
public class ChartController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		System.out.println("requestURI : " + requestURI);
		String ctxPath = request.getContextPath();
		System.out.println("ContextPath : " + ctxPath); 
		String cmd = requestURI.substring(ctxPath.length());
		System.out.println(cmd);
		request.setCharacterEncoding("UTF8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		try {
			if(cmd.contentEquals("/rank.chart")){
				List<RankDTO> list = new ArrayList<>();
				BuyDAO bdao = BuyDAO.getInstance();
				list = bdao.selectBuyRank();
				int[] buy_counts = new int[5];
				String[] prod_names = {"","","","",""};
				int count =0;
				for (RankDTO dto : list) {
					System.out.println(dto.getProd_name());
					buy_counts[count] = dto.getBuy_count();
					prod_names[count] = Util.NullCheck(dto.getProd_name());
					count++;
					if(count==5) {
						break;
					}
				}
				String countString = "["+buy_counts[0]+","+buy_counts[1]+","+buy_counts[2]+","+buy_counts[3]+","+buy_counts[4]+"]";
				String nameString = "['"+prod_names[0]+"','"+prod_names[1]+"','"+prod_names[2]+"','"+prod_names[3]+"','"+prod_names[4]+"']";
				System.out.println(countString);
				System.out.println(nameString);
				request.setAttribute("countString", countString);
				request.setAttribute("nameString", nameString);
				request.getRequestDispatcher("admin/adminStatistics.jsp").forward(request, response);;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
