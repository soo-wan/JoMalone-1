package kh.jomalone.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.jomalone.DTO.ReportDTO;
import kh.jomalone.configuration.Configuration;


public class ReportDAO {
	private static ReportDAO instance;
	private BasicDataSource bds = new BasicDataSource();
	
	private ReportDAO() {
		bds.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		bds.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		bds.setUsername("jomalone");
		bds.setPassword("jomalone");
		bds.setInitialSize(30);
	}
	
	public synchronized static ReportDAO getInstance() {
		if(instance==null) {
			instance = new ReportDAO();
		}
		return instance;
	}
	
	private Connection getConnection() throws Exception {
		return bds.getConnection();
	}
	
	private int getArticleCount() throws Exception {
		String sql = "select count(*) from reportboard";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}
	}

	private int getArticleCountNotYetCheck() throws Exception {
		String sql = "select count(*) from reportboard where check_YN='N'";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}
	}

	private int getArticleCountById(String mem_id) throws Exception {
		String sql = "select count(*) from reportboard where mem_id=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, mem_id);
			try (ResultSet rs = pstat.executeQuery();) {
				rs.next();
				return rs.getInt(1);
			}
		}
	}
	
	public String getPageNavi(int currentPage, String linkURL, String pageType) throws Exception {
		int recordTotalCount = 0;
		if (pageType.contentEquals("entire")) {
			recordTotalCount = this.getArticleCount();
		} else if (pageType.contentEquals("notYetCheck")) {
			recordTotalCount = this.getArticleCountNotYetCheck();
		}

		int pageTotalCount = 0;
		if (recordTotalCount % Configuration.recordCountPerPage > 0) {// 총 글의 개수가 나누어 떨어지지 않을 때
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
	
	
	public String getPageNavi(int currentPage, String linkURL, String pageType, String mem_id) throws Exception {
		int recordTotalCount = 0;
		if (pageType.contentEquals("entire")) {
			recordTotalCount = this.getArticleCount();
		} else if (pageType.contentEquals("byId")) {
			recordTotalCount = this.getArticleCountById(mem_id);
		}

		int pageTotalCount = 0;
		if (recordTotalCount % Configuration.recordCountPerPage > 0) {// 총 글의 개수가 나누어 떨어지지 않을 때
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
	
	
	
	public List<ReportDTO> selectByPageNotYetCheck(int start, int end) throws Exception {//미처리신고글(오래된순)
		String sql = "select * from (select reportboard.*, row_number() over (order by report_seq) article from reportboard where check_YN='N') where article between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, start);
			pstat.setInt(2, end);

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
	
	public List<ReportDTO> selectByPage(int start, int end) throws Exception {
		String sql = "select * from (select reportboard.*, row_number() over (order by report_seq desc) article from reportboard) where article between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, start);
			pstat.setInt(2, end);

			try (ResultSet rs = pstat.executeQuery();) {
				List<ReportDTO> result = new ArrayList<>();
				while (rs.next()) {
					ReportDTO dto = new ReportDTO();
					dto.setReport_seq(rs.getInt("report_seq"));
					dto.setReport_type(rs.getString("report_type"));
					dto.setReview_seq(rs.getInt("review_seq"));
					dto.setMem_id(rs.getString("mem_id"));
					dto.setReport_date(rs.getTimestamp("report_date"));
					dto.setCheck_YN(rs.getString("check_yn"));
					dto.setCheck_date(rs.getTimestamp("check_date"));
					dto.setCheck_type(rs.getString("check_type"));
					result.add(dto);
				}
				return result;
			}
		}
	}
	
	
	
	
	public int insertReport(ReportDTO dto) throws Exception{// 신고글 작성
		String sql = "insert into reportboard values(report_seq.nextval,?,?,?,?,sysdate,'N',null,null,null)";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, dto.getReport_type());
			pstat.setInt(2, dto.getReview_seq());
			pstat.setString(3, dto.getMem_id());
			pstat.setString(4, dto.getContents());
			
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int insertAdminReport(ReportDTO dto) throws Exception{// 신고글 작성
		String sql = "insert into reportboard values(report_seq.nextval,?,?,'admin1',null,sysdate,'Y',?,sysdate,?)";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, dto.getReport_type());
			pstat.setInt(2, dto.getReview_seq());
			pstat.setString(3, dto.getCheck_comments());
			pstat.setString(4, dto.getCheck_type());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int latestAdminReportSeq() throws Exception{
		String sql = "select max(report_seq) from reportboard where mem_id='admin1'";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();
				){
			int result = 0;
			if(rs.next()) {
				result = rs.getInt(1);
			}return result;
		}
		
	}
	
	public List<ReportDTO> selectByPageById(int start, int end, String id) throws Exception{
		String sql = "select * from (select reportboard.*, row_number() over (order by report_seq desc) article from reportboard where mem_id=?) where article between ? and ?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
			){
			pstat.setString(1, id);
			pstat.setInt(2, start);
			pstat.setInt(3, end);
			
			try(ResultSet rs = pstat.executeQuery();){
				List<ReportDTO> result = new ArrayList<>();
				while (rs.next()) {
					ReportDTO dto = new ReportDTO();
					dto.setCheck_comments(rs.getString("check_comments"));
					dto.setCheck_date(rs.getTimestamp("check_date"));
					dto.setCheck_type(rs.getString("check_type"));
					dto.setCheck_YN(rs.getString("check_yn"));
					dto.setContents(rs.getString("contents"));
					dto.setFormedDate(rs.getTimestamp("check_date"));
					dto.setMem_id(rs.getString("mem_id"));
					dto.setReport_date(rs.getTimestamp("report_date"));
					dto.setReport_seq(rs.getInt("report_seq"));
					dto.setReport_type(rs.getString("report_type"));
					dto.setReview_seq(rs.getInt("review_seq"));					
					result.add(dto);
				}
				return result;
			}
		}
	}
	
	
	
	
	
	
	public List<ReportDTO> selectAllReport() throws Exception {// 전체신고글보기(최신순)
		String sql = "select * from reportboard order by report_seq desc";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
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
				dto.setCheck_type(rs.getString("check_type"));
				result.add(dto);
			}
			return result;
		}
	}
	
	public List<ReportDTO> selectNewReport() throws Exception{// 신규 신고글(미처리)보기(먼저 등록된 순으로)
		String sql = "select * from reportboard where check_YN='N' order by report_seq";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();){
			List<ReportDTO> result = new ArrayList<>();
			while(rs.next()) {
				ReportDTO dto = new ReportDTO();
				dto.setReport_seq(rs.getInt("report_seq"));
				dto.setReport_type(rs.getString("report_type"));
				dto.setReview_seq(rs.getInt("review_seq"));
				dto.setMem_id(rs.getString("mem_id"));
				dto.setContents(rs.getString("contents"));
				dto.setReport_date(rs.getTimestamp("report_date"));
				result.add(dto);
			}return result;
		}
	}
	
	public ReportDTO selectReportBySeq(int reportSeq) throws Exception{// 신고글보기
		String sql = "select * from reportboard where report_seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, reportSeq);
			try(ResultSet rs = pstat.executeQuery();){
				ReportDTO result = new ReportDTO();
				if(rs.next()) {
					result.setCheck_comments(rs.getString("check_comments"));
					result.setCheck_date(rs.getTimestamp("check_date"));
					result.setCheck_YN(rs.getString("check_yn"));
					result.setContents(rs.getString("contents"));
					result.setMem_id(rs.getString("mem_id"));
					result.setReport_date(rs.getTimestamp("report_date"));
					result.setReport_type(rs.getString("report_type"));
					result.setReport_seq(rs.getInt("report_seq"));
					result.setReview_seq(rs.getInt("review_seq"));
					result.setCheck_type(rs.getString("check_type"));
					result.setFormedDate(rs.getTimestamp("check_date"));
				}return result;
			}			
		}		
	}
	
	public ReportDTO selectAdminReport(int reviewSeq) throws Exception{
		String sql = "select * from reportboard where review_seq=? and mem_id='admin1'";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, reviewSeq);
			try(ResultSet rs = pstat.executeQuery();){
				ReportDTO result = new ReportDTO();
				if(rs.next()) {
					result.setCheck_comments(rs.getString("check_comments"));
					result.setCheck_date(rs.getTimestamp("check_date"));
					result.setCheck_YN(rs.getString("check_yn"));
					result.setContents(rs.getString("contents"));
					result.setMem_id(rs.getString("mem_id"));
					result.setReport_date(rs.getTimestamp("report_date"));
					result.setReport_type(rs.getString("report_type"));
					result.setReport_seq(rs.getInt("report_seq"));
					result.setReview_seq(rs.getInt("review_seq"));
					result.setCheck_type(rs.getString("check_type"));
					result.setFormedDate(rs.getTimestamp("check_date"));
				}return result;
			}			
		}		
	}
	
	
	public int accumulationReport(int reviewSeq) throws Exception{
		String sql = "select count(*) from reportboard where review_seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, reviewSeq);
			try(ResultSet rs = pstat.executeQuery();){
				int result = 0;
				if(rs.next()) {
					result = rs.getInt(1);
				}return result;
			}
		}
	}
	
	
	public ReportDTO preCheckReport(int reviewSeq) throws Exception{
		String sql = "select * from reportboard where review_seq=? and check_yn = 'Y' order by check_date desc";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, reviewSeq);
			try(ResultSet rs = pstat.executeQuery();){
				ReportDTO result = new ReportDTO();
				if(rs.next()) {
					result.setCheck_comments(rs.getString("check_comments"));
					result.setCheck_date(rs.getTimestamp("check_date"));
					result.setCheck_type(rs.getString("check_type"));
					result.setCheck_YN(rs.getString("check_yn"));
					result.setReport_type(rs.getString("report_type"));
				}return result;
			}
		}
	}
	
	
	
	
	public int checkReport(String checkComments, String checkType, int reportSeq) throws Exception{// 신고글 확인처리
		String sql = "update reportboard set check_YN='Y', check_comments=?, check_date=sysdate, check_type=? where report_seq=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, checkComments);
			pstat.setString(2, checkType);
			pstat.setInt(3, reportSeq);
			
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int makeReviewNonBlindBySeq(int reviewSeq) throws Exception{
		String sql = "update reviewboard set blind_yn='N' where review_seq=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, reviewSeq);
			
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int makeReviewBlindBySeq(int reviewSeq) throws Exception{
		String sql = "update reviewboard set blind_yn='Y' where review_seq=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, reviewSeq);
			
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int makeReviewDeleteBySeq(int reviewSeq) throws Exception{
		String sql = "delete reviewboard where review_seq=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, reviewSeq);
			
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
}
