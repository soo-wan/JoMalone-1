package kh.jomalone.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.jomalone.DTO.AskCommentsDTO;
import kh.jomalone.DTO.AskDTO;
import kh.jomalone.configuration.Configuration;

public class AskDAO {
	private static AskDAO instance;
	private BasicDataSource bds = new BasicDataSource();

	private AskDAO() {
		bds.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		bds.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		bds.setUsername("jomalone");
		bds.setPassword("jomalone");
		bds.setInitialSize(30);
	}

	public synchronized static AskDAO getInstance() {
		if (instance == null) {
			instance = new AskDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		return bds.getConnection();
	}
	
	
	
	
	public List<AskDTO> selectByPageNotYetAnswer(int start, int end) throws Exception{
		String sql = "select * from (select askboard.*, row_number() over (order by ask_seq) article from askboard where answer_YN = 'N') where article between ? and ?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
			){
			pstat.setInt(1, start);
			pstat.setInt(2, end);
			
			try(ResultSet rs = pstat.executeQuery();){
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
	
	
	public List<AskDTO> selectByPageById(int start, int end, String id) throws Exception{
		String sql = "select * from (select askboard.*, row_number() over (order by ask_seq desc) article from askboard where mem_id=?) where article between ? and ?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
			){
			pstat.setString(1, id);
			pstat.setInt(2, start);
			pstat.setInt(3, end);
			
			try(ResultSet rs = pstat.executeQuery();){
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
	
	public List<AskDTO> selectByPage(int start, int end) throws Exception{
		String sql = "select * from (select askboard.*, row_number() over (order by ask_seq desc) article from askboard) where article between ? and ?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
			){
			pstat.setInt(1, start);
			pstat.setInt(2, end);
			
			try(ResultSet rs = pstat.executeQuery();){
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
	
	private int getArticleCountById(String mem_id) throws Exception{
		String sql = "select count(*) from askboard where mem_id=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, mem_id);
			try(ResultSet rs = pstat.executeQuery();){
			rs.next();
			return rs.getInt(1);
		}
	}
	}
	
	private int getArticleCountNotYetAnswer() throws Exception{
		String sql = "select count(*) from askboard where answer_YN = 'N'";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();
				){
			rs.next();
			return rs.getInt(1);
		}
	}
	
	private int getArticleCount() throws Exception{
		String sql = "select count(*) from askboard";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();
				){
			rs.next();
			return rs.getInt(1);
		}
	}
	
	public String getPageNavi(int currentPage, String linkURL, String pageType, String mem_id) throws Exception {
		int recordTotalCount = 0;
		if(pageType.contentEquals("entire")) {
			recordTotalCount = this.getArticleCount();
		}else if(pageType.contentEquals("notYetAnswer")) {
			recordTotalCount = this.getArticleCountNotYetAnswer();
		}else if(pageType.contentEquals("byId")) {
			recordTotalCount = this.getArticleCountById(mem_id);
		}
		
		int pageTotalCount = 0;
		if(recordTotalCount%Configuration.recordCountPerPage>0) {//총 글의 개수가 나누어 떨어지지 않을 때
			pageTotalCount = recordTotalCount/Configuration.recordCountPerPage + 1;
		}else {
			pageTotalCount = recordTotalCount/Configuration.recordCountPerPage;
		}
		if(currentPage<1) {
			currentPage = 1;
		}else if(currentPage>pageTotalCount) {
			currentPage = pageTotalCount;
		}
		
		int startNavi = (currentPage - 1) / Configuration.naviCountPerPage * Configuration.naviCountPerPage + 1;
		int endNavi = startNavi + (Configuration.naviCountPerPage-1);
		
		if(endNavi>pageTotalCount) {
			endNavi = pageTotalCount;
		}
		
		boolean needPrev = true;
		boolean needNext = true;
		
		if(startNavi==1) {
			needPrev = false;
		}
		if(endNavi==pageTotalCount) {
			needNext = false;
		}
		
		StringBuilder sb = new StringBuilder();
		if(needPrev) {sb.append("<a href='"+linkURL+"?currentPage="+(startNavi-1)+"'>< </a>");}
		for(int i=startNavi;i<=endNavi;i++) {
			sb.append("<a href='"+linkURL+"?currentPage="+i+"'>");
			sb.append(i);
			sb.append("</a> ");
		}
		if(needNext) {sb.append("<a href='"+linkURL+"?currentPage="+(endNavi+1)+"'>></a>");}
		return sb.toString();
	}
	
	
	
	
	
	public int insertAsk(AskDTO dto) throws Exception {// 문의글 작성
		String sql = "insert into askboard values(ask_seq.nextval,?,?,?,?,'N',sysdate,?)";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, dto.getAsk_code());
			pstat.setString(2, dto.getTitle());
			pstat.setString(3, dto.getContents());
			pstat.setString(4, dto.getMem_id());
			pstat.setString(5, dto.getEmail_yn());

			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int updateAsk(AskDTO dto) throws Exception {// 문의글 수정
		String sql = "update askboard set ask_code=?,title=?,contents=?,email_YN=? where ask_seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, dto.getAsk_code());
			pstat.setString(2, dto.getTitle());
			pstat.setString(3, dto.getContents());
			pstat.setString(4, dto.getEmail_yn());
			pstat.setInt(5, dto.getAsk_seq());
			
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int deleteAsk(int askSeq) throws Exception {// 문의글 삭제
		String sql = "delete from askboard where ask_seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, askSeq);			
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public List<AskDTO> selectAllAskById(String mem_id) throws Exception {// 나의 문의글 내역보기(최신순)
		String sql = "select * from askboard where mem_id=? order by ask_seq desc";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, mem_id);
			try (ResultSet rs = pstat.executeQuery();) {
				List<AskDTO> result = new ArrayList<>();
				while (rs.next()) {
					AskDTO dto = new AskDTO();
					dto.setAsk_seq(rs.getInt("ask_seq"));
					dto.setAsk_code(rs.getString("ask_code"));
					dto.setTitle(rs.getString("title"));
					dto.setContents(rs.getString("contents"));
					dto.setMem_id(rs.getString("mem_id"));
					dto.setAnswer_yn(rs.getString("answer_yn"));
					dto.setWrite_date(rs.getTimestamp("write_date"));
					dto.setEmail_yn(rs.getString("email_yn"));
					result.add(dto);
				}
				return result;
			}
		}
	}

	public int findLatestAskSeqById(String mem_id) throws Exception {// 작성자의 가장최근 문의글 번호찾기
		String sql = "select max(ask_seq) from askboard where mem_id=?";
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

	public AskDTO selectAskBySeq(int ask_seq) throws Exception {// 문의글 보기(문의글 번호로)
		String sql = "select * from askboard where ask_seq=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, ask_seq);
			try (ResultSet rs = pstat.executeQuery();) {
				AskDTO result = new AskDTO();
				if (rs.next()) {
					result.setAsk_seq(rs.getInt("ask_seq"));
					result.setAsk_code(rs.getString("ask_code"));
					result.setTitle(rs.getString("title"));
					result.setContents(rs.getString("contents"));
					result.setMem_id(rs.getString("mem_id"));
					result.setAnswer_yn(rs.getString("answer_yn"));
					result.setWrite_date(rs.getTimestamp("write_date"));
					result.setEmail_yn(rs.getString("email_yn"));
				}
				return result;
			}
		}
	}

	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	public List<AskDTO> selectAllAsk() throws Exception {// 전체문의글보기(관리자)
		String sql = "select * from askboard order by ask_seq desc";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			List<AskDTO> result = new ArrayList<>();
			while (rs.next()) {
				AskDTO dto = new AskDTO();
				dto.setAsk_seq(rs.getInt("ask_seq"));
				dto.setAsk_code(rs.getString("ask_code"));
				dto.setTitle(rs.getString("title"));
				dto.setContents(rs.getString("contents"));
				dto.setMem_id(rs.getString("mem_id"));
				dto.setAnswer_yn(rs.getString("answer_yn"));
				dto.setWrite_date(rs.getTimestamp("write_date"));
				dto.setEmail_yn(rs.getString("email_yn"));
				result.add(dto);
			}
			return result;
		}
	}
	
	public List<AskDTO> selectNewAsk() throws Exception {// 신규(미답변)문의글보기(먼저등록된순으로)(관리자)
		String sql = "select * from askboard where answer_YN = 'N' order by ask_seq";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			List<AskDTO> result = new ArrayList<>();
			while (rs.next()) {
				AskDTO dto = new AskDTO();
				dto.setAsk_seq(rs.getInt("ask_seq"));
				dto.setAsk_code(rs.getString("ask_code"));
				dto.setTitle(rs.getString("title"));
				dto.setContents(rs.getString("contents"));
				dto.setMem_id(rs.getString("mem_id"));
				dto.setWrite_date(rs.getTimestamp("write_date"));
				dto.setEmail_yn(rs.getString("email_yn"));
				result.add(dto);
			}
			return result;
		}
	}
	
	public int AnswerAskCondition(String yn, int ask_seq) throws Exception{// 문의글답변완료/미완료변경처리(관리자)
		String sql = "update askboard set answer_yn=? where ask_seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, yn);
			pstat.setInt(2, ask_seq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int insertAskComment(AskCommentsDTO dto) throws Exception{// 문의글답변(댓글)등록(관리자)
		String sql = "insert into askcomments values(askco_seq.nextval,?,?,sysdate)";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, dto.getAsk_seq());
			pstat.setString(2, dto.getContents());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int updateAskComment(String contents, int coSeq) throws Exception{// 문의글답변(댓글)수정(관리자)
		String sql = "update askcomments set contents=? where co_seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, contents);
			pstat.setInt(2, coSeq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int deleteAskComment(int coSeq) throws Exception{// 문의글답변(댓글)삭제(관리자)
		String sql = "delete from askcomments where co_seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, coSeq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public List<AskCommentsDTO> selectCommentsByAskSeq(int askSeq) throws Exception{// 답변목록확인.
		String sql = "select * from askcomments where ask_seq=? order by co_seq";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				
				){
			pstat.setInt(1, askSeq);
			try(ResultSet rs = pstat.executeQuery();){
				List<AskCommentsDTO> result = new ArrayList<>();
				while(rs.next()) {
					AskCommentsDTO dto = new AskCommentsDTO();
					dto.setAsk_seq(rs.getInt("ask_seq"));
					dto.setCo_seq(rs.getInt("co_seq"));
					dto.setContents(rs.getString("contents"));
					dto.setWrite_date(rs.getTimestamp("write_date"));
					dto.setFormedFullDate(rs.getTimestamp("write_date"));
					result.add(dto);
				}return result;				
			}
		}
	}
	
	public AskCommentsDTO selectCommentByCoSeq(int coSeq) throws Exception{
		String sql = "select * from askcomments where co_seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, coSeq);
			try(
					ResultSet rs = pstat.executeQuery();
					){
				AskCommentsDTO result = new AskCommentsDTO();
				if(rs.next()) {
					result.setContents(rs.getString("contents"));
				}return result;
			}
		}
	}
	
	public List<String> findMemNameEmailById(String memId) throws Exception{
		String sql = "select mem_name, mem_email from members where mem_id=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, memId);
			try(ResultSet rs = pstat.executeQuery();){
				List<String> result = new ArrayList<>();
				if(rs.next()) {
					result.add(rs.getString("mem_name"));
					result.add(rs.getString("mem_email"));
				}return result;
			}
		}
	}
	
	
	///////////////////////////////////////////////////////////////////////////////////////////
	
	
	//신규문의글 검색
	public List<AskDTO> selectByPageNotYetAnswerBySearch(int start, int end, String column, String target) throws Exception{
		String sql = "select * from (select askboard.*, row_number() over (order by ask_seq) article from askboard where answer_YN = 'N' and "+column+"=?) where article between ? and ?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
			){
			pstat.setString(1, target);
			pstat.setInt(2, start);
			pstat.setInt(3, end);
			
			try(ResultSet rs = pstat.executeQuery();){
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
	
	
	//전체문의글 검색
	public List<AskDTO> selectByPageBySearch(int start, int end, String column, String target) throws Exception{
		String sql = "select * from (select askboard.*, row_number() over (order by ask_seq desc) article from askboard where "+column+"=?) where article between ? and ?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
			){
			pstat.setString(1, target);
			pstat.setInt(2, start);
			pstat.setInt(3, end);
			
			try(ResultSet rs = pstat.executeQuery();){
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
	
	
	
	
	
	
}
