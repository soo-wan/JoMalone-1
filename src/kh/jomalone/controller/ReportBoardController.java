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

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kh.jomalone.DAO.ReportDAO;
import kh.jomalone.DTO.ReportDTO;
import kh.jomalone.configuration.Configuration;

@WebServlet("*.report")
public class ReportBoardController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf8");
		String cmd = request.getRequestURI().substring(request.getContextPath().length());
		/* ajax 한글깨짐 방지 */
		response.setCharacterEncoding("utf8");
		response.setContentType("text/html; charset=UTF-8");

		String id = (String) request.getSession().getAttribute("loginInfo");
		ReportDAO dao = ReportDAO.getInstance();
		
		if(cmd.contentEquals("/allList.report")) {
			request.getSession().setAttribute("fromAdminAskPage", "yes");
			try {
				int currentPage = 1;
				String page = request.getParameter("currentPage");
				if (page != null) {
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				}
				int start = currentPage * (Configuration.recordCountPerPage) - (Configuration.recordCountPerPage - 1);
				int end = currentPage * (Configuration.recordCountPerPage);
				
				List<ReportDTO> result = dao.selectByPage(start, end);
				String pageNavi = dao.getPageNavi(currentPage, "allList.report", "entire");
				request.setAttribute("selectResult", result);
				request.setAttribute("pageNavi", pageNavi);
				request.getRequestDispatcher("reportboard/AllReportList.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}
			
		}else if(cmd.contentEquals("/newList.report")) {
			request.getSession().setAttribute("fromAdminAskPage", "yes");
			try {
				int currentPage = 1;
				String page = request.getParameter("currentPage");
				if (page != null) {
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				}
				int start = currentPage * (Configuration.recordCountPerPage) - (Configuration.recordCountPerPage - 1);
				int end = currentPage * (Configuration.recordCountPerPage);
				
				List<ReportDTO> result = dao.selectByPageNotYetCheck(start, end);
				String pageNavi = dao.getPageNavi(currentPage, "newList.report", "notYetCheck");
				request.setAttribute("selectResult", result);
				request.setAttribute("pageNavi", pageNavi);
				request.getRequestDispatcher("reportboard/NewReportList.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}
			
		}else if(cmd.contentEquals("/check.report")) {
			int reportSeq = Integer.parseInt(request.getParameter("reportSeq"));		
			int reviewSeq = Integer.parseInt(request.getParameter("reviewSeq"));
			String checkType = request.getParameter("checkType");
			String checkComments = request.getParameter("checkComments");
			//System.out.println(reportSeq+":"+reviewSeq+":"+checkType+":"+checkComments);
			try {
				int result = dao.checkReport(checkComments, checkType, reportSeq);
				if(checkType.contentEquals("none")) {
					dao.makeReviewNonBlindBySeq(reviewSeq);
				}else if(checkType.contentEquals("blind")) {
					dao.makeReviewBlindBySeq(reviewSeq);
				}else if(checkType.contentEquals("delete")) {
					dao.makeReviewDeleteBySeq(reviewSeq);
				}
				ReportDTO dto = dao.selectReportBySeq(reportSeq);
				Gson g = new Gson();
				String resultDTO = g.toJson(dto);
				if(result>0) {
					response.getWriter().append(resultDTO);
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}
			
		}else if(cmd.contentEquals("/read.report")) {	
			int reviewSeq = Integer.parseInt(request.getParameter("article"));
			int reportSeq = Integer.parseInt(request.getParameter("no"));
			String location = request.getParameter("location");
			try {
				ReportDTO result = dao.selectReportBySeq(reportSeq);
				int accumulation = dao.accumulationReport(reviewSeq);
				ReportDTO preCheck = dao.preCheckReport(reviewSeq);
				request.setAttribute("root", location);
				request.setAttribute("resultDTO", result);
				request.setAttribute("accumulation", accumulation);
				request.setAttribute("preCheckDTO", preCheck);
				request.getRequestDispatcher("reportboard/ReportDetailView.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}
		}else if(cmd.contentEquals("/write.report")) {
			int seq = Integer.parseInt(request.getParameter("no"));
			request.setAttribute("reviewSeq", seq);
			request.getRequestDispatcher("reportboard/ReportWriteCall.jsp").forward(request, response);
			
		}else if(cmd.contentEquals("/deal.report")) {
			int seq = Integer.parseInt(request.getParameter("no"));
			try {
				ReportDTO preCheck = dao.preCheckReport(seq);
				ReportDTO result = dao.selectAdminReport(seq);
				request.setAttribute("preCheckDTO", preCheck);
				request.setAttribute("resultDTO", result);
				request.setAttribute("reviewSeq", seq);
				System.out.println(preCheck+":"+seq);
				request.getRequestDispatcher("reportboard/ReportDealCall.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}
			
		}else if(cmd.contentEquals("/writeConfirm.report")) {		
			int seq = Integer.parseInt(request.getParameter("articleSeq"));
			String reportType = request.getParameter("reportType");
			String contents = request.getParameter("contents");		
			try {
				dao.insertReport(new ReportDTO(0,reportType,seq,id,contents,null,null,null,null,null));
				response.sendRedirect("list.review");
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}
		
		}else if (cmd.contentEquals("/summernote.report")) {
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

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
