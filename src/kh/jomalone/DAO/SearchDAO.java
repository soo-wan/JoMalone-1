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

public class SearchDAO {
	private static SearchDAO instance;
	private static BasicDataSource bds = new BasicDataSource();

	private SearchDAO() {
		bds.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		bds.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		bds.setUsername("jomalone");
		bds.setPassword("jomalone");
		bds.setInitialSize(50);
	}

	public synchronized static SearchDAO getInstance() {
		if (instance == null) {
			instance = new SearchDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		return bds.getConnection();
	}
	
	public List<AskDTO> searchAskBoardByTitle (String title) throws Exception {
		List<AskDTO> list = new ArrayList<>();
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("select * from AskBoard where title like '%' || ? || '%'")) {
				pstat.setString(1, title);
				ResultSet rs = pstat.executeQuery();
				while(rs.next()) {
					list.add(new AskDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getTimestamp(7),rs.getString(8)));
				}
		}
		return list;
	}
	public List<AskDTO> searchAskBoardByContents (String contents) throws Exception {
		List<AskDTO> list = new ArrayList<>();
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("select * from AskBoard where contents like '%' || ? || '%'")) {
				pstat.setString(1, contents);
				ResultSet rs = pstat.executeQuery();
				while(rs.next()) {
					list.add(new AskDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getTimestamp(7),rs.getString(8)));
				}
		}
		return list;
	}
	public List<AskDTO> searchAskBoardByMemID (String memID) throws Exception {
		List<AskDTO> list = new ArrayList<>();
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("select * from AskBoard where mem_ID like '%' || ? || '%'")) {
				pstat.setString(1, memID);
				ResultSet rs = pstat.executeQuery();
				while(rs.next()) {
					list.add(new AskDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getTimestamp(7),rs.getString(8)));
				}
		}
		return list;
	}
	public List<ReviewDTO> searchReviewBoardByProdName (String prodName) throws Exception {
		List<ReviewDTO> list = new ArrayList<>();
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("select * from ReviewBoard where prod_name like '%' || ? || '%'")) {
				pstat.setString(1, prodName);
				ResultSet rs = pstat.executeQuery();
				while(rs.next()) {
					list.add(new ReviewDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getInt(7),rs.getTimestamp(8),rs.getString(9)));
				}
		}
		return list;
	}
	public List<ReviewDTO> searchReviewBoardByTitle (String Title) throws Exception {
		List<ReviewDTO> list = new ArrayList<>();
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("select * from ReviewBoard where Title like '%' || ? || '%'")) {
				pstat.setString(1, Title);
				ResultSet rs = pstat.executeQuery();
				while(rs.next()) {
					list.add(new ReviewDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getInt(7),rs.getTimestamp(8),rs.getString(9)));
				}
		}
		return list;
	}
	public List<ReviewDTO> searchReviewBoardByContents (String contents) throws Exception {
		List<ReviewDTO> list = new ArrayList<>();
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("select * from ReviewBoard where contents like '%' || ? || '%'")) {
				pstat.setString(1, contents);
				ResultSet rs = pstat.executeQuery();
				while(rs.next()) {
					list.add(new ReviewDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getInt(7),rs.getTimestamp(8),rs.getString(9)));
				}
		}
		return list;
	}
	public List<ReviewDTO> searchReviewBoardByMemID (String memID) throws Exception {
		List<ReviewDTO> list = new ArrayList<>();
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("select * from ReviewBoard where mem_id like '%' || ? || '%'")) {
				pstat.setString(1, memID);
				ResultSet rs = pstat.executeQuery();
				while(rs.next()) {
					list.add(new ReviewDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getInt(7),rs.getTimestamp(8),rs.getString(9)));
				}
		}
		return list;
	}
	public List<ReportDTO> searchReportBoardByMemID (String memID) throws Exception {
		List<ReportDTO> list = new ArrayList<>();
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("select * from ReportBoard where mem_id like '%' || ? || '%'")) {
				pstat.setString(1, memID);
				ResultSet rs = pstat.executeQuery();
				while(rs.next()) {
					list.add(new ReportDTO(rs.getInt(1),rs.getString(2),rs.getInt(3),rs.getString(4),rs.getString(5),rs.getTimestamp(6),rs.getString(7),rs.getString(8),rs.getTimestamp(9),rs.getString(10)));
				}
		}
		return list;
	}
	public List<ReportDTO> searchReportBoardByContents (String contents) throws Exception {
		List<ReportDTO> list = new ArrayList<>();
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("select * from ReportBoard where contents like '%' || ? || '%'")) {
				pstat.setString(1, contents);
				ResultSet rs = pstat.executeQuery();
				while(rs.next()) {
					list.add(new ReportDTO(rs.getInt(1),rs.getString(2),rs.getInt(3),rs.getString(4),rs.getString(5),rs.getTimestamp(6),rs.getString(7),rs.getString(8),rs.getTimestamp(9),rs.getString(10)));
				}
		}
		return list;
	}
}






