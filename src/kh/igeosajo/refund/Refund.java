package kh.igeosajo.refund;

import java.io.IOException;

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

@WebServlet("*.refund")
public class Refund extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("refund arrive");
		
		IamportClient client = new IamportClient("6408595318184888","tYA4Z7OCAOvaK2xSUHGkwAaqkwN55UVzTwESEsvfg0p12WTXDzha9sAtYnz4ivEc1i5FLAU1Bk3DgWBU");
		String test_already_cancelled_merchant_uid = "ORD0007";
		CancelData cancel_data = new CancelData(test_already_cancelled_merchant_uid, false);
		cancel_data.setEscrowConfirmed(true);
		
		try {
			IamportResponse<Payment> payment_response = client.cancelPaymentByImpUid(cancel_data);
			System.out.println("¿Ï·á!");
		} catch (IamportResponseException e) {
			System.out.println(e.getMessage());
//			switch(e.getHttpStatusCode()) {
//			case 401 :
//				break;
//			case 500 :
//				break;
//			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
