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

import kh.jomalone.DAO.NoticeDAO;
import kh.jomalone.DTO.NoticeDTO;
import kh.jomalone.configuration.Configuration;

@WebServlet("*.notice")
public class NoticeController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf8");
		String cmd = request.getRequestURI().substring(request.getContextPath().length());
		/* ajax 한글깨짐 방지 */
		response.setCharacterEncoding("utf8");
		response.setContentType("text/html; charset=UTF-8");

		NoticeDAO dao = NoticeDAO.getInstance();
		
		try {

			if (cmd.contentEquals("/list.notice")) {// 공지게시판				
				int currentPage = 1;
				String page = request.getParameter("currentPage");
				if (page != null) {
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				}
				int start = currentPage * (Configuration.recordCountPerPage) - (Configuration.recordCountPerPage - 1);
				int end = currentPage * (Configuration.recordCountPerPage);

				List<NoticeDTO> result = dao.selectByPage(start, end);
				String pageNavi = dao.getPageNavi(currentPage);
				request.setAttribute("selectResult", result);
				request.setAttribute("pageNavi", pageNavi);
				
				
				
				request.getRequestDispatcher("noticeboard/Notice.jsp").forward(request, response);
//				if(request.getSession().getAttribute("adminId")==null) {
//					request.getRequestDispatcher("noticeboard/Notice.jsp").forward(request, response);
//				}else {
//					request.getRequestDispatcher("admin/adminBoard.jsp").forward(request, response);
//				}
				
				
				
			} else if (cmd.contentEquals("/read.notice")) {// 공지읽기
				int seq = Integer.parseInt(request.getParameter("no"));
				NoticeDTO result = dao.selectNotice(seq);
				request.setAttribute("readDTO", result);
				request.getRequestDispatcher("noticeboard/NoticeDetailView.jsp").forward(request, response);
				
			} else if (cmd.contentEquals("/write.notice")) {// 공지쓰기
				String title = request.getParameter("title");
				String contents = request.getParameter("contents");
				dao.insertNotice(new NoticeDTO(0,title,contents,null));
				int seq = dao.findLatestNotice();
				response.sendRedirect("read.notice?no="+seq);
				
			} else if (cmd.contentEquals("/modify.notice")) {// 공지수정
				int seq = Integer.parseInt(request.getParameter("noticeSeq"));
				NoticeDTO result = dao.selectNotice(seq);
				request.setAttribute("readDTO", result);
				request.getRequestDispatcher("noticeboard/NoticeModifyCall.jsp").forward(request, response);
				
			} else if (cmd.contentEquals("/modifyConfirm.notice")) {// 공지수정완료
				int seq = Integer.parseInt(request.getParameter("noticeSeq"));
				String title = request.getParameter("title");
				String contents = request.getParameter("contents");
				dao.updateNotice(new NoticeDTO(seq,title,contents,null));
				response.sendRedirect("read.notice?no=" + seq);
				
			} else if (cmd.contentEquals("/delete.notice")) {// 공지삭제
				int seq = Integer.parseInt(request.getParameter("no"));
				dao.deleteNotice(seq);
				response.sendRedirect("list.notice");
				
			} else if (cmd.contentEquals("/summernote.notice")) {
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
				
			} else if (cmd.contentEquals("/home.notice")) {
				List<NoticeDTO> latestNotices = dao.latestNotices();
				Gson g = new Gson();
				String data = g.toJson(latestNotices);
				response.getWriter().append(data);
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
