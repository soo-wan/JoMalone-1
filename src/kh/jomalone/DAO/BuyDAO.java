package kh.jomalone.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.jomalone.DTO.BuyDTO;
import kh.jomalone.DTO.OrderListDTO;

public class BuyDAO {
	private static BuyDAO instance;
	private static BasicDataSource bds = new BasicDataSource();

	private BuyDAO() {
		bds.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		bds.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		bds.setUsername("jomalone");
		bds.setPassword("jomalone");
		bds.setInitialSize(50);
	}

	public synchronized static BuyDAO getInstance() {
		if (instance == null) {
			instance = new BuyDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		return bds.getConnection();
	}

	public int insertBuyProduct(BuyDTO dto) throws Exception {
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(
						"insert into prod_buy values(buy_seq.nextval,sysdate,?,?,?,?,?,?,?,?,?,?,?,?)");) {
			pstat.setString(1, dto.getPg());
			pstat.setString(2, dto.getPay_method());
			pstat.setString(3, dto.getMerchant_uid());
			pstat.setString(4, dto.getBuy_name());
			pstat.setInt(5, dto.getTotalPrice());
			pstat.setString(6, dto.getMem_id());
			pstat.setString(7, dto.getMem_name());
			pstat.setString(8, dto.getMem_phone());
			pstat.setString(9, dto.getMem_email());
			pstat.setString(10, dto.getFull_address());
			pstat.setString(11, dto.getZip_code());
			pstat.setString(12, dto.getBuy_success());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public int selectMaxBuySeq() throws Exception {
		int maxSeq = 1;
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("select max(buy_seq) from prod_buy")) {
			try (ResultSet rs = pstat.executeQuery()) {
				if (rs.next()) {
					maxSeq = rs.getInt(1);
				}
			}
		}
		return maxSeq;
	}

	public void insertOrderList(List<OrderListDTO> list) throws Exception {
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(
						"insert into order_list values(order_seq.nextval,sysdate,?,?,?,?,?,'결제완료',?,?,?,?,'배송상태','N','N','N')");) {
			for (OrderListDTO dto : list) {
				pstat.setString(1, dto.getMerchant_uid());
				pstat.setString(2, dto.getProd_name());
				pstat.setString(3, dto.getPay_method());
				pstat.setString(4, dto.getMem_id());
				pstat.setString(5, dto.getMem_name());
				pstat.setInt(6, dto.getProd_quantity());
				pstat.setInt(7, dto.getPrice());
				pstat.setString(8, dto.getFull_address());
				pstat.setString(9, dto.getZip_code());
				pstat.executeUpdate();
				con.commit();
			}
		}
	}
	
	
	
	

	public List<OrderListDTO> selectBuyList(String id) throws Exception {
		List<OrderListDTO> list = new ArrayList<>();
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("select * from prod_buy")) {
			try (ResultSet rs = pstat.executeQuery();) {
				while (rs.next()) {
					list.add(new OrderListDTO(rs.getInt(1), rs.getTimestamp(2),rs.getString(3),
							rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8),
							rs.getInt(9), rs.getInt(10), rs.getString(11), rs.getString(12), rs.getString(13),
							rs.getString(14), rs.getString(15), rs.getString(16)));

				}
			}
		}
		return list;
	}
	

	
	public void updateBuyComplete(String merchant_uid) throws Exception{
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("update prod_buy set buy_success ='Y' where merchant_uid= ?"); 
				PreparedStatement pstat2 = con.prepareStatement("update order_list set buy_success ='Y' where merchant_uid= ?");){
			pstat.setString(1, merchant_uid);
			pstat2.setString(1, merchant_uid);
			pstat.executeUpdate();
			pstat2.executeUpdate();
			con.commit();
		}
	}
	
	public int deleteOrder(int seq) throws Exception{ // 주문 선택 삭제
		String sql = "delete from cart where seq=?";
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, seq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
}
