package kh.jomalone.DTO;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class OrderListDTO {
	private int order_seq;
	private Timestamp order_date;
	private String merchant_uid;
	private String prod_name;
	private String pay_method;
	private String mem_id;
	private String mem_name;
	private String order_state;
	private int prod_quantity;
	private int price;
	private String full_address;
	private String zip_code;
	private String delivery_check;
	private String refund;
	private String processed;
	private String buy_success;
	private String date;

	public OrderListDTO() {
		super();
	}
	public OrderListDTO(int order_seq, Timestamp order_date, String merchant_uid, String prod_name, String pay_method,
			String mem_id, String mem_name, String order_state, int prod_quantity, int price, String full_address,
			String zip_code, String delivery_check, String refund, String processed, String buy_success) {
		super();
		this.order_seq = order_seq;
		this.order_date = order_date;
		this.merchant_uid = merchant_uid;
		this.prod_name = prod_name;
		this.pay_method = pay_method;
		this.mem_id = mem_id;
		this.mem_name = mem_name;
		this.order_state = order_state;
		this.prod_quantity = prod_quantity;
		this.price = price;
		this.full_address = full_address;
		this.zip_code = zip_code;
		this.delivery_check = delivery_check;
		this.refund = refund;
		this.processed = processed;
		this.buy_success = buy_success;
	}
	
	
	public int getOrder_seq() {
		return order_seq;
	}
	public void setOrder_seq(int order_seq) {
		this.order_seq = order_seq;
	}
	public Timestamp getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Timestamp order_date) {
		this.order_date = order_date;
	}
	public String getMerchant_uid() {
		return merchant_uid;
	}
	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	public String getPay_method() {
		return pay_method;
	}
	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
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
	public String getOrder_state() {
		return order_state;
	}
	public void setOrder_state(String order_state) {
		this.order_state = order_state;
	}
	public int getProd_quantity() {
		return prod_quantity;
	}
	public void setProd_quantity(int prod_quantity) {
		this.prod_quantity = prod_quantity;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
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
	public String getDelivery_check() {
		return delivery_check;
	}
	public void setDelivery_check(String delivery_check) {
		this.delivery_check = delivery_check;
	}
	public String getRefund() {
		return refund;
	}
	public void setRefund(String refund) {
		this.refund = refund;
	}
	public String getProcessed() {
		return processed;
	}
	public void setProcessed(String processed) {
		this.processed = processed;
	}
	public String getBuy_success() {
		return buy_success;
	}
	public void setBuy_success(String buy_success) {
		this.buy_success = buy_success;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
	
}
