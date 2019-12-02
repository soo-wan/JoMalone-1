package kh.jomalone.DTO;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class ReviewDTO {
	private int review_seq;
	private String merchant_uid;
	private String prod_name;
	private String mem_id;
	private String title;
	private String contents;
	private int grade;
	private Timestamp write_date;
	private String blind_yn;
	
	public ReviewDTO() {
		super();
	}
	
	public ReviewDTO(int review_seq, String merchant_uid, String prod_name, String mem_id, String title,
			String contents, int grade, Timestamp write_date, String blind_yn) {
		super();
		this.review_seq = review_seq;
		this.merchant_uid = merchant_uid;
		this.prod_name = prod_name;
		this.mem_id = mem_id;
		this.title = title;
		this.contents = contents;
		this.grade = grade;
		this.write_date = write_date;
		this.blind_yn = blind_yn;
	}

	public int getReview_seq() {
		return review_seq;
	}

	public void setReview_seq(int review_seq) {
		this.review_seq = review_seq;
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

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	public Timestamp getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}

	public String getBlind_yn() {
		return blind_yn;
	}

	public void setBlind_yn(String blind_yn) {
		this.blind_yn = blind_yn;
	}

	
	
	
	
	
	
	
	
	
	public String getBlindId() {
		String result = this.getMem_id().substring(0, 3);
		result+="***";
		return result;
	}
	
	public String getFormedFullDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		return sdf.format(this.getWrite_date());
	}
	
	public String getFormedOnlyDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(this.getWrite_date());
	}
	
	public String getBlindByReport() {
		String result = null;
		if(this.getBlind_yn().contentEquals("Y")){
			result = "블라인드";
		}return result;
	}
}
