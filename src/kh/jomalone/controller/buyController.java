package kh.jomalone.controller;

import static org.junit.Assert.assertNull;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import kh.jomalone.DAO.BuyDAO;
import kh.jomalone.DAO.CartDAO;
import kh.jomalone.DAO.MembersDAO;
import kh.jomalone.DTO.BuyDTO;
import kh.jomalone.DTO.OrderListDTO;
import kh.jomalone.Util.Util;
import kh.jomalone.configuration.ConfigurationBuylist;

@WebServlet("*.buy")
public class buyController extends HttpServlet {

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
		BuyDAO bdao = BuyDAO.getInstance();
		MembersDAO mdao = MembersDAO.getInstance();
		CartDAO cdao = CartDAO.getInstance();
		try {
			if(cmd.contentEquals("/callMerchantuid.buy")){
				int nextSeq = bdao.selectMaxBuySeq()+1;
				String merchant_uid = "ORD"+String.format("%05d", nextSeq);
				String mem_id = (String)request.getSession().getAttribute("loginInfo");
				String mem_name = request.getParameter("name");
				String pg = "inicis";
				String pay_method = "card";
				String buy_name = request.getParameter("buy_name");
				String pricetemp =  request.getParameter("totalPirce");
				System.out.println(pricetemp);
				int totalprice = Integer.parseInt(pricetemp.replace(",", ""));
				System.out.println(totalprice);
				String mem_phone = request.getParameter("phone");
				String full_address = request.getParameter("address");
				String zip_code = request.getParameter("zip_code");
				String mem_email = request.getParameter("email");
				String name_buf = request.getParameter("buy_name");
				String price_buf = request.getParameter("prices");
				String quantitys_buf = request.getParameter("prod_quantitys");
				String[] prod_names = name_buf.split(",");
				String[] prices = price_buf.split(",");
				String[] prod_quantitys = quantitys_buf.split(",");
				
				List<OrderListDTO> list = new ArrayList<>();
				for (int i = 0; i < prod_names.length; i++) {
					int price = Integer.parseInt(prices[i]);
					int prod_quantity = Integer.parseInt(prod_quantitys[i]);
					list.add(new OrderListDTO(0,null,merchant_uid,prod_names[i],pay_method,mem_id,mem_name,null,prod_quantity,price,full_address,zip_code,null,null,null,"N",null));
				}
				bdao.insertOrderList(list);
				bdao.insertBuyProduct(new BuyDTO(0,null,pg,pay_method,merchant_uid,buy_name,totalprice,mem_id,mem_name,mem_phone,mem_email,full_address,zip_code,"N"));
				Gson gson = new Gson();
				JsonObject object = new JsonObject();
				object.addProperty("pg", pg);
				object.addProperty("pay_method", pay_method);
				object.addProperty("merchant_uid", merchant_uid);
				object.addProperty("name", buy_name);
				object.addProperty("amount", totalprice);
				object.addProperty("buyer_email", mem_email);
				object.addProperty("buyer_name", mem_name);
				object.addProperty("buyer_tel", mem_phone);
				object.addProperty("buyer_addr", full_address);
				object.addProperty("buyer_postcode", zip_code );
				
				String Json = gson.toJson(object);
				System.out.println(Json + "과같이 정보담기 완료");
				response.getWriter().append(Json);
			}else if(cmd.contentEquals("/buyComplet.buy")) {
				System.out.println("결제성공하고 controller 이동!");
				String merchant_uid = request.getParameter("merchant_uid");
				System.out.println(merchant_uid + "코드번호 ");
				String imp_uid = request.getParameter("imp_uid");
				System.out.println("imp_uid :" + imp_uid);
				bdao.updateBuyComplete(merchant_uid, imp_uid);
				System.out.println("Y로 변경완료!");
				response.getWriter().append("{}");
				
			}else if(cmd.contentEquals("/buyFailed.buy")) {
				System.out.println("결제 실패 controller 이동!" );
				String merchant_uid = request.getParameter("merchant_uid");
				bdao.deleteOrderByMerchantuid(merchant_uid);
				System.out.println("삭제완료!");
				response.getWriter().append("{}");
			}else if(cmd.contentEquals("/buylist.buy")) {
				String periodstr = Util.NullCheck(request.getParameter("period"));
				if(periodstr.contentEquals("")) {
					periodstr = "9999";
				}
				int period = Integer.parseInt(periodstr);
				System.out.println(period);
				String id = (String)request.getSession().getAttribute("loginInfo");
				int cpage = 1;
				String page = request.getParameter("cpage");
				if(page != null) {
					cpage = Integer.parseInt(page);
				}
				String pageNavi = bdao.getPageNavi(cpage,id);		
				
				int start = cpage * ConfigurationBuylist.recordCountPerPage - (ConfigurationBuylist.recordCountPerPage-1);
				int end = cpage * ConfigurationBuylist.recordCountPerPage;
				
				List<OrderListDTO> list = bdao.selectByPage(id,start, end,period);
				List<OrderListDTO> list2 = bdao.selectRefundList(id);
				SimpleDateFormat sdf = new SimpleDateFormat ("yyyy-MM-dd"); 
				for (OrderListDTO dto : list) {
					dto.setDate(sdf.format(dto.getOrder_date()));;
					cdao.deleteOrderByProdName(dto.getProd_name());
				}
				for (OrderListDTO dto : list2) {
					dto.setDate(sdf.format(dto.getOrder_date()));;
					cdao.deleteOrderByProdName(dto.getProd_name());
				}
				request.setAttribute("list2", list2);
				request.setAttribute("list",list);
				request.setAttribute("pageNavi",pageNavi);
				request.getRequestDispatcher("Product/buylist.jsp").forward(request, response);	
				
			}
			else if(cmd.contentEquals("/search.buy")){
//				int period = Integer.parseInt(request.getParameter("period"));
//				request.setAttribute("period", period);
				request.getRequestDispatcher("buylist.buy").forward(request, response);	
			}else if (cmd.contentEquals("/refund.buy")) {
				System.out.println("refund arrive");
				IamportClient client = new IamportClient("6408595318184888","tYA4Z7OCAOvaK2xSUHGkwAaqkwN55UVzTwESEsvfg0p12WTXDzha9sAtYnz4ivEc1i5FLAU1Bk3DgWBU");
				String merchant_uid = request.getParameter("merchant_uid");
				CancelData cancel_data = new CancelData(merchant_uid, false);
				cancel_data.setEscrowConfirmed(true);
				try {
					IamportResponse<Payment> payment_response = client.cancelPaymentByImpUid(cancel_data);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}else if(cmd.contentEquals("/partrefund.buy")){
				System.out.println("partrefund arrive");
				String prod_name = request.getParameter("prod_name");
				String imp_uid = request.getParameter("imp_uid");
				int price = Integer.parseInt(request.getParameter("price"));
				int prod_quantity = Integer.parseInt(request.getParameter("prod_quantity"));
				System.out.println(prod_quantity + " : " + price + " : " + imp_uid + " : " + prod_name);
				bdao.updateRefund(imp_uid,prod_name);
				IamportClient client = new IamportClient("6408595318184888","tYA4Z7OCAOvaK2xSUHGkwAaqkwN55UVzTwESEsvfg0p12WTXDzha9sAtYnz4ivEc1i5FLAU1Bk3DgWBU");
				CancelData cancel_data = new CancelData(imp_uid, true, BigDecimal.valueOf(price*prod_quantity)); //imp_uid를 통한 부분취소
				try {
					IamportResponse<Payment> payment_response = client.cancelPaymentByImpUid(cancel_data);
				}  catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				request.getRequestDispatcher("buylist.buy").forward(request, response);	
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
