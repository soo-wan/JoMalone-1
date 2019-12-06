package kh.jomalone.DAO;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

public class DAO {
	public static BasicDataSource bds = new BasicDataSource();
	static {
		bds.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		bds.setUrl("jdbc:oracle:thin:@192.168.60.29:1521:xe");
		bds.setUsername("jomalone");
		bds.setPassword("jomalone");
		bds.setInitialSize(30); 
	}
}
