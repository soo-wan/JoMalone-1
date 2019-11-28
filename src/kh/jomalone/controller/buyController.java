package kh.jomalone.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import kh.jomalone.DAO.BuyDAO;
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
			if(cmd.contentEquals("/buyComplet.buy")) {
				BuyDAO dao = BuyDAO.getInstance();
				String pg = "inicis";											//결제사 받아와야함
				String pay_method = request.getParameter("pay_method");
				String merchant_uid = request.getParameter("merchant_uid");
				String prod_name = request.getParameter("name");						// 처음것외 몇개로  
				int totalprice = Integer.parseInt("totalPrice");						//가격 받아와야함.
				String mem_id = (String)request.getSession().getAttribute("loginInfo"); // 세션에서 로그인 정보 받아옴
				String mem_name = request.getParameter("buyer_name");
				String mem_phone = request.getParameter("buyer_tel");
				String mem_email = request.getParameter("buyer_email");
				String full_address = request.getParameter("buyer_addr");
				String zip_code = request.getParameter("buyer_postcode");
				String[] prod_names = request.getParameterValues("");			//전체 이름 목록 한클래스이름으로 받아와야함
				String[] prices = request.getParameterValues("");				//전체 가격 목록 한클래스로 받아와야함
				String[] prod_quantitys = request.getParameterValues("");		//전체 수량 목록 한클래스로 받아와야함.
				String[] prod_codes = request.getParameterValues("");			//전체 품목 코드 받아와야함
				
				List<OrderListDTO> list = new ArrayList<>();
				for (int i = 0; i < prod_names.length; i++) {
					int price = Integer.parseInt(prices[i]);
					int prod_quantity = Integer.parseInt(prod_quantitys[i]);
					list.add(new OrderListDTO(0,null,merchant_uid,prod_codes[i],prod_names[i],pay_method,mem_id,mem_name,null,prod_quantity,price,full_address,zip_code,null,null));
				}
				dao.insertOrderList(list);
				dao.insertBuyProduct(new BuyDTO(0,null,pg,pay_method,merchant_uid,prod_name,totalprice,mem_id,mem_name,mem_phone,mem_email,full_address,zip_code));
				
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
