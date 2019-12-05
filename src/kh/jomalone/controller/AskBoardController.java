package kh.jomalone.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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

import kh.jomalone.DAO.AskDAO;
import kh.jomalone.DTO.AskCommentsDTO;
import kh.jomalone.DTO.AskDTO;
import kh.jomalone.Util.SendMail;
import kh.jomalone.Util.Util;
import kh.jomalone.configuration.Configuration;

@WebServlet("*.ask")
public class AskBoardController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf8");
		String cmd = request.getRequestURI().substring(request.getContextPath().length());
		/* ajax 한글깨짐 방지 */
		response.setCharacterEncoding("utf8");
		response.setContentType("text/html; charset=UTF-8");

		String id = (String) request.getSession().getAttribute("loginInfo");
		AskDAO dao = AskDAO.getInstance();
		Util u = new Util();
		
		if (cmd.contentEquals("/list.ask")) {//나의문의게시판
			try {
				int currentPage = 1;
				String page = request.getParameter("currentPage");
				if (page != null) {
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				}
				int start = currentPage * (Configuration.recordCountPerPage) - (Configuration.recordCountPerPage - 1);
				int end = currentPage * (Configuration.recordCountPerPage);
				List<AskDTO> result = dao.selectByPageById(start, end, id);
				String pageNavi = dao.getPageNavi(currentPage,"list.ask","byId",id);
				request.setAttribute("selectResult", result);
				request.setAttribute("pageNavi", pageNavi);
				request.getRequestDispatcher("askboard/AskList.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}
			
		}else if (cmd.contentEquals("/newList.ask")) {//(관리자)신규문의게시판
			try {
				int currentPage = 1;
				String page = request.getParameter("currentPage");
				if (page != null) {
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				}
				int start = currentPage * (Configuration.recordCountPerPage) - (Configuration.recordCountPerPage - 1);
				int end = currentPage * (Configuration.recordCountPerPage);
				List<AskDTO> result = dao.selectByPageNotYetAnswer(start, end);
				String pageNavi = dao.getPageNavi(currentPage,"newList.ask","notYetAnswer",null);
				request.setAttribute("selectResult", result);
				request.setAttribute("pageNavi", pageNavi);
				request.getRequestDispatcher("askboard/NewAskList.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}
		}else if (cmd.contentEquals("/allList.ask")) {//(관리자)전체문의게시판
			try {
				int currentPage = 1;
				String page = request.getParameter("currentPage");
				if (page != null) {
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				}
				int start = currentPage * (Configuration.recordCountPerPage) - (Configuration.recordCountPerPage - 1);
				int end = currentPage * (Configuration.recordCountPerPage);
				List<AskDTO> result = dao.selectByPage(start, end);
				String pageNavi = dao.getPageNavi(currentPage,"allList.ask","entire",null);
				request.setAttribute("selectResult", result);
				request.setAttribute("pageNavi", pageNavi);
				request.getRequestDispatcher("askboard/AllAskList.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}
		} else if (cmd.contentEquals("/write.ask")) {// 문의글 등록	
			String askCode = request.getParameter("askMenu");
			String title = request.getParameter("title");
			String contents = request.getParameter("contents");
			String emailCheck = request.getParameter("emailCheck");
			
			
			if (emailCheck == null) {
				emailCheck = "N";
			} else {
				emailCheck = "Y";
			}
			
			try {
				dao.insertAsk(new AskDTO(0, askCode, title, contents, id, null, null, emailCheck));
				int seq = dao.findLatestAskSeqById(id);
				response.sendRedirect("read.ask?no=" + seq);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}

		} else if (cmd.contentEquals("/read.ask")) {// 문의글 상세페이지 보기
			int seq = Integer.parseInt(request.getParameter("no"));
			try {
				// 본문
				AskDTO readDTO = dao.selectAskBySeq(seq);
				request.setAttribute("readDTO", readDTO);
				// 댓글
				List<AskCommentsDTO> coResult = dao.selectCommentsByAskSeq(seq);				
				request.setAttribute("coList", coResult);

				request.setAttribute("location", request.getParameter("location"));
				request.getRequestDispatcher("askboard/AskDetailView.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}
			
		} else if (cmd.contentEquals("/modify.ask")) {// 문의글 수정
			int seq = Integer.parseInt(request.getParameter("askSeq"));
			try {
				AskDTO result = dao.selectAskBySeq(seq);
				request.setAttribute("readDTO", result);
				request.getRequestDispatcher("askboard/AskModifyCall.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}
		} else if (cmd.contentEquals("/modifyConfirm.ask")) {// 문의글 수정완료			
			int seq = Integer.parseInt(request.getParameter("askSeq"));			
			String askCode = request.getParameter("askMenu");
			String title = request.getParameter("title");
			String contents = request.getParameter("contents");
			String emailCheck = request.getParameter("emailCheck");
			
			if (emailCheck == null) {
				emailCheck = "N";
			} else {
				emailCheck = "Y";
			}
			try {
				int result = dao.updateAsk(new AskDTO(seq, askCode, title, contents, id, null, null, emailCheck));				
				response.sendRedirect("read.ask?no=" + seq);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}
			
		} else if (cmd.contentEquals("/delete.ask")) {// 문의글 삭제
			int seq = Integer.parseInt(request.getParameter("no"));
			try {
				dao.deleteAsk(seq);
				response.sendRedirect("list.ask");
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}
		} else if (cmd.contentEquals("/summernote.ask")) {
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
		} else if (cmd.contentEquals("/writeComment.ask")) {// 댓글작성 ajax
			int originSeq = Integer.parseInt(request.getParameter("writingSeq"));
			//String contents = request.getParameter("contents");
			String contents = Util.ProtectXSS(request.getParameter("contents"));
			String emailOk = request.getParameter("emailOk");
			String memId = request.getParameter("memId");
			String askType = request.getParameter("askType");
			String askTitle = request.getParameter("askTitle");
			String askDate = request.getParameter("askDate");
			try {
				dao.insertAskComment(new AskCommentsDTO(0,originSeq,contents,null));
				dao.AnswerAskCondition("Y", originSeq);
				List<AskCommentsDTO> result = dao.selectCommentsByAskSeq(originSeq);				
				
				Gson g = new Gson();
				String dtoList = g.toJson(result);
				
				if(emailOk.equals("Y")) {
					
					List<String> nameEmail = dao.findMemNameEmailById(memId);
					
					String subject = "[조말론]"+nameEmail.get(0)+"님 문의 내용에 대한 답변입니다.";
					String msg = "문의종류 : "+askType+"\n문의제목 : "+askTitle+"\n문의일 : "+askDate+"\n\n"+"[답변내용]\n"+contents;
					new SendMail().sendMail(nameEmail.get(1), subject, msg);										
				}
				
				
				
				System.out.println(originSeq+":"+contents+":"+emailOk+":"+memId+":"+askType+":"+askTitle+":"+askDate);
				 response.getWriter().append(dtoList);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}
			
		} else if (cmd.contentEquals("/deleteComment.ask")) {
			int originSeq = Integer.parseInt(request.getParameter("no"));
			int seq = Integer.parseInt(request.getParameter("coNo"));			
			try {
				dao.deleteAskComment(seq);
				dao.AnswerAskCondition("N", originSeq);
				response.sendRedirect("read.ask?no="+originSeq);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}

		} else if (cmd.contentEquals("/modifyComment.ask")) {
			int seq = Integer.parseInt(request.getParameter("coNo"));		
			PrintWriter pWriter = response.getWriter();
			try {
				AskCommentsDTO dto = dao.selectCommentByCoSeq(seq);
				Gson g = new Gson();
				String contents = g.toJson(dto);
				pWriter.append(contents);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}
		} else if (cmd.contentEquals("/modifyCommentConfirm.ask")) {
			int originSeq = Integer.parseInt(request.getParameter("modSeq"));
			int seq = Integer.parseInt(request.getParameter("modCoNo"));
			String contents = (String) request.getParameter("modComment");
			try {
				dao.updateAskComment(contents, seq);
				response.sendRedirect("read.ask?no=" + originSeq);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
