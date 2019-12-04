package kh.jomalone.DTO;

import java.sql.Timestamp;

public class OrderManagementDTO {
	private String merchant_uid;
	private Timestamp order_date;
	private String mem_id;
	private String prod_name;
	private int prod_quantity;
	private String order_state;
	private String delivery_check;
	private String refund;
	private String processed;
	public OrderManagementDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public OrderManagementDTO(String merchant_uid, Timestamp order_date, String mem_id, String prod_name,
			int prod_quantity, String order_state, String delivery_check, String refund, String processed) {
		super();
		this.merchant_uid = merchant_uid;
		this.order_date = order_date;
		this.mem_id = mem_id;
		this.prod_name = prod_name;
		this.prod_quantity = prod_quantity;
		this.order_state = order_state;
		this.delivery_check = delivery_check;
		this.refund = refund;
		this.processed = processed;
	}
	/**
	 * @return the merchant_uid
	 */
	public String getMerchant_uid() {
		return merchant_uid;
	}
	/**
	 * @param merchant_uid the merchant_uid to set
	 */
	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}
	/**
	 * @return the order_date
	 */
	public Timestamp getOrder_date() {
		return order_date;
	}
	/**
	 * @param order_date the order_date to set
	 */
	public void setOrder_date(Timestamp order_date) {
		this.order_date = order_date;
	}
	/**
	 * @return the mem_id
	 */
	public String getMem_id() {
		return mem_id;
	}
	/**
	 * @param mem_id the mem_id to set
	 */
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	/**
	 * @return the prod_name
	 */
	public String getProd_name() {
		return prod_name;
	}
	/**
	 * @param prod_name the prod_name to set
	 */
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	/**
	 * @return the prod_quantity
	 */
	public int getProd_quantity() {
		return prod_quantity;
	}
	/**
	 * @param prod_quantity the prod_quantity to set
	 */
	public void setProd_quantity(int prod_quantity) {
		this.prod_quantity = prod_quantity;
	}
	/**
	 * @return the order_state
	 */
	public String getOrder_state() {
		return order_state;
	}
	/**
	 * @param order_state the order_state to set
	 */
	public void setOrder_state(String order_state) {
		this.order_state = order_state;
	}
	/**
	 * @return the delivery_check
	 */
	public String getDelivery_check() {
		return delivery_check;
	}
	/**
	 * @param delivery_check the delivery_check to set
	 */
	public void setDelivery_check(String delivery_check) {
		this.delivery_check = delivery_check;
	}
	/**
	 * @return the refund
	 */
	public String getRefund() {
		return refund;
	}
	/**
	 * @param refund the refund to set
	 */
	public void setRefund(String refund) {
		this.refund = refund;
	}
	/**
	 * @return the processed
	 */
	public String getProcessed() {
		return processed;
	}
	/**
	 * @param processed the processed to set
	 */
	public void setProcessed(String processed) {
		this.processed = processed;
	}
	
}
