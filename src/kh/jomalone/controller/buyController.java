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
			if(cmd.contentEquals("/Product/callMerchantuid.buy")){
				BuyDAO bdao = BuyDAO.getInstance();
				MembersDAO mdao = MembersDAO.getInstance();
				String merchant_uid = "ORD"+String.format("%05d", bdao.selectMaxBuySeq()+1);
				String mem_id = (String)request.getSession().getAttribute("loginInfo");
				String mem_name = mdao.selectById(mem_id).getName();//
				
				response.getWriter().append("{\"merchant_uid\" : \""+ merchant_uid +"\","
						+ " \"name\" : \""+ mem_name+ "\"}");
			}else if(cmd.contentEquals("/buyComplet.buy")) {
				BuyDAO bdao = BuyDAO.getInstance();
				MembersDAO mdao = MembersDAO.getInstance();
				String pg = "inicis";//													//결제사 받아와야함
				String pay_method = "card";//
				String prod_name = request.getParameter("name");//						// 처음것외 몇개로  
				int totalprice = Integer.parseInt("totalPrice");//						//가격 받아와야함.
				String mem_id = (String)request.getSession().getAttribute("loginInfo"); // 세션에서 로그인 정보 받아옴
				
				
				String phone1 = request.getParameter("phone1");//
				String phone2 = request.getParameter("phone2");//
				String phone3 = request.getParameter("phone3");//
				String mem_phone = phone1 + phone2 + phone3;//
				
				String address1 = request.getParameter("address1");//
				String address2 = request.getParameter("address2");//
				String full_address = address1 + address2;//
				String zip_code = request.getParameter("zip_code");//
				String[] prod_names = request.getParameterValues("prod_names");//			//전체 이름 목록 한클래스이름으로 받아와야함
				String[] prices = request.getParameterValues("prices");//				//전체 가격 목록 한클래스로 받아와야함
				String[] prod_quantitys = request.getParameterValues("prod_quantitys");//		//전체 수량 목록 한클래스로 받아와야함.
				String[] prod_codes = request.getParameterValues("prod_codes");//			//전체 품목 코드 받아와야함
				
				String endEmail = request.getParameter("writeEmail");
				String merchant_uid = "ORD"+String.format("%05d", bdao.selectMaxBuySeq());//
				
				String mem_name = mdao.selectById(mem_id).getName();//
				String mem_email = request.getParameter("emailID")+endEmail;//
				List<OrderListDTO> list = new ArrayList<>();
				for (int i = 0; i < prod_names.length; i++) {
					int price = Integer.parseInt(prices[i]);
					int prod_quantity = Integer.parseInt(prod_quantitys[i]);
					list.add(new OrderListDTO(0,null,merchant_uid,prod_codes[i],prod_names[i],pay_method,mem_id,mem_name,null,prod_quantity,price,full_address,zip_code,null,null,null));
				}
				bdao.insertOrderList(list);
				bdao.insertBuyProduct(new BuyDTO(0,null,pg,pay_method,merchant_uid,prod_name,totalprice,mem_id,mem_name,mem_phone,mem_email,full_address,zip_code));
				
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
