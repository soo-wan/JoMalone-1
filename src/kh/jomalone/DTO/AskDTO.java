package kh.jomalone.DTO;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class AskDTO {
	private int ask_seq;
	private String ask_code;
	private String title;
	private String contents;
	private String mem_id;
	private String answer_yn;
	private Timestamp write_date;
	private String email_yn;
	
	
	public AskDTO() {
		super();
	}
	
	public AskDTO(int ask_seq, String ask_code, String title, String contents, String mem_id, String answer_yn,
			Timestamp write_date, String email_yn) {
		super();
		this.ask_seq = ask_seq;
		this.ask_code = ask_code;
		this.title = title;
		this.contents = contents;
		this.mem_id = mem_id;
		this.answer_yn = answer_yn;
		this.write_date = write_date;
		this.email_yn = email_yn;
	}




	public int getAsk_seq() {
		return ask_seq;
	}

	public void setAsk_seq(int ask_seq) {
		this.ask_seq = ask_seq;
	}

	public String getAsk_code() {
		return ask_code;
	}

	public void setAsk_code(String ask_code) {
		this.ask_code = ask_code;
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

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getAnswer_yn() {
		return answer_yn;
	}

	public void setAnswer_yn(String answer_yn) {
		this.answer_yn = answer_yn;
	}

	public Timestamp getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}
	
	public String getEmail_yn() {
		return email_yn;
	}

	public void setEmail_yn(String email_yn) {
		this.email_yn = email_yn;
	}

	public String getFormedFullDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		return sdf.format(this.getWrite_date());
	}
	
	public String getFormedOnlyDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(this.getWrite_date());
	}
	
	public String getAskCodeKor() {
		String code = this.getAsk_code();
		if(code.contentEquals("a1")) {
			return "배송";
		}else if(code.contentEquals("a2")) {
			return "주문";
		}else if(code.contentEquals("a3")) {
			return "반품/교환";
		}else if(code.contentEquals("a4")) {
			return "회원정보";
		}else if(code.contentEquals("a5")) {
			return "상품정보";
		}else if(code.contentEquals("a6")) {
			return "결제";
		}else if(code.contentEquals("a7")) {
			return "사이트장애";
		}else if(code.contentEquals("a8")) {
			return "매장문의";
		}else if(code.contentEquals("a9")) {
			return "기타";
		}
		return code;
	}
}
