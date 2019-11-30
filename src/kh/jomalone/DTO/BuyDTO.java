package kh.jomalone.DTO;

import java.sql.Timestamp;

public class BuyDTO {
	private int buy_seq;
	private Timestamp buyDate;
	private String pg;
	private String pay_method;
	private String merchant_uid;
	private String buy_name;
	private int totalPrice;
	private String mem_id;
	private String mem_name;
	private String mem_phone;
	private String mem_email;
	private String full_address;
	private String zip_code;
	private String buy_success;
	public BuyDTO() {
		super();
	}
	public BuyDTO(int buy_seq, Timestamp buyDate, String pg, String pay_method, String merchant_uid, String buy_name,
			int totalPrice, String mem_id, String mem_name, String mem_phone, String mem_email, String full_address,
			String zip_code, String buy_success) {
		super();
		this.buy_seq = buy_seq;
		this.buyDate = buyDate;
		this.pg = pg;
		this.pay_method = pay_method;
		this.merchant_uid = merchant_uid;
		this.buy_name = buy_name;
		this.totalPrice = totalPrice;
		this.mem_id = mem_id;
		this.mem_name = mem_name;
		this.mem_phone = mem_phone;
		this.mem_email = mem_email;
		this.full_address = full_address;
		this.zip_code = zip_code;
		this.buy_success = buy_success;
	}
	public int getBuy_seq() {
		return buy_seq;
	}
	public void setBuy_seq(int buy_seq) {
		this.buy_seq = buy_seq;
	}
	public Timestamp getBuyDate() {
		return buyDate;
	}
	public void setBuyDate(Timestamp buyDate) {
		this.buyDate = buyDate;
	}
	public String getPg() {
		return pg;
	}
	public void setPg(String pg) {
		this.pg = pg;
	}
	public String getPay_method() {
		return pay_method;
	}
	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}
	public String getMerchant_uid() {
		return merchant_uid;
	}
	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}
	public String getBuy_name() {
		return buy_name;
	}
	public void setBuy_name(String buy_name) {
		this.buy_name = buy_name;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_phone() {
		return mem_phone;
	}
	public void setMem_phone(String mem_phone) {
		this.mem_phone = mem_phone;
	}
	public String getMem_email() {
		return mem_email;
	}
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}
	public String getFull_address() {
		return full_address;
	}
	public void setFull_address(String full_address) {
		this.full_address = full_address;
	}
	public String getZip_code() {
		return zip_code;
	}
	public void setZip_code(String zip_code) {
		this.zip_code = zip_code;
	}
	public String getBuy_success() {
		return buy_success;
	}
	public void setBuy_success(String buy_success) {
		this.buy_success = buy_success;
	}
	
	
	
}