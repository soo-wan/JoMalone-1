package kh.jomalone.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.jomalone.DTO.MembersDTO;

public class OrderDAO {
	private static OrderDAO instance;
	private static BasicDataSource bds = new BasicDataSource();
	private OrderDAO() {
		bds.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		bds.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		bds.setUsername("jomalone");
		bds.setPassword("jomalone");
		bds.setInitialSize(30);
	}
	public synchronized static OrderDAO getInstance() {
		if(instance == null) {
			instance = new OrderDAO();
		}
		return instance;
	}
	private Connection getConnection() throws Exception{
		return bds.getConnection();
	}
	
	public MembersDTO selectMember(String mem_id) throws Exception{ // 체크시 member 정보
		String sql = "select * from members where mem_id=?";
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, mem_id);
				try(
					ResultSet rs = pstat.executeQuery();
					){
				MembersDTO dto = new MembersDTO();
				if(rs.next()) {
					dto.setName(rs.getString(4));
					dto.setPhone(rs.getString(5));
					dto.setZip_code(rs.getString(7));
					dto.setAddress1(rs.getString(8));
					dto.setAddress2(rs.getString(9));		
				}
				return dto;
			}
		}
	}
}

