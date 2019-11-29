package kh.jomalone.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

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
	
	//아이디 중복확인
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
	//일반회원 회원가입
	public int signup (MembersDTO dto) throws Exception {
		String sql = "insert into members values(?,'normal',?,?,?,?,?,?,?,?,?,sysdate,null,null,?,?)";
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
	
	//일반회원 로그인
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
	//일반회원 탈퇴
	public int delete(String id)throws Exception {
		String sql = "delete members where mem_id = ?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, id);
			

			int result = pstat.executeUpdate();
			return result;
		}
	}
	
	public List<MembersDTO> selectAll() throws Exception{
		String sql = "select * from members";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
				try(
					ResultSet rs = pstat.executeQuery();
					){
					List<MembersDTO> list = new ArrayList<>();
				while(rs.next()) {
					String id = rs.getString(1);
					String logintype = rs.getString(2);
					String pw = rs.getString(3);
					String name =rs.getString(4);
					String phone =rs.getString(5);
					String email =rs.getString(6);
					String zip_code=rs.getString(7);
					String address1=rs.getString(8);
					String address2=rs.getString(9);
					String birth=rs.getString(10);
					String gender=rs.getString(11);
					Timestamp enrolldate =rs.getTimestamp(12);
					String del_yn=rs.getString(13);
					Timestamp deletedate=rs.getTimestamp(14);
					String agree_s=rs.getString(15);
					String agree_p=rs.getString(16);
					MembersDTO dto = new MembersDTO(id,logintype,pw,name,phone,email,zip_code,
							address1,address2,birth,gender,enrolldate,del_yn,deletedate,agree_s,agree_p);
					list.add(dto);
					return list;	
				}
				return null; 
			}
		}
	}
	//네이버 처음로그인  - db저장
	public int naverFirLogin (NMembersDTO ndto) throws Exception {
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
	
	//카카오 처음로그인 - db저장
	public int kakaoFirLogin (NMembersDTO ndto) throws Exception {
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
	
	//첫 로그인 이후 로그인.
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
	
	//id에 맞는 비번찾기.
	public String checkpw(String id)throws Exception {
		String sql = "select mem_pw from members where mem_id=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, id);
			try(
					ResultSet rs = pstat.executeQuery();
					){
				if(rs.next()) {
					String pw = rs.getString(1);
					return pw;
				}
				return null;
			}
		}
	}
	
	//아이디에 맞는 정보 가져오기.
	public MembersDTO selectById(String loginInfo) throws Exception {
		String sql = "select * from members where mem_id = ?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, loginInfo);
			try(
			ResultSet rs = pstat.executeQuery();
					){
				if(rs.next()) {
					String id = rs.getString(1);
					String logintype = rs.getString(2);
					String pw = rs.getString(3);
					String name =rs.getString(4);
					String phone =rs.getString(5);
					String email =rs.getString(6);
					String zip_code=rs.getString(7);
					String address1=rs.getString(8);
					String address2=rs.getString(9);
					String birth=rs.getString(10);
					String gender=rs.getString(11);
					Timestamp enrolldate =rs.getTimestamp(12);
					String del_yn=rs.getString(13);
					Timestamp deletedate=rs.getTimestamp(14);
					String agree_s=rs.getString(15);
					String agree_p=rs.getString(16);
					MembersDTO dto = new MembersDTO(id,logintype,pw,name,phone,email,zip_code,
							address1,address2,birth,gender,enrolldate,del_yn,deletedate,agree_s,agree_p);
					return dto;
				}
				return null;
			}
		}
	}
	//이름과 핸드폰번호가 일치하는 아이디 가져오기
	public String findid(String name, String phone)throws Exception {
		String sql = "select mem_id from members where mem_name=? and mem_phone=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, name);
			pstat.setString(2, phone);
			try(
					ResultSet rs = pstat.executeQuery();
					){
				if(rs.next()) {
					String id = rs.getString(1);
					
					return id;
				}
				return null;
			}
		}
	}
	//존재하는 이메일인가?
	public boolean isEmailExist(String email)throws Exception {
		String sql = "select * from members where mem_email = ?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, email);
			
			try(
					ResultSet rs = pstat.executeQuery();
					){
				return rs.next();
			}
		}
	}
	//임시비밀번호 변경
	public int changePw(String tempPw, String id, String email)throws Exception{
		String sql = "update members set mem_pw =? where mem_id=? and mem_email=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, tempPw);
			pstat.setString(2, id);
			pstat.setString(3, email);
			
			int result = pstat.executeUpdate();
			return result;
		}
		
	}

	

	
	
}