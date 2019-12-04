package kh.jomalone.DTO;

public class RankDTO {
	private int buy_count;
	private String prod_name;
	public RankDTO() {
		super();
	}
	public RankDTO(int buy_count, String prod_name) {
		super();
		this.buy_count = buy_count;
		this.prod_name = prod_name;
	}
	public int getBuy_count() {
		return buy_count;
	}
	public void setBuy_count(int buy_count) {
		this.buy_count = buy_count;
	}
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	
	
}
