package kh.jomalone.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kh.jomalone.DAO.AdminDAO;
import kh.jomalone.DTO.DetailDTO;
import kh.jomalone.DTO.OrderManagementDTO;
import kh.jomalone.DTO.ProductDTO;
import kh.jomalone.Util.Util;


@WebServlet("*.admini")
public class adminController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String cpath = request.getContextPath();
		String cmd = uri.substring(cpath.length());
		request.setCharacterEncoding("utf8");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf8");
		AdminDAO dao = AdminDAO.getInstance();
		String rootPath = request.getContextPath();

		try {
			if(cmd.contentEquals("/insertProduct.admini")) {		
				String uploadPath = request.getServletContext().getRealPath("/Resource/img/");

				int maxSize = 1024 * 1024 * 10;
				MultipartRequest multi = new MultipartRequest(request,uploadPath,maxSize,"UTF8",new DefaultFileRenamePolicy()); 

				String productCode = multi.getParameter("productCode");
				String category = multi.getParameter("category");
				String productName = multi.getParameter("productName");
				int price = Integer.parseInt(multi.getParameter("price"));
				int quantity = Integer.parseInt(multi.getParameter("quantity"));
				String description = multi.getParameter("description");
				int spring = Integer.parseInt(multi.getParameter("spring"));
				int summer = Integer.parseInt(multi.getParameter("summer"));
				int fall = Integer.parseInt(multi.getParameter("fall"));
				int winter = Integer.parseInt(multi.getParameter("winter"));
				
				String fileName = Util.NullCheck(multi.getFilesystemName("img"));    //확장자포함한다.
				String newFileName = productCode + ".jpg";
				String saveDir = uploadPath;

				if(!fileName.equals("")) {
				     // 원본이 업로드된 절대경로와 파일명를 구한다.
				     String fullFileName = saveDir + "/" + fileName;
				     File f = new File(fullFileName);
				     if(f.exists()) {     // 업로드된 파일명이 존재하면 Rename한다.
				          File newFile = new File(saveDir + "/" + newFileName);
				          f.renameTo(newFile);   // rename...
				     }
				}
				
				dao.insertCategoryProdCode(category, productCode);
				dao.insertProduct(productCode, category, productName, price, quantity, description, spring, summer, fall, winter);
				dao.insertDetail(productCode, null, null);
				response.sendRedirect(rootPath+"/adminBack/insertProductResult.jsp");

			}else if(cmd.contentEquals("/productList.admini")) {
				List<ProductDTO> productList = dao.productList();
				
				for(ProductDTO tmp : productList) {
					System.out.println(tmp.getProductCode());
				}
				
				
				request.setAttribute("productList", productList);
				request.getRequestDispatcher("/adminBack/productList.jsp").forward(request, response);	

			}else if(cmd.contentEquals("/modifyProduct.admini")) {
				System.out.println("도착");

				String productCode = request.getParameter("productCode");
				
				String productName = request.getParameter("productName");
				System.out.println(productName);
				
				int price = Integer.parseInt(request.getParameter("price"));
				System.out.println(price);
				
				int quantity = Integer.parseInt(request.getParameter("quantity"));
				System.out.println(quantity);
				
				String description = request.getParameter("description");
				System.out.println(description);
				
				int result = dao.modifyProductNew(productCode, productName, price, quantity, description);
				
				if(result>0) {response.sendRedirect(rootPath+"/adminBack/modifyProductResult.jsp");}

			}else if(cmd.contentEquals("/deleteProduct.admini")) {
				String productCode = request.getParameter("productCode");
				dao.deleteCategoryProdCode(productCode);
				dao.deleteProduct(productCode);
				dao.deleteProductDetail(productCode);
				response.sendRedirect(rootPath+"/adminBack/deleteProductResult.jsp");

			}else if(cmd.contentEquals("/delivery.admini")) {
				String merchant_uid = request.getParameter("merchant_uid");
				int result = dao.deliveryState(merchant_uid);
				if(result > 0) {
					response.getWriter().append("success");
				}else {
					response.getWriter().append("fail");
				}

			}else if(cmd.contentEquals("/orderManagement.admini")) {
				List<OrderManagementDTO> list = dao.orderManagementList(); // 구매내역 테이블 리스트 받아옴

				//product 테이블에 구매수량 감소시키기 위해서 상품명 구해야 함
				Map<String,Integer> name_quantity_list = new HashMap<>();
				for(OrderManagementDTO tmp : list) {
					if(tmp.getProcessed().contentEquals("N")) {
						name_quantity_list.put(tmp.getProd_name(), tmp.getProd_quantity());
					}
				}
				int result = dao.changeQuantity(name_quantity_list); // product 테이블에 구매수량만큼 감소시킴
				int result2 = dao.changeProcessedColumn(); // order_list 테이블에 done 칼럼 전부 'Y'로 바꿈
				
				request.setAttribute("list", list);
				request.getRequestDispatcher("/adminBack/orderManagement.jsp").forward(request, response);

			}else if(cmd.contentEquals("/getProductCode.admini")) {
				String category = request.getParameter("category");
				List productCodeList = dao.getProductCode(category);
				Gson gson = new Gson();
				response.getWriter().append(gson.toJson(productCodeList));

			}else if(cmd.contentEquals("/getProductInfo.admini")) {
				String productCode = request.getParameter("productCode");
				//List productList = dao.productList(productCode);
				ProductDTO product = dao.eachProductInfo(productCode);
				Gson gson = new Gson();
				//response.getWriter().append(gson.toJson(productList));
				response.getWriter().append(gson.toJson(product));
			
			}else if(cmd.contentEquals("/detailProduct.admini")) {
				String uploadPath = request.getServletContext().getRealPath("/Resource/img"); // 여기 경로 조심...
				File uploadFilePath = new File(uploadPath);
				if(!uploadFilePath.exists()) {
					uploadFilePath.mkdir();
				}

				int maxSize = 1024 * 1024 * 10; 
				MultipartRequest multi = new MultipartRequest(request,uploadPath,maxSize,"UTF8",new DefaultFileRenamePolicy()); 

				String fileName = multi.getFilesystemName("img");
//				String oriFileName = multi.getOriginalFileName("img"); 
//
//				FilesDTO dto = new FilesDTO(0,1,fileName,oriFileName);
//
//				FilesDAO filedao = FilesDAO.getInstance();
//				int result = filedao.insert(dto);

				String respPath = rootPath+"/Resource/img/";
				respPath+=fileName;

				JsonObject obj = new JsonObject();
				obj.addProperty("url", respPath);
				response.getWriter().append(obj.toString());

			}else if(cmd.contentEquals("/insertDetail.admini")) {
				String uploadPath = request.getServletContext().getRealPath("/Resource/img");
				File uploadFilePath = new File(uploadPath);
				if(!uploadFilePath.exists()) {
					uploadFilePath.mkdir();
				}
				int maxSize = 1024 * 1024 * 10;
				MultipartRequest multi = new MultipartRequest(request,uploadPath,maxSize,"UTF8",new DefaultFileRenamePolicy());
                
				String prod_code = multi.getParameter("prod_code");
				String content = multi.getParameter("content");
				String ingredients = multi.getParameter("ingredients");

				int result = dao.insertDetail(prod_code,content,ingredients);
				if(result > 0) {
					response.sendRedirect(rootPath+"/adminBack/insertDetailResult.jsp");
				}
			
			}else if(cmd.contentEquals("/detailBoard.admini")) {
				List<DetailDTO> list = dao.getDetailList();
				request.setAttribute("list", list);
				request.getRequestDispatcher("/adminBack/detailList.jsp").forward(request, response);
				
			}else if(cmd.contentEquals("/detailView.admini")) {
				String prod_code = request.getParameter("prod_code");
				DetailDTO dto = dao.getDetail(prod_code);
				//List<ProductDTO> list = dao.productList(prod_code); // dao.eachProductInfo(prod_code) 바꿀 수 있으면 바꿔..
				ProductDTO product = dao.eachProductInfo(prod_code);
				request.setAttribute("Detail", dto);
				request.setAttribute("Product", product);
				request.getRequestDispatcher("/adminBack/detailView.jsp").forward(request, response);
			
			}else if(cmd.contentEquals("/modifyDetail.admini")) {
				String uploadPath = request.getServletContext().getRealPath("/Resource/img/");
				int maxSize = 1024 * 1024 * 10;
				MultipartRequest multi = new MultipartRequest(request,uploadPath,maxSize,"UTF8",new DefaultFileRenamePolicy()); 

				//String productCode = multi.getParameter("productCode");			
				//String category = multi.getParameter("category");
				//String productName = multi.getParameter("productName");
				//int price = Integer.parseInt(multi.getParameter("price"));
				//int quantity = Integer.parseInt(multi.getParameter("quantity"));
				//String description = multi.getParameter("description");
				//int spring = Integer.parseInt(multi.getParameter("spring"));
				//int summer = Integer.parseInt(multi.getParameter("summer"));
				//int fall = Integer.parseInt(multi.getParameter("fall"));
				//int winter = Integer.parseInt(multi.getParameter("winter"));
				String oriCode = multi.getParameter("oriCode");
				String content = multi.getParameter("content");
				String ingredients = multi.getParameter("ingredients");
				System.out.println(ingredients);
				
				//int result1 = dao.modifyProduct(productCode, category, productName, price, quantity, description, spring, summer, fall, winter, oriCode);
				int result2 = dao.modifyDetail(content, ingredients, oriCode);
				
//				if(result1>0 && result2>0) {
//					response.sendRedirect(rootPath+"/adminBack/modifyDetailResult.jsp");
//				}
				
				if(result2>0) {
					response.sendRedirect(rootPath+"/adminBack/modifyDetailResult.jsp");
				}				
			
			//여기서부터 front쪽	
				
			}else if(cmd.contentEquals("/eachProduct.admini")) {
				String productCode = request.getParameter("productCode");
				System.out.println(productCode);
				ProductDTO dto = dao.eachProductInfo(productCode);
				String category = dto.getCategory();
				category = category.replace(" ", "");
				char[] arr = category.toCharArray();
				StringBuilder sb = new StringBuilder();
				for (int i = 0; i < arr.length; i++) {
					if((int)arr[i] >=65 && (int)arr[i]<=90 ) {
						arr[i] = (char)((int)arr[i]+32);
					}
					sb.append(arr[i]);
				}
				System.out.println(sb.toString());
				request.setAttribute("dto", dto);
				request.getRequestDispatcher("/Goods/"+ sb.toString()  +"_detail.jsp").forward(request, response);
			
			}else if(cmd.contentEquals("/checkProduct.admini")) {
				String productCode = request.getParameter("productCode");
				System.out.println(productCode);
				int result = dao.countProduct(productCode);
				if(result == 0) {response.getWriter().append("new");}
				else if(result > 0) {response.getWriter().append("exist");}
			}
			

		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
