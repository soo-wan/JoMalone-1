package kh.jomalone.snslogin;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kh.jomalone.DAO.MembersDAO;
import kh.jomalone.DTO.NMembersDTO;

@WebServlet("/Ncallback")
public class Ncallback extends HttpServlet {
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  String clientId = "VsJ9BGH2srkgM7uumvNE";//���ø����̼� Ŭ���̾�Ʈ ���̵�";
		    String clientSecret = "4Yn9S9ceBY";//���ø����̼� Ŭ���̾�Ʈ ��ũ����";
		    String code = request.getParameter("code");
		    String state = request.getParameter("state");
		    String redirectURI = URLEncoder.encode("http://localhost:8080/JoMalone/Ncallback", "UTF-8");
		    String apiURL;
		    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
		    apiURL += "client_id=" + clientId;
		    apiURL += "&client_secret=" + clientSecret;
		    apiURL += "&redirect_uri=" + redirectURI;
		    apiURL += "&code=" + code;
		    apiURL += "&state=" + state;
		    String access_token = "";
		    String refresh_token = "";
		    System.out.println("apiURL="+apiURL);
		   
		    try {
		      URL url = new URL(apiURL);
		      HttpURLConnection con = (HttpURLConnection)url.openConnection();
		      con.setRequestMethod("GET");
		      int responseCode = con.getResponseCode();
		      BufferedReader br;
		      System.out.print("responseCode="+responseCode);
		      if(responseCode==200) { // ���� ȣ��
		        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
		      } else {  // ���� �߻�
		        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
		      }
		      String inputLine;
		      StringBuffer res = new StringBuffer();
		      while ((inputLine = br.readLine()) != null) {
		        res.append(inputLine);
		      }
		      br.close();
		      
		      if(responseCode==200) {
		        System.out.println(res.toString());

				JsonParser parser = new JsonParser();
				JsonElement el = parser.parse(res.toString());
				JsonObject obj = el.getAsJsonObject();
				
				access_token = obj.get("access_token").toString();
				refresh_token = obj.get("refresh_token").toString();
		      }
		      System.out.println("access_token : " + access_token);
		    
		    } catch (Exception e) {
		      System.out.println(e);
		    }
		 //ȸ����������ȸ API���밡�̵� ����
		    if(access_token != null) { //access_token�� �� �޾ƿԴٸ�..
		    	try {
		    		String apiurl = "https://openapi.naver.com/v1/nid/me"; 
		    		String header = "Bearer " + access_token; //Bearer ������ ���� �߰�
		    		//��û ����� �����ϴ� ��ū Ÿ���� Bearer�Դϴ�.
		    		URL url = new URL(apiurl);
				      HttpURLConnection con = (HttpURLConnection)url.openConnection();
				      con.setRequestMethod("GET");
				      //��û�� ���� ������ ���� �������� ���� ��ū�� �����ϴ� ��û ����� �����ϴ�. 
				      con.setRequestProperty("Authorization", header);
				      int responseCode = con.getResponseCode();
				      BufferedReader br;
				      System.out.print("responseCode="+responseCode);
				      if(responseCode==200) { // ���� ȣ��
				        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
				      } else {  // ���� �߻�
				        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
				      }
				      String inputLine;
				      StringBuffer res = new StringBuffer();
				      while ((inputLine = br.readLine()) != null) {
				        res.append(inputLine);
				      }
				      br.close();
				      if(responseCode==200) {

							JsonParser parser = new JsonParser();
							JsonElement el = parser.parse(res.toString());
							JsonObject obj = el.getAsJsonObject();
							String resp = obj.get("response").toString();
							
							System.out.println(resp);
							
							JsonElement respel = parser.parse(resp);
							JsonObject respobj = respel.getAsJsonObject();
							String email = respobj.get("email").toString().replaceAll("\"", "");
							String id = respobj.get("id").toString().replaceAll("\"", "");
							String name= respobj.get("name").toString().replaceAll("\"", "");
							String birthday="";
							String gender="";
							if(respobj.get("birthday") != null) {
								birthday = "yyyy-"+respobj.get("birthday").toString().replaceAll("\"", "");
							}else {
								birthday = null;
							}
							if(respobj.get("gender") != null) {
								gender = respobj.get("gender").toString().replaceAll("\"", "");
								
							}else {
								birthday = null;
							}

							
							System.out.println(id+email+name+access_token);
							MembersDAO dao = MembersDAO.getInstance();
							
							boolean result = dao.Nlogin(id);
							System.out.println(result);
							
							
							if(result) { //이미 아이디가 있으면
								
								request.getSession().setAttribute("loginInfo", id);
								request.getSession().setAttribute("name", name);
								request.getRequestDispatcher("home.jsp").forward(request, response);
								
						
							}else { //아이디가 없으면 db에 저장.
								NMembersDTO ndto = new NMembersDTO(id,null,name,email,birthday,gender);
								dao.naverFirLogin(ndto);
								request.getSession().setAttribute("loginInfo", id);
								request.getSession().setAttribute("name", name);
								request.getRequestDispatcher("home.jsp").forward(request, response);

							}

					      }
		    	}catch(Exception e) {
		    		e.printStackTrace();
		    	}
		    }
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}