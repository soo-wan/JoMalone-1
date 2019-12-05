package kh.jomalone.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.jomalone.configuration.Configuration;
import kh.jomalone.DTO.ReviewDTO;

public class ReviewDAO {
	private static ReviewDAO instance;
	private BasicDataSource bds = new BasicDataSource();

	private ReviewDAO() {
		bds.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		bds.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		bds.setUsername("jomalone");
		bds.setPassword("jomalone");
		bds.setInitialSize(30);
	}

	public synchronized static ReviewDAO getInstance() {
		if (instance == null) {
			instance = new ReviewDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		return bds.getConnection();
	}

	private int getArticleCount() throws Exception {
		String sql = "select count(*) from reviewboard";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}
	}

	private int getArticleCountById(String mem_id) throws Exception {
		String sql = "select count(*) from reviewboard where mem_id=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, mem_id);
			try (ResultSet rs = pstat.executeQuery();) {
				rs.next();
				return rs.getInt(1);
			}
		}
	}


	
	
	public String getPageNavi(int currentPage, String linkURL, String pageType, String mem_id) throws Exception {
		int recordTotalCount = 0;
		if (pageType.contentEquals("admin")) {
			recordTotalCount = this.getArticleCount();
		} else if (pageType.contentEquals("member")) {
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

	public List<ReviewDTO> selectByPage(int start, int end) throws Exception {
		String sql = "select * from (select reviewboard.*, row_number() over (order by review_seq desc) article from reviewboard) where article between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, start);
			pstat.setInt(2, end);

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

	public List<ReviewDTO> selectByPageById(int start, int end, String id) throws Exception {
		String sql = "select * from (select reviewboard.*, row_number() over (order by review_seq desc) article from reviewboard where mem_id=?) where article between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, id);
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

	public int insertReview(ReviewDTO dto) throws Exception {// 리뷰 작성
		String sql = "insert into reviewboard values(review_seq.nextval,?,?,?,?,?,?,sysdate,'N')";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, dto.getOrder_seq());
			pstat.setString(2, dto.getProd_name());
			pstat.setString(3, dto.getMem_id());
			pstat.setString(4, dto.getTitle());
			pstat.setString(5, dto.getContents());
			pstat.setInt(6, dto.getGrade());

			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public int updateReview(ReviewDTO dto) throws Exception {// 리뷰 수정
		String sql = "update reviewboard set title=?,contents=?,grade=? where review_seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, dto.getTitle());
			pstat.setString(2, dto.getContents());
			pstat.setInt(3, dto.getGrade());
			pstat.setInt(4, dto.getReview_seq());

			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public int deleteReview(int reviewSeq) throws Exception {// 리뷰 삭제
		String sql = "delete from reviewboard where review_seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, reviewSeq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public List<ReviewDTO> selectAllReviewById(String mem_id) throws Exception {// 나의 리뷰글 내역보기
		String sql = "select * from reviewboard where mem_id=? order by review_seq desc";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, mem_id);
			try (ResultSet rs = pstat.executeQuery();) {
				List<ReviewDTO> result = new ArrayList<>();
				while (rs.next()) {
					ReviewDTO dto = new ReviewDTO();
					dto.setReview_seq(rs.getInt("review_seq"));
					dto.setOrder_seq(rs.getInt("order_seq"));
					dto.setProd_name(rs.getString("prod_name"));
					dto.setTitle(rs.getString("title"));
					dto.setContents(rs.getString("contents"));
					dto.setGrade(rs.getInt("grade"));
					dto.setWrite_date(rs.getTimestamp("write_date"));
					result.add(dto);
				}
				return result;
			}
		}
	}

	public int findLatestReviewSeqById(String mem_id) throws Exception {// 작성자의 가장최근 리뷰글번호 찾기
		String sql = "select max(review_seq) from reviewboard where mem_id=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, mem_id);
			try (ResultSet rs = pstat.executeQuery();) {
				int result = 0;
				if (rs.next()) {
					result = rs.getInt(1);
				}
				return result;
			}
		}
	}

	public ReviewDTO selectReviewBySeq(int review_seq) throws Exception {// 리뷰글 보기(리뷰글 번호로)
		String sql = "select * from reviewboard where review_seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, review_seq);
			try (ResultSet rs = pstat.executeQuery();) {
				ReviewDTO result = new ReviewDTO();
				if (rs.next()) {
					result.setReview_seq(rs.getInt("review_seq"));
					result.setOrder_seq(rs.getInt("order_seq"));
					result.setProd_name(rs.getString("prod_name"));
					result.setTitle(rs.getString("title"));
					result.setContents(rs.getString("contents"));
					result.setGrade(rs.getInt("grade"));
					result.setMem_id(rs.getString("mem_id"));
					result.setWrite_date(rs.getTimestamp("write_date"));
					result.setBlind_yn(rs.getString("blind_yn"));
				}
				return result;
			}
		}
	}

	public List<ReviewDTO> selectAllReviewExceptBlind() throws Exception {// 전체리뷰글보기(블라인드된것 제외. 실제 리뷰페이지에서 보이는거.)
		String sql = "select * from reviewboard where blind_YN = 'N' order by review_seq desc";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			List<ReviewDTO> result = new ArrayList<>();
			while (rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				dto.setReview_seq(rs.getInt("review_seq"));
				dto.setOrder_seq(rs.getInt("order_seq"));
				dto.setProd_name(rs.getString("prod_name"));
				dto.setTitle(rs.getString("title"));
				dto.setContents(rs.getString("contents"));
				dto.setGrade(rs.getInt("grade"));
				dto.setWrite_date(rs.getTimestamp("write_date"));
				result.add(dto);
			}
			return result;
		}
	}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	public List<ReviewDTO> selectAllReview() throws Exception {// 전체리뷰글보기(블라인드여부상관없이)
		String sql = "select * from reviewboard order by review_seq desc";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			List<ReviewDTO> result = new ArrayList<>();
			while (rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				dto.setReview_seq(rs.getInt("review_seq"));
				dto.setOrder_seq(rs.getInt("order_seq"));
				dto.setProd_name(rs.getString("prod_name"));
				dto.setTitle(rs.getString("title"));
				dto.setContents(rs.getString("contents"));
				dto.setGrade(rs.getInt("grade"));
				dto.setWrite_date(rs.getTimestamp("write_date"));
				result.add(dto);
			}
			return result;
		}
	}

	public int makeReviewBlind(int reviewSeq) throws Exception {// 신고리뷰글 블라인드처리 (관리자)
		String sql = "update reviewboard set blind_YN = 'Y' where review_seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, reviewSeq);

			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	
	public boolean isPossibleToWriteReview(int order_seq) throws Exception{
		String sql = "select * from reviewboard where order_seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, order_seq);
			try(ResultSet rs = pstat.executeQuery();){
				boolean result = !rs.next();
				return result;
			}
		}
	}

}
