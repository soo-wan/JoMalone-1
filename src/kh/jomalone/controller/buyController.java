package kh.jomalone.controller;

import java.io.IOException;
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
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import kh.jomalone.DAO.BuyDAO;
import kh.jomalone.DAO.MembersDAO;
import kh.jomalone.DTO.BuyDTO;
import kh.jomalone.DTO.OrderListDTO;

@WebServlet("*.buy")
public class buyController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		System.out.println("requestURI : " + requestURI);
		String ctxPath = request.getContextPath();
		System.out.println("ContextPath : " + ctxPath); 
		String cmd = requestURI.substring(ctxPath.length());
		System.out.println(cmd);
		
		request.setCharacterEncoding("utf8");
		try {
			if(cmd.contentEquals("/callMerchantuid.buy")){
				BuyDAO bdao = BuyDAO.getInstance();
				MembersDAO mdao = MembersDAO.getInstance();
				int nextSeq = bdao.selectMaxBuySeq()+1;
				String merchant_uid = "ORD"+String.format("%05d", nextSeq);
				String mem_id = "test111"; //(String)request.getSession().getAttribute("loginInfo");
				String mem_name = request.getParameter("name");
				String pg = "inicis";
				String pay_method = "card";
				String buy_name = request.getParameter("buy_name");					
				int totalprice = Integer.parseInt(request.getParameter("totalPirce"));
				String mem_phone = request.getParameter("phone");
				String full_address = request.getParameter("address");
				String zip_code = request.getParameter("zip_code");
				String mem_email = request.getParameter("email");
				String name_buf = request.getParameter("buy_name");
				String price_buf = request.getParameter("prices");
				String quantitys_buf = request.getParameter("prod_quantitys");
				System.out.println(buy_name);
				System.out.println(mem_phone);
				System.out.println(mem_email + "와같이 정보 받아오기 완료 ");
				String[] prod_names = name_buf.split(",");
				String[] prices = price_buf.split(",");
				String[] prod_quantitys = quantitys_buf.split(",");
				
				System.out.println("버퍼에 값 담기 완료" );
				
				List<OrderListDTO> list = new ArrayList<>();
				for (int i = 0; i < prod_names.length; i++) {
					int price = Integer.parseInt(prices[i]);
					int prod_quantity = Integer.parseInt(prod_quantitys[i]);
					list.add(new OrderListDTO(0,null,merchant_uid,prod_names[i],pay_method,mem_id,mem_name,null,prod_quantity,price,full_address,zip_code,null,null,null,"N"));
				}
				bdao.insertOrderList(list);
				bdao.insertBuyProduct(new BuyDTO(0,null,pg,pay_method,merchant_uid,buy_name,totalprice,mem_id,mem_name,mem_phone,mem_email,full_address,zip_code,"N"));
				System.out.println("DB에 정보담기 완료");
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
			}else if(cmd.contentEquals("/Product/buyComplet.buy")) {
				BuyDAO bdao = BuyDAO.getInstance();
				MembersDAO mdao = MembersDAO.getInstance();
				System.out.println("결제성공하고 controller 이동!");
				String merchant_uid = request.getParameter("merchant_uid");
				System.out.println(merchant_uid + "코드번호 ");
				bdao.updateBuyComplete(merchant_uid);
				
				System.out.println("Y로 변경완료!");
				
				
				
			}else if (cmd.contentEquals("/refund.buy")) {
				System.out.println("refund arrive");
				
				IamportClient client = new IamportClient("6408595318184888","tYA4Z7OCAOvaK2xSUHGkwAaqkwN55UVzTwESEsvfg0p12WTXDzha9sAtYnz4ivEc1i5FLAU1Bk3DgWBU");
				String test_already_cancelled_merchant_uid = "ORD0007";			// 환불할 ID
				CancelData cancel_data = new CancelData(test_already_cancelled_merchant_uid, false);
				cancel_data.setEscrowConfirmed(true);
				
				try {
					IamportResponse<Payment> payment_response = client.cancelPaymentByImpUid(cancel_data);
					System.out.println("�Ϸ�!");
				} catch (IamportResponseException e) {
					System.out.println(e.getMessage());
//					switch(e.getHttpStatusCode()) {
//					case 401 :
//						break;
//					case 500 :
//						break;
//					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
