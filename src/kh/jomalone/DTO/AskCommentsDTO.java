package kh.jomalone.DTO;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class AskCommentsDTO {
	private int co_seq;
	private int ask_seq;
	private String contents;
	private Timestamp write_date;
	private String formedFullDate;
	
	public AskCommentsDTO() {
		super();
	}
	public AskCommentsDTO(int co_seq, int ask_seq, String contents, Timestamp write_date) {
		super();
		this.co_seq = co_seq;
		this.ask_seq = ask_seq;
		this.contents = contents;
		this.write_date = write_date;
	}
	public int getCo_seq() {
		return co_seq;
	}
	public void setCo_seq(int co_seq) {
		this.co_seq = co_seq;
	}
	public int getAsk_seq() {
		return ask_seq;
	}
	public void setAsk_seq(int ask_seq) {
		this.ask_seq = ask_seq;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Timestamp getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}
	
	public void setFormedFullDate(Timestamp write_date) {
		this.formedFullDate = getFormedFullDate();
	}
	public String getFormedFullDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		return sdf.format(this.getWrite_date());
	}
	
	public String getFormedOnlyDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(this.getWrite_date());
	}
}
