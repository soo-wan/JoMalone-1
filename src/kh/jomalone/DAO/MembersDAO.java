package kh.jomalone.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.jomalone.DTO.MembersDTO;
import kh.jomalone.DTO.NMembersDTO;

public class MembersDAO {
	private static MembersDAO instance; 
	private BasicDataSource bds = new BasicDataSource();

	private MembersDAO() {
		bds.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		bds.setUrl("jdbc:oracle:thin:@localhost:1521:xe");

		bds.setUsername("jomalone");
		bds.setPassword("jomalone");
		bds.setInitialSize(10);
	}

	public synchronized static MembersDAO getInstance(){ 
		if(instance == null) {
			instance = new MembersDAO(); 
		}
		return instance; 
	} 
	public Connection getConnection()  throws Exception {
		return bds.getConnection();
	}
	
	
	public boolean isIdExist (String id) throws Exception {
		String sql = "select * from Members where mem_id = ?";
		try(
		Connection con = this.getConnection();
		PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, id);
			try(
				ResultSet rs = pstat.executeQuery();
				){
				return rs.next();
				
				
			}
		}
	};

	public int signup (MembersDTO dto) throws Exception {
		String sql = "insert into members values(?,'normal',null,?,?,?,?,?,?,?,?,?,sysdate,null,null,?,?)";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, dto.getId());
			pstat.setString(2, dto.getPw());
			pstat.setString(3, dto.getName());
				String phone = dto.getPhone1()+dto.getPhone2()+dto.getPhone3();
			pstat.setString(4, phone);
				String email = dto.getEmail1()+dto.getEmail2();
			pstat.setString(5, email);
			pstat.setString(6, dto.getZip_code());
			pstat.setString(7, dto.getAddress1());
			pstat.setString(8, dto.getAddress2());
				String birth = dto.getYear()+dto.getMonth()+dto.getDay();
			pstat.setString(9, birth);
			pstat.setString(10, dto.getGender());
			pstat.setString(11, dto.getAgree_s());
			pstat.setString(12, dto.getAgree_p());

			int result = pstat.executeUpdate();
			return result;
		}
	}
	

	public boolean login(String id , String pw) throws Exception {
		String sql = "select * from members where mem_id =? and mem_pw = ?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, id);
			pstat.setString(2, pw);
			try(
					ResultSet rs = pstat.executeQuery();
					){
				return rs.next();
			}
		}
	}
	
	//네이버로그인
	public int NFirstLogin (NMembersDTO ndto) throws Exception {
		String sql = "insert into members (mem_id, logintype, mem_name, mem_email, mem_birth, mem_gender) values(?,'naver',?,?,?,?)";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, ndto.getId());
			pstat.setString(2, ndto.getName());
			pstat.setString(3, ndto.getEmail());
			pstat.setString(4, ndto.getBirth());
			pstat.setString(5, ndto.getGender());

			int result = pstat.executeUpdate();
			return result;
		}
	}
	public boolean Nlogin(String id) throws Exception {
		String sql = "select * from members where mem_id =?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, id);
			
			try(
					ResultSet rs = pstat.executeQuery();
					){
				return rs.next();
			}
		}
	}
	
	public String findAccess_token(String id) throws Exception {
		String sql = "select access_token from members where mem_id =?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, id);
			
			try(
					ResultSet rs = pstat.executeQuery();
					){
				if(rs.next()) {
					NMembersDTO ndto = new NMembersDTO();
					String firstaccess_token = rs.getString(1);
					return firstaccess_token;
				}
				return null;
			}
		}
	}
	
	
	
	//카카오로그인
	public int KFirstLogin (NMembersDTO ndto) throws Exception {
		String sql = "insert into members (mem_id, logintype, mem_name, mem_email, mem_birth, mem_gender) values(?,'kakao',?,?,?,?)";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, ndto.getId());
			pstat.setString(2, ndto.getName());
			pstat.setString(3, ndto.getEmail());
			pstat.setString(4, ndto.getBirth());
			pstat.setString(5, ndto.getGender());

			int result = pstat.executeUpdate();
			return result;
		}
	}
	public boolean Klogin(String id) throws Exception {
		String sql = "select * from members where mem_id =?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, id);
			
			try(
					ResultSet rs = pstat.executeQuery();
					){
				return rs.next();
			}
		}
	}

	

	

	
	
}