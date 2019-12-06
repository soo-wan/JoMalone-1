package kh.jomalone.snslogin;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import kh.jomalone.DAO.MembersDAO;

@WebServlet("*.klog")
public class kakaologout extends HttpServlet {
   
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
      try {
      String reqURL = "https://kapi.kakao.com/v1/user/unlink";
      String access_token = (String)request.getSession().getAttribute("access_token");
      String loginInfo = (String)request.getSession().getAttribute("loginInfo");
      MembersDAO dao = MembersDAO.getInstance();
           URL url = new URL(reqURL);
           HttpURLConnection conn = (HttpURLConnection) url.openConnection();
           conn.setRequestMethod("POST");
           conn.setRequestProperty("Authorization", "Bearer " + access_token);
           
           int responseCode = conn.getResponseCode();
           System.out.println("responseCode : " + responseCode);
           
           BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
           
           String result = "";
           String line = "";
           
           while ((line = br.readLine()) != null) {
               result += line;
           }
           System.out.println(result);
           request.setAttribute("result", result);
           dao.delete(loginInfo);
           request.getSession().invalidate();
           request.getRequestDispatcher("kakaodelresult.jsp").forward(request, response);
       } catch (Exception e) {
           e.printStackTrace();
       }
      
   }


   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

      doGet(request, response);
   }

}