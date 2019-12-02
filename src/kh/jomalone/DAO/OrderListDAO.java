package kh.jomalone.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

public class OrderListDAO {
	private static OrderListDAO instance;
	private static BasicDataSource bds = new BasicDataSource();
	private OrderListDAO() {
		bds.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		bds.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		bds.setUsername("jomalone");
		bds.setPassword("jomalone");
		bds.setInitialSize(30);
	}
	public synchronized static OrderListDAO getInstance() {
		if(instance == null) {
			instance = new OrderListDAO();
		}
		return instance;
	}
	private Connection getConnection() throws Exception{
		return bds.getConnection();
	}
}
