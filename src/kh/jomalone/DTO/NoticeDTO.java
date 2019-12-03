package kh.jomalone.DTO;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class NoticeDTO {
	private int notice_seq;
	private String title;
	private String contents;
	private Timestamp write_date;
	
	public NoticeDTO() {
		super();
	}

	public NoticeDTO(int notice_seq, String title, String contents, Timestamp write_date) {
		super();
		this.notice_seq = notice_seq;
		this.title = title;
		this.contents = contents;
		this.write_date = write_date;
	}

	public int getNotice_seq() {
		return notice_seq;
	}

	public void setNotice_seq(int notice_seq) {
		this.notice_seq = notice_seq;
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

	public Timestamp getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
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
