package kh.jomalone.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.jomalone.DTO.AskDTO;
import kh.jomalone.DTO.ReportDTO;
import kh.jomalone.DTO.ReviewDTO;
import kh.jomalone.configuration.Configuration;



public class SearchDAO {
	private static SearchDAO instance;

	public synchronized static SearchDAO getInstance() {
		if (instance == null) {
			instance = new SearchDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		return DAO.bds.getConnection();
	}	
	
	
	private int getArticleCountLike(String boardName, String columnName, String target) throws Exception {
		String sql = "select count(*) from "+boardName+" where "+columnName+" like '%' || ? || '%'";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, target);
			try(ResultSet rs = pstat.executeQuery();){
				rs.next();
				return rs.getInt(1);				
			}
		}
	}
	
	private int getArticleCountInMyPage(String boardName, String columnName, String target, String id) throws Exception {
		String sql = "select count(*) from "+boardName+" where "+columnName+" like '%' || ? || '%' and mem_id=?";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, target);
			pstat.setString(2, id);
			try(ResultSet rs = pstat.executeQuery();){
				rs.next();
				return rs.getInt(1);				
			}
		}
	}
	
	private int getArticleCountExactId(String boardName, String id) throws Exception {
		String sql = "select count(*) from "+boardName+" where mem_id = ?";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, id);
			try(ResultSet rs = pstat.executeQuery();){
				rs.next();
				return rs.getInt(1);				
			}
		}
	}
	
	private int getArticleCountExactProd(String prodName) throws Exception {
		String sql = "select count(*) from reviewboard where prod_name = ?";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, prodName);
			try(ResultSet rs = pstat.executeQuery();){
				rs.next();
				return rs.getInt(1);				
			}
		}
	}
	
	public String getReviewPageNavi(int currentPage, String target) throws Exception {
		int recordTotalCount = getArticleCountExactProd(target);
				
		int pageTotalCount = 0;
		if (recordTotalCount % Configuration.recordCountPerPage > 0) {
			pageTotalCount = recordTotalCount / Configuration.recordCountPerPage + 1;
		} else {
			pageTotalCount = recordTotalCount / Configuration.recordCountPerPage;
		}
		if (currentPage < 1) {
			currentPage = 1;
		} else if (currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		}

		int startNavi = (currentPage - 1) / Configuration.naviCountPerPage * Configuration.naviCountPerPage + 1;
		int endNavi = startNavi + (Configuration.naviCountPerPage - 1);

		if (endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}

		boolean needPrev = true;
		boolean needNext = true;

		if (startNavi == 1) {
			needPrev = false;
		}
		if (endNavi == pageTotalCount) {
			needNext = false;
		}

		StringBuilder sb = new StringBuilder();
		if (needPrev) {
			sb.append("<a href='review.search?currentPage=" + (startNavi - 1) + "'>< </a>");
		}
		for (int i = startNavi; i <= endNavi; i++) {
			sb.append("<a href='review.search?currentPage=" + i + "'>");
			sb.append(i);
			sb.append("</a> ");
		}
		if (needNext) {
			sb.append("<a href='review.search?currentPage=" + (endNavi + 1) + "'>></a>");
		}
		return sb.toString();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	public String getPageNavi(int currentPage, String linkURL, String boardName, String columnName, String target, String rootPage, String id) throws Exception {
		int recordTotalCount = 0;
		
		if(rootPage.contentEquals("member")) {
			recordTotalCount=this.getArticleCountInMyPage(boardName, columnName, target, id);
		}else {
			if(columnName.contentEquals("mem_id")) {
				recordTotalCount = this.getArticleCountExactId(boardName, id);
			}else {
				recordTotalCount = this.getArticleCountLike(boardName, columnName, target);
			}
		}
		
		int pageTotalCount = 0;
		if (recordTotalCount % Configuration.recordCountPerPage > 0) {
			pageTotalCount = recordTotalCount / Configuration.recordCountPerPage + 1;
		} else {
			pageTotalCount = recordTotalCount / Configuration.recordCountPerPage;
		}
		if (currentPage < 1) {
			currentPage = 1;
		} else if (currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		}

		int startNavi = (currentPage - 1) / Configuration.naviCountPerPage * Configuration.naviCountPerPage + 1;
		int endNavi = startNavi + (Configuration.naviCountPerPage - 1);

		if (endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}

		boolean needPrev = true;
		boolean needNext = true;

		if (startNavi == 1) {
			needPrev = false;
		}
		if (endNavi == pageTotalCount) {
			needNext = false;
		}

		StringBuilder sb = new StringBuilder();
		if (needPrev) {
			sb.append("<a href='" + linkURL + "?currentPage=" + (startNavi - 1) + "'>< </a>");
		}
		for (int i = startNavi; i <= endNavi; i++) {
			sb.append("<a href='" + linkURL + "?currentPage=" + i + "'>");
			sb.append(i);
			sb.append("</a> ");
		}
		if (needNext) {
			sb.append("<a href='" + linkURL + "?currentPage=" + (endNavi + 1) + "'>></a>");
		}
		return sb.toString();
	}
	
	
	
	
	
	
	
	
	
	
	public List<ReviewDTO> selectReviewPageByOption(int start, int end, String option, String target) throws Exception {
		String sql = "select * from (select reviewboard.*, row_number() over (order by review_seq desc) article from ReviewBoard where "+option+" like '%' || ? || '%') where article between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, target);
			pstat.setInt(2, start);
			pstat.setInt(3, end);

			try (ResultSet rs = pstat.executeQuery();) {
				List<ReviewDTO> result = new ArrayList<>();
				while (rs.next()) {
					ReviewDTO dto = new ReviewDTO();
					dto.setReview_seq(rs.getInt("review_seq"));
					dto.setOrder_seq(rs.getInt("order_seq"));
					dto.setProd_name(rs.getString("prod_name"));
					dto.setMem_id(rs.getString("mem_id"));
					dto.setTitle(rs.getString("title"));
					dto.setContents(rs.getString("contents"));
					dto.setGrade(rs.getInt("grade"));
					dto.setWrite_date(rs.getTimestamp("write_date"));
					dto.setBlind_yn(rs.getString("blind_yn"));
					result.add(dto);
				}
				return result;
			}
		}
	}
	
	
	public List<AskDTO> selectAskPageByOption(int start, int end, String option, String target) throws Exception {
		String sql = "select * from (select askboard.*, row_number() over (order by ask_seq desc) article from askboard where "+option+" like '%' || ? || '%') where article between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, target);
			pstat.setInt(2, start);
			pstat.setInt(3, end);

			try (ResultSet rs = pstat.executeQuery();) {
				List<AskDTO> result = new ArrayList<>();
				while (rs.next()) {
					AskDTO dto = new AskDTO();
					dto.setAsk_seq(rs.getInt("ask_seq"));
					dto.setAsk_code(rs.getString("ask_code"));
					dto.setTitle(rs.getString("title"));
					dto.setContents(rs.getString("contents"));
					dto.setAnswer_yn(rs.getString("answer_yn"));
					dto.setMem_id(rs.getString("mem_id"));
					dto.setWrite_date(rs.getTimestamp("write_date"));
					result.add(dto);
				}
				return result;
			}
		}
	}
	
	public List<ReportDTO> selectReportPageByOption(int start, int end, String option, String target) throws Exception {
		String sql = "select * from (select reportboard.*, row_number() over (order by report_seq desc) article from reportboard where "+option+" like '%' || ? || '%') where article between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, target);
			pstat.setInt(2, start);
			pstat.setInt(3, end);

			try (ResultSet rs = pstat.executeQuery();) {
				List<ReportDTO> result = new ArrayList<>();
				while (rs.next()) {
					ReportDTO dto = new ReportDTO();
					dto.setReport_seq(rs.getInt("report_seq"));
					dto.setReport_type(rs.getString("report_type"));
					dto.setReview_seq(rs.getInt("review_seq"));
					dto.setMem_id(rs.getString("mem_id"));
					dto.setContents(rs.getString("contents"));
					dto.setReport_date(rs.getTimestamp("report_date"));
					dto.setCheck_YN(rs.getString("check_yn"));
					dto.setCheck_comments(rs.getString("check_comments"));
					dto.setCheck_date(rs.getTimestamp("check_date"));
					result.add(dto);
				}
				return result;
			}
		}
	}
	
	public List<AskDTO> selectMyAskPageByOption(int start, int end, String option, String target, String id) throws Exception {
		String sql = "select * from (select askboard.*, row_number() over (order by ask_seq desc) article from askboard where "+option+" like '%' || ? || '%' and mem_id=?) where article between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, target);
			pstat.setString(2, id);
			pstat.setInt(3, start);
			pstat.setInt(4, end);

			try (ResultSet rs = pstat.executeQuery();) {
				List<AskDTO> result = new ArrayList<>();
				while (rs.next()) {
					AskDTO dto = new AskDTO();
					dto.setAnswer_yn(rs.getString("answer_yn"));
					dto.setAsk_code(rs.getString("ask_code"));
					dto.setAsk_seq(rs.getInt("ask_seq"));
					dto.setContents(rs.getString("contents"));
					dto.setEmail_yn(rs.getString("email_yn"));
					dto.setMem_id(rs.getString("mem_id"));
					dto.setTitle(rs.getString("title"));
					dto.setWrite_date(rs.getTimestamp("write_date"));
					result.add(dto);
				}
				return result;
			}
		}
	}
	
	public List<ReviewDTO> selectMyReviewPageByOption(int start, int end, String option, String target, String id) throws Exception {
		String sql = "select * from (select reviewboard.*, row_number() over (order by review_seq desc) article from reviewboard where "+option+" like '%' || ? || '%' and mem_id=?) where article between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, target);
			pstat.setString(2, id);
			pstat.setInt(3, start);
			pstat.setInt(4, end);

			try (ResultSet rs = pstat.executeQuery();) {
				List<ReviewDTO> result = new ArrayList<>();
				while (rs.next()) {
					ReviewDTO dto = new ReviewDTO();
					dto.setBlind_yn(rs.getString("blind_yn"));
					dto.setContents(rs.getString("contents"));
					dto.setGrade(rs.getInt("grade"));
					dto.setMem_id(rs.getString("mem_id"));
					dto.setOrder_seq(rs.getInt("order_seq"));
					dto.setProd_name(rs.getString("prod_name"));
					dto.setReview_seq(rs.getInt("review_seq"));
					dto.setTitle(rs.getString("title"));
					dto.setWrite_date(rs.getTimestamp("write_date"));
					result.add(dto);
				}
				return result;
			}
		}
	}

	
		
}






