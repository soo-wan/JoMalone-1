package kh.jomalone.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.jomalone.DTO.NoticeDTO;
import kh.jomalone.configuration.Configuration;

public class NoticeDAO {
	private static NoticeDAO instance;
	private BasicDataSource bds = new BasicDataSource();
	
	private NoticeDAO() {
		bds.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		bds.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		bds.setUsername("jomalone");
		bds.setPassword("jomalone");
		bds.setInitialSize(30);
	}
	
	public synchronized static NoticeDAO getInstance() {
		if(instance==null) {
			instance = new NoticeDAO();
		}
		return instance;
	}
	
	private Connection getConnection() throws Exception {
		return bds.getConnection();
	}
	
	private int getArticleCount() throws Exception {
		String sql = "select count(*) from noticeboard";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}
	}
	
	public String getPageNavi(int currentPage) throws Exception {
		int recordTotalCount = this.getArticleCount();
		
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
			sb.append("<a href='list.notice?currentPage=" + (startNavi - 1) + "'>< </a>");
		}
		for (int i = startNavi; i <= endNavi; i++) {
			sb.append("<a href='list.notice?currentPage=" + i + "'>");
			sb.append(i);
			sb.append("</a> ");
		}
		if (needNext) {
			sb.append("<a href='list.notice?currentPage=" + (endNavi + 1) + "'>></a>");
		}
		return sb.toString();
	}
	
	
	public List<NoticeDTO> selectByPage(int start, int end) throws Exception {
		String sql = "select * from (select noticeboard.*, row_number() over (order by notice_seq desc) article from noticeboard) where article between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, start);
			pstat.setInt(2, end);

			try (ResultSet rs = pstat.executeQuery();) {
				List<NoticeDTO> result = new ArrayList<>();
				while (rs.next()) {
					NoticeDTO dto = new NoticeDTO();
					dto.setContents(rs.getString("contents"));
					dto.setNotice_seq(rs.getInt("notice_seq"));
					dto.setTitle(rs.getString("title"));
					dto.setWrite_date(rs.getTimestamp("write_date"));
					result.add(dto);
				}
				return result;
			}
		}
	}
	
	public int insertNotice(NoticeDTO dto) throws Exception{
		String sql = "insert into noticeboard values(notice_seq.nextval,?,?,sysdate)";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, dto.getTitle());
			pstat.setString(2, dto.getContents());
			
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int updateNotice(NoticeDTO dto) throws Exception{
		String sql = "update noticeboard set title=?,contents=? where notice_seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, dto.getTitle());
			pstat.setString(2, dto.getContents());
			pstat.setInt(3, dto.getNotice_seq());
			
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int deleteNotice(int notice_seq) throws Exception{
		String sql = "delete from noticeboard where notice_seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, notice_seq);
			
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public NoticeDTO selectNotice(int notice_seq) throws Exception{
		String sql = "select * from noticeboard where notice_seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, notice_seq);
			
			try(ResultSet rs = pstat.executeQuery();){
				NoticeDTO result = new NoticeDTO();
				if(rs.next()) {
					result.setContents(rs.getString("contents"));
					result.setNotice_seq(rs.getInt("notice_seq"));
					result.setTitle(rs.getString("title"));
					result.setWrite_date(rs.getTimestamp("write_date"));
				}return result;
			}			
		}
	}
	
	public List<NoticeDTO> selectAllNotice() throws Exception{
		String sql = "select * from noticeboard";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);ResultSet rs = pstat.executeQuery();) {
			List<NoticeDTO> result = new ArrayList<>();
			while(rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setContents(rs.getString("contents"));
				dto.setNotice_seq(rs.getInt("notice_seq"));
				dto.setTitle(rs.getString("title"));
				dto.setWrite_date(rs.getTimestamp("write_date"));
				result.add(dto);
			}return result;
		}
	}
	
	public int findLatestNotice() throws Exception{
		String sql = "select max(notice_seq) from noticeboard";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);ResultSet rs = pstat.executeQuery();) {
			int result = 0;
			if(rs.next()) {
				result=rs.getInt(1);
			}return result;
		}
	}
	
	public List<NoticeDTO> latestNotices() throws Exception{
		String sql = "SELECT title,notice_seq FROM noticeboard WHERE ROWNUM <= 4 order by notice_seq desc";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);ResultSet rs = pstat.executeQuery();) {
			List<NoticeDTO> result = new ArrayList<>();
			while(rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setTitle(rs.getString("title"));
				dto.setNotice_seq(rs.getInt("notice_seq"));
				result.add(dto);
			}return result;
		}
	}
}
