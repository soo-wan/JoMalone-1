package kh.jomalone.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.jomalone.DTO.BuyDTO;
import kh.jomalone.DTO.OrderListDTO;
import kh.jomalone.DTO.RankDTO;
import kh.jomalone.configuration.ConfigurationBuylist;

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
	//확인해야함
	public void insertOrderList(List<OrderListDTO> list) throws Exception {
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(
						"insert into order_list values(order_seq.nextval,sysdate,?,?,?,?,?,'결제완료',?,?,?,?,'배송 준비','N','N','N',?)");) {
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
				pstat.setString(10, dto.getImp_uid());
				pstat.executeUpdate();
				con.commit();
			}
		}
	}
	
	
	public int selectMaxBuySeq() throws Exception {
		int maxSeq = 1200;
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
	
	public List<RankDTO> selectBuyRank() throws Exception {
		List<RankDTO> list = new ArrayList<>();
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("select sum(prod_quantity) as quantity,prod_name from order_list group by prod_name order by 1 desc")) {
			try (ResultSet rs = pstat.executeQuery()) {
				while (rs.next()) {
					list.add(new RankDTO(rs.getInt(1),rs.getString(2)));
				}
			}
		}
		return list;
	}

	public List<OrderListDTO> selectBuyListByID(String id) throws Exception {
		List<OrderListDTO> list = new ArrayList<>();
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("select * from order_list where mem_id=? and buy_success='Y' and refund='N'")) {
			pstat.setString(1, id);
			try (ResultSet rs = pstat.executeQuery();) {
				while (rs.next()) {
					list.add(new OrderListDTO(rs.getInt(1), rs.getTimestamp(2),rs.getString(3),
							rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8),
							rs.getInt(9), rs.getInt(10), rs.getString(11), rs.getString(12), rs.getString(13),
							rs.getString(14), rs.getString(15), rs.getString(16), rs.getString(17)));
				}
			}
		}
		return list;
	}
	
	public List<OrderListDTO> selectBuyListByPeriod(String id,int period) throws Exception {
		List<OrderListDTO> list = new ArrayList<>();
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("SELECT * FROM order_list WHERE mem_id=? and buy_success='Y' and TO_CHAR(order_date,'YYYYMMDD') BETWEEN TO_CHAR(SYSDATE-?,'YYYYMMDD') AND TO_CHAR(SYSDATE,'YYYYMMDD') AND refund='N'")) {
			pstat.setString(1, id);
			pstat.setInt(2, period);
			try (ResultSet rs = pstat.executeQuery();) {
				while (rs.next()) {
					list.add(new OrderListDTO(rs.getInt(1), rs.getTimestamp(2),rs.getString(3),
							rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8),
							rs.getInt(9), rs.getInt(10), rs.getString(11), rs.getString(12), rs.getString(13),
							rs.getString(14), rs.getString(15), rs.getString(16), rs.getString(17)));
				}
			}
		}
		return list;
	}
	
	public List<OrderListDTO> selectRefundListByID(String id) throws Exception {
		List<OrderListDTO> list = new ArrayList<>();
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("SELECT * FROM order_list WHERE mem_id=? and buy_success='Y' (refund='Y' or refund='P')")) {
			pstat.setString(1, id);
			try (ResultSet rs = pstat.executeQuery();) {
				while (rs.next()) {
					list.add(new OrderListDTO(rs.getInt(1), rs.getTimestamp(2),rs.getString(3),
							rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8),
							rs.getInt(9), rs.getInt(10), rs.getString(11), rs.getString(12), rs.getString(13),
							rs.getString(14), rs.getString(15), rs.getString(16),rs.getString(17)));
				}
			}
		}
		return list;
	}
	
	
	
	public void updateBuyComplete(String merchant_uid, String imp_uid) throws Exception{
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("update prod_buy set buy_success ='Y' where merchant_uid= ?"); 
				PreparedStatement pstat2 = con.prepareStatement("update order_list set buy_success ='Y',imp_uid=? where merchant_uid= ?");){
			pstat.setString(1, merchant_uid);
			pstat2.setString(1, imp_uid);
			pstat2.setString(2, merchant_uid);
			pstat.executeUpdate();
			pstat2.executeUpdate();
			con.commit();
		}
	}
	
	public void updateRefund(String imp_uid, String prod_name) throws Exception{
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement("update order_list set refund ='Y' where imp_uid=? and prod_name = ?");){
			pstat.setString(1, imp_uid);
			pstat.setString(2, prod_name);
			pstat.executeUpdate();
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
	
	public int deleteOrderByMerchantuid(String merchantuid) throws Exception{
		String sql = "delete from order_list where merchant_uid=?";
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, merchantuid);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	//페이지 내비게이터
	public String getPageNavi(int currentPage,String id) throws Exception {
		//설정 값들은 지역변수로 말고 Static으로 만들어서 나중에 쓸때 쓰는게 좋다. 
		int recordTotalCount = this.selectBuyListByID(id).size();  // 알아야할점 1 : 게시판 내의 총 글의 개수     ***DB에서 값 받아 오는 값 / 레코드 개수를 불러오는 함수 부르기
							// this.getArticleCount();
		//int recordCountPerPage = 10; // 알아야할점 2 : 한페이지에서 몇개의 글을 보여줄 지 설정
		//int naviCountPerPage = 10;   // 알아야할점 3 : 한페이지에서 몇개의 네비게이터를 보여줄 지 설정
		int pageTotalCount = 0; // 총 몇개의 페이지 인가
		
		if(recordTotalCount % ConfigurationBuylist.recordCountPerPage > 0) {
			//총 글의 개수를 페이지당 보여줄 개수로 나누었을때, 나머지가 생기면 총 페이지의 개수 +1을 한다.(143/10=15여야함)
			pageTotalCount = recordTotalCount / ConfigurationBuylist.recordCountPerPage + 1;
		}else {
			pageTotalCount = recordTotalCount / ConfigurationBuylist.recordCountPerPage;
		}
		//int currentPage = 7; // 현재 내가 위치하는 페이지,클릭하면 서블릿한테 전송해서 dao로 받아야함.
		
		// 페이지 1이하 숫자가 나올수가 없음, 보안 강화 
		if(currentPage < 1) { 
			currentPage = 1;
		}
		else if(currentPage > pageTotalCount) {  // 현재 페이지 번호 비정상적인 숫자를 가질 때에 대한 보안 코드
			currentPage = pageTotalCount;
		}
		
		//현재 내가 위치하고 있는 페이지에 따라 네비게이터 시작 페이지 값을 구하는 공식
		int startNavi = (currentPage - 1) / ConfigurationBuylist.naviCountPerPage * ConfigurationBuylist.naviCountPerPage + 1 ;
		// (30-1) / 10 * 10 +1 = 21
		int endNavi = startNavi + ConfigurationBuylist.naviCountPerPage - 1; // 21 + 10 -1 = 30
		
		// 페이지 끝 값이 비정상 값일 때 조정하는 보안 코드
		if(endNavi > pageTotalCount) { 
			endNavi = pageTotalCount;
		}
//		System.out.println("현재 페이지 번호 : " + currentPage);
//		System.out.println("네비게이터 시작 번호 : " + startNavi);
//		System.out.println("네비게이터 끝 번호 : " + endNavi);
		
		//아래(StringBuilder)랑 같은 코드
//		String navi ="";
//		for(int i = startNavi; i<=endNavi; i++) {
//			navi += i + " ";
//		}
//		System.out.println(navi);
		
		boolean needPrev = true; // 이전이 필요한가
		boolean needNext = true; // 다음이 필요한가
		
		if(startNavi == 1) {
			needPrev = false;
		}
		if(endNavi == pageTotalCount) {
			needNext = false;
		}
		StringBuilder sb = new StringBuilder(); // 문자열 연결할때 플러스말고 세련되게 하기. ( 클래스로 만들어둠 )
		if(needPrev) {sb.append("<a href='buylist.buy?cpage="+(startNavi-1)+"'> < </a>");};
		for(int i = startNavi; i <= endNavi; i++) {
			sb.append("<a class='page' href='buylist.buy?cpage="+i+"'>");
			sb.append(i + " ");
			sb.append("</a>");
		}
		if(needNext) {sb.append("<a class='page' href='buylist.buy?cpage="+(endNavi+1)+"'> > </a>");};
		return sb.toString();
	//------페이지 내비게이터
	}
	
	public List<OrderListDTO> selectByPage(String mem_id,int start,int end, int period) throws Exception{
		String sql="select * from (select order_list.*,row_number() over (order by order_seq desc) "
				+ "row_nb from order_list where TO_CHAR(order_date,'YYYYMMDD') BETWEEN TO_CHAR(SYSDATE-?,'YYYYMMDD') AND TO_CHAR(SYSDATE,'YYYYMMDD')) where mem_id=? and buy_success='Y' and refund ='N' and row_nb between ? and ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, period);
			pstat.setString(2, mem_id);
			pstat.setInt(3, start);
			pstat.setInt(4, end);
			
			try(ResultSet rs = pstat.executeQuery();){
				List<OrderListDTO> list = new ArrayList<>();
				while (rs.next()) {
					list.add(new OrderListDTO(rs.getInt(1), rs.getTimestamp(2),rs.getString(3),
							rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8),
							rs.getInt(9), rs.getInt(10), rs.getString(11), rs.getString(12), rs.getString(13),
							rs.getString(14), rs.getString(15), rs.getString(16),rs.getString(17)));
				}
				return list;
			}
		}
	}
	
	public List<OrderListDTO> selectRefundList(String mem_id) throws Exception{
		String sql="select * from (select order_list.*,row_number() over (order by order_seq desc) "
				+ "row_nb from order_list) where mem_id=? and buy_success='Y' and (refund ='Y' or refund = 'P')";
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, mem_id);
			try(ResultSet rs = pstat.executeQuery();){
				List<OrderListDTO> list = new ArrayList<>();
				while (rs.next()) {
					list.add(new OrderListDTO(rs.getInt(1), rs.getTimestamp(2),rs.getString(3),
							rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8),
							rs.getInt(9), rs.getInt(10), rs.getString(11), rs.getString(12), rs.getString(13),
							rs.getString(14), rs.getString(15), rs.getString(16),rs.getString(17)));
				}
				return list;
			}
		}
	}

}





