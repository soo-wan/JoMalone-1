package kh.jomalone.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

public class OrderListDAO {
	private static OrderListDAO instance;

	public synchronized static OrderListDAO getInstance() {
		if(instance == null) {
			instance = new OrderListDAO();
		}
		return instance;
	}
	private Connection getConnection() throws Exception{
		return DAO.bds.getConnection();
	}
}
