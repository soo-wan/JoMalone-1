package kh.jomalone.DTO;

public class CartDTO {
     private String mem_id;
     private int seq;
     private String mem_name;
	 private String prod_name;
	 private int prod_quantity;
	 private int price;
	 
	public CartDTO() {
		super();
	}
	public CartDTO(String mem_id, int seq, String mem_name, String prod_name, int prod_quantity, int price) {
		super();
		this.mem_id = mem_id;
		this.seq = seq;
		this.mem_name = mem_name;
		this.prod_name = prod_name;
		this.prod_quantity = prod_quantity;
		this.price = price;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
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
	
}
