package kh.jomalone.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.jomalone.DAO.AskDAO;
import kh.jomalone.DAO.ReportDAO;
import kh.jomalone.DAO.ReviewDAO;
import kh.jomalone.DAO.SearchDAO;
import kh.jomalone.DTO.AskDTO;
import kh.jomalone.DTO.ReportDTO;
import kh.jomalone.DTO.ReviewDTO;
import kh.jomalone.configuration.Configuration;

@WebServlet("*.search")
public class SearchController extends HttpServlet {
     
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	   	request.setCharacterEncoding("utf8");
		String cmd = request.getRequestURI().substring(request.getContextPath().length());
		/* ajax 한글깨짐 방지 */
		response.setCharacterEncoding("utf8");
		response.setContentType("text/html; charset=UTF-8");
		String id = (String)request.getSession().getAttribute("loginInfo");
		
		SearchDAO dao = SearchDAO.getInstance();
		AskDAO askDao = AskDAO.getInstance();
		ReviewDAO reviewDao = ReviewDAO.getInstance();
		ReportDAO reportDao = ReportDAO.getInstance();
		int currentPage = 1;
		String page = request.getParameter("currentPage");
		if (page != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		int start = currentPage * (Configuration.recordCountPerPage) - (Configuration.recordCountPerPage - 1);
		int end = currentPage * (Configuration.recordCountPerPage);

		
		try {
			if (cmd.contentEquals("/review.search")) {//리뷰페이지 검색
				String option = request.getParameter("reviewSearch");//검색조건
				String target = request.getParameter("searchInput");//검색어
				String root = request.getParameter("rootPage");//검색들어온 페이지(마이리뷰,전체리뷰,관리자리뷰)
				//System.out.println(option+":"+target+":"+root);				
				//listPage
				//myPage
				//fromAdmin				
				
				List<ReviewDTO> result = null;
				String pageNavi = null;
				
				
				if(root.contentEquals("fromAdmin")) {//관리자리뷰에서 검색
					if(option.contentEquals("mem_id")) {//검색조건이 회원아이디라면(관리자리뷰만 가능)
						result = reviewDao.selectByPageById(start, end, target);
						pageNavi = reviewDao.getPageNavi(currentPage, "review.search", "member", target);
					}else {//검색조건이 제목,내용,또는 select유형
						result = dao.selectReviewPageByOption(start, end, option, target);
						pageNavi = dao.getPageNavi(currentPage, "review.search", "reviewboard", option, target, "admin", null);
					}
					
					request.setAttribute("selectResult", result);
					request.setAttribute("pageNavi", pageNavi);
					request.setAttribute("fromSearch", "yes");
					request.getRequestDispatcher("reviewboard/AllReviewList.jsp").forward(request, response);
					
					
				}else if(root.contentEquals("myPage")) {//마이페이지에서 검색(로그인한 회원본인) - 아이디검색막음
					result = dao.selectMyReviewPageByOption(start, end, option, target, id);
					pageNavi = dao.getPageNavi(currentPage, "review.search", "reviewboard", option, target, "member", id);
					
					request.setAttribute("selectResult", result);
					request.setAttribute("pageNavi", pageNavi);
					request.setAttribute("fromSearch", "yes");
					request.getRequestDispatcher("reviewboard/MyReviewList.jsp").forward(request, response);
					
									
				}else if(root.contentEquals("listPage")) {//공개리뷰게시판에서검색 - 아이디검색막음
					result = dao.selectReviewPageByOption(start, end, option, target);
					pageNavi = dao.getPageNavi(currentPage, "review.search", "reviewboard", option, target, "admin", null);
					
					request.setAttribute("selectResult", result);
					request.setAttribute("pageNavi", pageNavi);
					request.setAttribute("fromSearch", "yes");
					request.getRequestDispatcher("reviewboard/MyReviewList.jsp").forward(request, response);
				}
				
				
				
				
				
			}else if (cmd.contentEquals("/ask.search")) {//문의 검색
				String option = request.getParameter("askSearch");
				String target = request.getParameter("searchInput");
				String root = request.getParameter("rootPage");
				System.out.println(option+":"+target+":"+root);
				//myPage
				//fromAdminNew
				//fromAdminEntire
				
				if(option.contentEquals("ask_code")) {
					target = request.getParameter("askCodeSearch");
				}
				
				List<AskDTO> result = null;
				String pageNavi = null;		
				
				if (root.contentEquals("fromAdminEntire")) {//관리자페이지 전체문의
					if(option.contentEquals("mem_id")) {//검색조건이 회원아이디라면(관리자리뷰만 가능)
						result = askDao.selectByPageById(start, end, target);
						pageNavi = askDao.getPageNavi(currentPage, "review.search", "byId", target);
					}else {//검색조건이 제목,내용,또는 문의유형
						result = dao.selectAskPageByOption(start, end, option, target);
						pageNavi = dao.getPageNavi(currentPage, "review.search", "reviewboard", option, target, "admin", null);
					}
					
					request.setAttribute("selectResult", result);
					request.setAttribute("pageNavi", pageNavi);
					request.setAttribute("fromSearch", "yes");
					request.getRequestDispatcher("askboard/AllAskList.jsp").forward(request, response);
				} else if (root.contentEquals("myPage")) {
					result = dao.selectMyAskPageByOption(start, end, option, target, id);
					pageNavi = dao.getPageNavi(currentPage, "review.search", "reviewboard", option, target, "member", id);
					
					request.setAttribute("selectResult", result);
					request.setAttribute("pageNavi", pageNavi);
					request.setAttribute("fromSearch", "yes");
					request.getRequestDispatcher("askboard/AskList.jsp").forward(request, response);
				}
				
				
				
				
			}else if (cmd.contentEquals("/report.search")) {// 신고글 검색
				String option = request.getParameter("reportSearch");
				String target = request.getParameter("searchInput");
				String root = request.getParameter("rootPage");
				System.out.println(option+":"+target+":"+root);
				
				if(option.contentEquals("report_type")) {
					target = request.getParameter("reportTypeSearch");
				}
				
				List<ReportDTO> result = null;
				String pageNavi = null;
				
				if(option.contentEquals("mem_id")) {
					result = reportDao.selectByPageById(start, end, target);
					pageNavi = reportDao.getPageNavi(currentPage, "report.search", "byId", target);
				}else {
					result = dao.selectReportPageByOption(start, end, option, target);
					pageNavi = dao.getPageNavi(currentPage, "report.search", "reportboard", option, target, "admin", null);
				}
				
				request.setAttribute("selectResult", result);
				request.setAttribute("pageNavi", pageNavi);
				request.setAttribute("fromSearch", "yes");
				request.getRequestDispatcher("reportboard/AllReportList.jsp").forward(request, response);
				
				
			}else if(cmd.contentEquals("/eachProd.review")) {
				String prodName = request.getParameter("prod_name");
				dao.getReviewPageNavi(currentPage, prodName);
				
			}
			
			
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
