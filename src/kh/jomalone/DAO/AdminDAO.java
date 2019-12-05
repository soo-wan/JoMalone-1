package kh.jomalone.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.jomalone.DTO.DetailDTO;
import kh.jomalone.DTO.OrderManagementDTO;
import kh.jomalone.DTO.ProductDTO;

public class AdminDAO {
	private static AdminDAO instance;
	private BasicDataSource bds = new BasicDataSource(); 
	private AdminDAO() {
		bds.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		bds.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		bds.setUsername("jomalone");
		bds.setPassword("jomalone");
		bds.setInitialSize(30); 
	}

	public static synchronized AdminDAO getInstance() { 
		if(instance == null) {
			instance = new AdminDAO();
		}
		return instance;
	}

	public Connection getConnection() throws Exception{
		return bds.getConnection();
	}

	public int insertProduct(String productCode, String category, String productName, int price, int quantity, String description, int spring, int summer, int fall, int winter) throws Exception{
		String sql = "insert into product values(?,?,?,?,?,?,?,?,?,?)";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, productCode);
			pstat.setString(2, category);
			pstat.setString(3, productName);
			pstat.setInt(4, price);
			pstat.setInt(5, quantity);
			pstat.setString(6, description);
			pstat.setInt(7, spring);
			pstat.setInt(8, summer);
			pstat.setInt(9, fall);
			pstat.setInt(10, winter);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}	
	}

	public int countProduct(String productCode) throws Exception{
		String sql = "select count(*) from product where prod_code=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, productCode);
			ResultSet rs = pstat.executeQuery();
			rs.next();
			return rs.getInt(1);
		}
	}

	public List<ProductDTO> productList() throws Exception{
		String sql = "select * from product order by prod_code";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();
				){
			List<ProductDTO> list = new ArrayList<>();
			while(rs.next()) {
				String productCode = rs.getString(1);
				String category = rs.getString(2);
				String productName = rs.getString(3);
				int price = rs.getInt(4);
				int quantity = rs.getInt(5);
				String description = rs.getString(6);
				int spring = rs.getInt(7);
				int summer = rs.getInt(8);
				int fall = rs.getInt(9);
				int winter = rs.getInt(10);
				ProductDTO dto = new ProductDTO(productCode,category,productName,price,quantity,description,spring,summer,fall,winter);
				list.add(dto);
			}
			return list;
		}
	}
	
	public int modifyProduct(String productCode, String category, String productName, int price, int quantity, String description, int spring, int summer, int fall, int winter, String oriCode) throws Exception{
		String sql = "update product set prod_code=?, prod_category=?, prod_name=?, prod_price=?, prod_quantity=?, prod_description=?, spring=?, summer=?, fall=?, winter=? where prod_code=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, productCode);
			pstat.setString(2, category);
			pstat.setString(3, productName);
			pstat.setInt(4, price);
			pstat.setInt(5, quantity);
			pstat.setString(6, description);
			pstat.setInt(7, spring);
			pstat.setInt(8, summer);
			pstat.setInt(9, fall);
			pstat.setInt(10, winter);
			pstat.setString(11, oriCode);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}	
	}
	
	public int modifyProductNew(String productCode, String productName, int price, int quantity, String description) throws Exception{
		String sql = "update product set prod_name=?, prod_price=?, prod_quantity=?, prod_description=? where prod_code=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, productName);
			pstat.setInt(2, price);
			pstat.setInt(3, quantity);
			pstat.setString(4, description);
			pstat.setString(5, productCode);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}	
	}
	
	public int deleteProduct(String productCode) throws Exception{
		String sql = "delete from product where prod_code=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, productCode);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	// order_management 테이블 수정해야???
	public List<OrderManagementDTO> orderManagementList() throws Exception{
		String sql =  "select merchant_uid,order_date,mem_id,prod_name,prod_quantity,order_state,delivery_check,refund,processed from order_list";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs =pstat.executeQuery();
				){
			List<OrderManagementDTO> list = new ArrayList<>();
			while(rs.next()) {
				String merchant_uid = rs.getString(1);
				Timestamp order_date = rs.getTimestamp(2);
				String mem_id = rs.getString(3);
				String prod_name = rs.getString(4);
				int prod_quantity = rs.getInt(5);
				String order_state = rs.getString(6);
				String delivery_check = rs.getString(7);
				String refund = rs.getString(8);
				String processed = rs.getString(9);
				OrderManagementDTO dto = new OrderManagementDTO(merchant_uid, order_date, mem_id, prod_name, prod_quantity, order_state, delivery_check, refund, processed);
				list.add(dto);
			}
			return list;
		}
	}
	
	public int deliveryState(String merchant_uid) throws Exception{
		String sql = "update order_list set delivery_check='배송중' where merchant_uid=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, merchant_uid);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int changeQuantity(Map<String,Integer> name_quantity_list) throws Exception{
		int result = 1;
		for(String prod_name : name_quantity_list.keySet()) {
			String sql = "update product set prod_quantity=prod_quantity-(?) where prod_name=?";
			try(
					Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);
					){
				pstat.setInt(1, name_quantity_list.get(prod_name));
				pstat.setString(2, prod_name);
				result = result * pstat.executeUpdate();
				con.commit();
			}
		}
		return result;
	}
	
	public int changeProcessedColumn() throws Exception{
		String sql = "update order_list set processed='Y'";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public List<ProductDTO> productList(String productCode) throws Exception{ // 근데 이거 굳이 list로 안 받고 dto로 받아도 되는데. 상품코드는 중복되지 않으니까.
		String sql = "select * from product where prod_code=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				
				){
			pstat.setString(1, productCode);
			try(
					ResultSet rs = pstat.executeQuery();
					){
				List<ProductDTO> list = new ArrayList<>();
				while(rs.next()) {
					String prod_code = rs.getString("PROD_CODE");
					String prod_category = rs.getString("PROD_CATEGORY");
					String prod_name = rs.getString("PROD_NAME");
					int prod_price = rs.getInt("PROD_PRICE");
					int prod_quantity = rs.getInt("PROD_QUANTITY");
					String prod_description = rs.getString("PROD_DESCRIPTION");
					int spring = rs.getInt("SPRING");
					int summer = rs.getInt("SUMMER");
					int fall = rs.getInt("FALL");
					int winter = rs.getInt("WINTER");
					ProductDTO dto = new ProductDTO(prod_code,prod_category,prod_name,prod_price,prod_quantity,prod_description,spring,summer,fall,winter);
					list.add(dto);
				}
				return list;
			}
		}
	}
	
	public List getProductCode(String category) throws Exception{
		String sql = "select * from category_productcode where prod_category=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, category);
			ResultSet rs = pstat.executeQuery();
			List list = new ArrayList();
			while(rs.next()) {
				list.add(rs.getString(2));
			}
			return list;
		}
	}
	
	
	public int insertCategoryProdCode(String category, String productCode) throws Exception{
		String sql = "insert into category_productcode values(?,?)";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, category);
			pstat.setString(2, productCode);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int deleteCategoryProdCode(String productCode) throws Exception{
		String sql = "delete from category_productcode where prod_code=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, productCode);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int deleteProductDetail(String productCode) throws Exception{
		String sql = "delete from product_detail where prod_code=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, productCode);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int countProdInDetailList(String productCode) throws Exception{
		String sql = "select count(*) from product_detail where prod_code=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, productCode);
			ResultSet rs = pstat.executeQuery();
			rs.next();
			return rs.getInt(1);
		}
	}
	
	public int insertDetail(String productCode, String content, String ingredients) throws Exception{
		if(this.countProdInDetailList(productCode) > 0) {
			String sql = "update product_detail set content=?, ingredients=? where prod_code=?";
			try(
					Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);
					){
				pstat.setString(1, content);
				pstat.setString(2, ingredients);
				pstat.setString(3, productCode);
				int result = pstat.executeUpdate();
				con.commit();
				return result;
			}
		}else {
			String sql = "insert into product_detail values(product_detail_seq.nextval,?,?,?)";
			try(
					Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);
					){
				pstat.setString(1, productCode);
				pstat.setString(2, content);
				pstat.setString(3, ingredients);
				int result = pstat.executeUpdate();
				con.commit();
				return result;
			}
		}
	}
	
	public List<DetailDTO> getDetailList() throws Exception{
		String sql = "select * from product_detail order by prod_code";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();
				){
			List<DetailDTO> list = new ArrayList<>();
			while(rs.next()) {
				int seq = rs.getInt(1);
				String prod_code = rs.getString(2);
				String content = rs.getString(3);
				String ingredients = rs.getString(4);
				DetailDTO dto = new DetailDTO(seq,prod_code,content,ingredients);
				list.add(dto);
			}
			return list;
		}
	}
	
	public DetailDTO getDetail(String productCode) throws Exception{
		String sql = "select * from product_detail where prod_code=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, productCode);
			try(
					ResultSet rs = pstat.executeQuery();
					){
				DetailDTO dto = null;
				if(rs.next()) {
					int seq = rs.getInt(1);
					String prod_code = rs.getString(2);
					String content = rs.getString(3);
					String ingredients = rs.getString(4);
					dto = new DetailDTO(seq,prod_code,content,ingredients);
				}
				return dto;
			}
		}
	}
	
	public int modifyDetail(String content, String ingredients, String productCode) throws Exception{
		String sql = "update product_detail set content=?, ingredients=? where prod_code=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, content);
			pstat.setString(2, ingredients);
			pstat.setString(3, productCode);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}	
	}
	
	public List<ProductDTO> productListPerCategory(String category) throws Exception{
		String sql = "select * from product where prod_category=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, category);
			try(
					ResultSet rs = pstat.executeQuery();
					){
				List<ProductDTO> list = new ArrayList<>();
				while(rs.next()) {
					String productCode = rs.getString("PROD_CODE");
					String productName = rs.getString("PROD_NAME");
					int price = rs.getInt("PROD_PRICE");
					ProductDTO dto = new ProductDTO(productCode,productName,price);
					list.add(dto);
				}
				return list;
			}
		}
	}
	
	public ProductDTO eachProductInfo(String productCode) throws Exception{
		String sql = "select p.*,pd.content,pd.ingredients from product p,product_detail pd where p.prod_code=? and pd.prod_code=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, productCode);
			pstat.setString(2, productCode);
			try(
					ResultSet rs = pstat.executeQuery();
					){
				ProductDTO dto = null;
				if(rs.next()) {
					String prod_code = rs.getString("PROD_CODE");
					String prod_category = rs.getString("PROD_CATEGORY");
					String prod_name = rs.getString("PROD_NAME");
					int prod_price = rs.getInt("PROD_PRICE");
					int prod_quantity = rs.getInt("PROD_QUANTITY");
					String prod_description = rs.getString("PROD_DESCRIPTION");
					int spring = rs.getInt("SPRING");
					int summer = rs.getInt("SUMMER");
					int fall = rs.getInt("FALL");
					int winter = rs.getInt("WINTER");
					String content = rs.getString("CONTENT");
					String ingredients = rs.getString("INGREDIENTS");
					dto = new ProductDTO(prod_code,prod_category,prod_name,prod_price,prod_quantity,prod_description,spring,summer,fall,winter,content,ingredients);
				}
				return dto;
			}
		}
	}
	
}
