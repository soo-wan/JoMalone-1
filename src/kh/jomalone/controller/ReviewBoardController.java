package kh.jomalone.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kh.jomalone.DAO.ReviewDAO;
import kh.jomalone.DTO.ReviewDTO;
import kh.jomalone.configuration.Configuration;

@WebServlet("*.review")
public class ReviewBoardController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf8");
		String cmd = request.getRequestURI().substring(request.getContextPath().length());
		/* ajax 한글깨짐 방지 */
		response.setCharacterEncoding("utf8");
		response.setContentType("text/html; charset=UTF-8");

		String id = (String) request.getSession().getAttribute("loginInfo");

		ReviewDAO dao = ReviewDAO.getInstance();

		if (cmd.contentEquals("/allList.review")) {// 전체리뷰게시판(관리자)
			try {
				int currentPage = 1;
				String page = request.getParameter("currentPage");
				if (page != null) {
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				}
				int start = currentPage * (Configuration.recordCountPerPage) - (Configuration.recordCountPerPage - 1);
				int end = currentPage * (Configuration.recordCountPerPage);
				List<ReviewDTO> result = dao.selectByPage(start, end);
				String pageNavi = dao.getPageNavi(currentPage, "allList.review", "admin", null);
				request.setAttribute("selectResult", result);
				request.setAttribute("pageNavi", pageNavi);
				request.getRequestDispatcher("reviewboard/AllReviewList.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}
		} else if (cmd.contentEquals("/list.review")) {// 전체리뷰게시판(회원)
			try {
				int currentPage = 1;
				String page = request.getParameter("currentPage");
				if (page != null) {
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				}
				int start = currentPage * (Configuration.recordCountPerPage) - (Configuration.recordCountPerPage - 1);
				int end = currentPage * (Configuration.recordCountPerPage);
				List<ReviewDTO> result = dao.selectByPage(start, end);
				String pageNavi = dao.getPageNavi(currentPage, "list.review", "admin", null);
				request.setAttribute("selectResult", result);
				request.setAttribute("pageNavi", pageNavi);
				if (request.getAttribute("blind") != null) {
					request.setAttribute("blind", "yes");
				}
				request.getRequestDispatcher("reviewboard/ReviewList.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}

		} else if (cmd.contentEquals("/myList.review")) {// 나의리뷰게시판
			try {
				String overLimit = (String) request.getAttribute("overLimit");
				if (overLimit != null) {
					request.setAttribute("overLimit", overLimit);
				}
				int currentPage = 1;
				String page = request.getParameter("currentPage");
				if (page != null) {
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				}
				int start = currentPage * (Configuration.recordCountPerPage) - (Configuration.recordCountPerPage - 1);
				int end = currentPage * (Configuration.recordCountPerPage);
				List<ReviewDTO> result = dao.selectByPageById(start, end, id);
				String pageNavi = dao.getPageNavi(currentPage, "myList.review", "member", id);
				request.setAttribute("selectResult", result);
				request.setAttribute("pageNavi", pageNavi);
				if (request.getAttribute("blind") != null) {
					request.setAttribute("blind", "yes");
				}
				request.getRequestDispatcher("reviewboard/MyReviewList.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}

		} else if (cmd.contentEquals("/write.review")) {// 리뷰작성페이지로 넘어가기전
			try {
				int order_seq = Integer.parseInt(request.getParameter("seq"));
				String prodName = request.getParameter("prodName");
				boolean blank = dao.isPossibleToWriteReview(order_seq);
				if (blank) {
					request.setAttribute("order_seq", order_seq);
					request.setAttribute("prodName", prodName);
					request.getRequestDispatcher("reviewboard/ReviewWriteCall.jsp").forward(request, response);
				} else {
					request.setAttribute("overLimit", "yes");
					request.getRequestDispatcher("myList.review").forward(request, response);
				}

			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}

		} else if (cmd.contentEquals("/writeConfirm.review")) {// 리뷰작성
			try {
				int order_seq = Integer.parseInt(request.getParameter("buySeq"));
				String prod_name = request.getParameter("prodName");
				String title = request.getParameter("title");
				String contents = request.getParameter("contents");
				int grade = Integer.parseInt(request.getParameter("grade"));
				dao.insertReview(new ReviewDTO(0, order_seq, prod_name, id, title, contents, grade, null, null));
				int seq = dao.findLatestReviewSeqById(id);
				response.sendRedirect("read.review?no=" + seq);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}
		} else if (cmd.contentEquals("/read.review")) {// 리뷰 상세페이지 보기
			int seq = Integer.parseInt(request.getParameter("no"));
			String location = request.getParameter("location");
			try {
				ReviewDTO readDTO = dao.selectReviewBySeq(seq);
				if (readDTO.getBlind_yn().contentEquals("Y")) {
					if(location!=null) {
						if (location.contentEquals("myReviews")) {
							System.out.println(seq + ":" + location + ":" + readDTO.getBlind_yn());
							request.setAttribute("blindCheck", "yes");
							request.getRequestDispatcher("myList.review").forward(request, response);
						} else if (location.contentEquals("allReviews")) {
							request.setAttribute("blindCheck", "yes");
							request.getRequestDispatcher("list.review").forward(request, response);
						} else if (location.contentEquals("adminReviews")) {
							request.setAttribute("readDTO", readDTO);
							request.setAttribute("root", location);
							request.getRequestDispatcher("reviewboard/ReviewDetailView.jsp").forward(request, response);		
						}
					}else {
						request.setAttribute("blindCheck", "yes");
						request.getRequestDispatcher("list.review").forward(request, response);
					}
					
				} else {
					request.setAttribute("readDTO", readDTO);
					request.setAttribute("root", location);
					request.getRequestDispatcher("reviewboard/ReviewDetailView.jsp").forward(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}

		} else if (cmd.contentEquals("/modify.review")) {// 리뷰 수정
			int seq = Integer.parseInt(request.getParameter("reviewSeq"));
			try {
				ReviewDTO result = dao.selectReviewBySeq(seq);
				request.setAttribute("readDTO", result);
				request.getRequestDispatcher("reviewboard/ReviewModifyCall.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}

		} else if (cmd.contentEquals("/modifyConfirm.review")) {// 리뷰 수정
			try {
				int seq = Integer.parseInt(request.getParameter("reviewSeq"));
				String prod_name = request.getParameter("prodMenu");
				String title = request.getParameter("title");
				String contents = request.getParameter("contents");
				int grade = Integer.parseInt(request.getParameter("grade"));
				dao.updateReview(new ReviewDTO(seq, 0, prod_name, id, title, contents, grade, null, null));
				response.sendRedirect("read.review?no=" + seq);

			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}

		} else if (cmd.contentEquals("/delete.review")) {// 리뷰 삭제
			int seq = Integer.parseInt(request.getParameter("no"));
			String location = request.getParameter("location");
			System.out.println(seq + ":" + location);
			try {
				dao.deleteReview(seq);
				if (location.contentEquals("myReviews")) {
					response.sendRedirect("myList.review");
				} else if (location.contentEquals("allReviews")) {
					response.sendRedirect("list.review");
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}

		} else if (cmd.contentEquals("/summernote.review")) {
			String uploadPath = request.getServletContext().getRealPath("/files");
			File uploadFilePath = new File(uploadPath);
			if (!uploadFilePath.exists()) {
				uploadFilePath.mkdir();
			}
			int maxSize = 1024 * 1024 * 10;
			MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "UTF8",
					new DefaultFileRenamePolicy());

			List<String> fileNameList = new ArrayList<>();
			Enumeration e = multi.getFileNames();
			while (e.hasMoreElements()) {
				String file = (String) e.nextElement();
				String fileName = multi.getFilesystemName(file);
				fileNameList.add(fileName);
			}

			JsonArray list = new JsonArray();
			for (String fileName : fileNameList) {
				JsonObject obj = new JsonObject();
				obj.addProperty("url", request.getContextPath() + "/files/" + fileName);
				list.add(obj);
			}

			response.getWriter().append(list.toString());
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
