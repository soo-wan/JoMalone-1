package kh.jomalone.DTO;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class ReportDTO {
	private int report_seq;
	private String report_type;
	private int review_seq;
	private String mem_id;
	private String contents;
	private Timestamp report_date;
	private String check_YN;
	private String check_comments;
	private Timestamp check_date;
	private String check_type;
	private String formedDate;
	
	
	
	public ReportDTO() {
		super();
	}
		
	public ReportDTO(int report_seq, String report_type, int review_seq, String mem_id, String contents,
			Timestamp report_date, String check_YN, String check_comments, Timestamp check_date, String check_type) {
		super();
		this.report_seq = report_seq;
		this.report_type = report_type;
		this.review_seq = review_seq;
		this.mem_id = mem_id;
		this.contents = contents;
		this.report_date = report_date;
		this.check_YN = check_YN;
		this.check_comments = check_comments;
		this.check_date = check_date;
		this.check_type = check_type;
	}

	public int getReport_seq() {
		return report_seq;
	}

	public void setReport_seq(int report_seq) {
		this.report_seq = report_seq;
	}

	public String getReport_type() {
		return report_type;
	}

	public void setReport_type(String report_type) {
		this.report_type = report_type;
	}

	public int getReview_seq() {
		return review_seq;
	}

	public void setReview_seq(int review_seq) {
		this.review_seq = review_seq;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public Timestamp getReport_date() {
		return report_date;
	}

	public void setReport_date(Timestamp report_date) {
		this.report_date = report_date;
	}

	public String getCheck_YN() {
		return check_YN;
	}

	public void setCheck_YN(String check_YN) {
		this.check_YN = check_YN;
	}

	public String getCheck_comments() {
		return check_comments;
	}

	public void setCheck_comments(String check_comments) {
		this.check_comments = check_comments;
	}

	public Timestamp getCheck_date() {
		return check_date;
	}

	public void setCheck_date(Timestamp check_date) {
		this.check_date = check_date;
	}

	public String getCheck_type() {
		return check_type;
	}

	public void setCheck_type(String check_type) {
		this.check_type = check_type;
	}

	
	
	
	
	
	
	public String getFormedFullDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		return sdf.format(this.getReport_date());
	}
	
	public String getFormedOnlyDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(this.getReport_date());
	}
	
	
	public String getCheckDateFormedFullDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		return sdf.format(this.getCheck_date());
	}
	
	public String getCheckDateFormedOnlyDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(this.getCheck_date());
	}
	
	public void setFormedDate(Timestamp check_date) {
		this.formedDate = getFormedFullDate();
	}
	
	public String getCheckTypeKor() {
		String origin = this.getCheck_type();
		if(origin.contentEquals("none")) {
			return "별도 조치 없음";
		}else if(origin.contentEquals("blind")) {
			return "블라인드";
		}else {
			return "삭제";
		}
	}
	
	public String getCheckCommentsBlank() {
		if(this.getCheck_comments()==null) {
			return "없음";
		}else {
			return this.getCheck_comments();
		}
	}
}
