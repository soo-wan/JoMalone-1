package kh.jomalone.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.jomalone.DTO.ProductDTO;
import kh.jomalone.DTO.RankDTO;

public class ProductViewDAO {
	private static ProductViewDAO instance;
	private static BasicDataSource bds = new BasicDataSource();

	private ProductViewDAO() {
		bds.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		bds.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		bds.setUsername("jomalone");
		bds.setPassword("jomalone");
		bds.setInitialSize(50);
	}

	public synchronized static ProductViewDAO getInstance() {
		if (instance == null) {
			instance = new ProductViewDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		return bds.getConnection();
	}
	
	public List<ProductDTO> selectProductByProdName(String productName) throws Exception {
		List<ProductDTO> list = new ArrayList<>();
		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("select * from product where prod_name=?")) {
			pstat.setString(1, productName);
			try (ResultSet rs = pstat.executeQuery()) {
				while (rs.next()) {
					list.add(new ProductDTO(rs.getString(1),rs.getString(2),rs.getString(3),rs.getInt(4),rs.getInt(5),rs.getString(6),rs.getInt(7),rs.getInt(8),rs.getInt(9),rs.getInt(10)));
				}
			}
		}
		return list;
	}
	
	public ProductDTO selectProductDTOByProdName(String productName) throws Exception {
		ProductDTO dto = new ProductDTO();
		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("select * from product where prod_name=?")) {
			pstat.setString(1, productName);
			try (ResultSet rs = pstat.executeQuery()) {
				if (rs.next()) {
					dto = new ProductDTO(rs.getString(1),rs.getString(2),rs.getString(3),rs.getInt(4),rs.getInt(5),rs.getString(6),rs.getInt(7),rs.getInt(8),rs.getInt(9),rs.getInt(10));
				}
			}
		}
		return dto;
	}
	
	public List<ProductDTO> selectProductByProdcode(String productCode) throws Exception {
		List<ProductDTO> list = new ArrayList<>();
		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("select * from product where prod_code=?")) {
			pstat.setString(1, productCode);
			try (ResultSet rs = pstat.executeQuery()) {
				while (rs.next()) {
					list.add(new ProductDTO(rs.getString(1),rs.getString(2),rs.getString(3),rs.getInt(4),rs.getInt(5),rs.getString(6),rs.getInt(7),rs.getInt(8),rs.getInt(9),rs.getInt(10)));
				}
			}
		}
		return list;
	}
	public List<ProductDTO> selectProductByProdCategory(String productCategory) throws Exception {
		List<ProductDTO> list = new ArrayList<>();
		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("select * from product where prod_category=?")) {
			pstat.setString(1, productCategory);
			try (ResultSet rs = pstat.executeQuery()) {
				while (rs.next()) {
					list.add(new ProductDTO(rs.getString(1),rs.getString(2),rs.getString(3),rs.getInt(4),rs.getInt(5),rs.getString(6),rs.getInt(7),rs.getInt(8),rs.getInt(9),rs.getInt(10)));
				}
			}
		}
		return list;
	}
}
