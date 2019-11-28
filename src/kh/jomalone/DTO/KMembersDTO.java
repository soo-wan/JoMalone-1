package kh.jomalone.DTO;

public class KMembersDTO {
	private String id;
	private String logintype;
	private String access_token;
	private String name;
	private String email;
	private String birthday;
	private String gender;
	public KMembersDTO(String id, String logintype, String access_token, String name, String email, String birthday,
			String gender) {
		super();
		this.id = id;
		this.logintype = logintype;
		this.access_token = access_token;
		this.name = name;
		this.email = email;
		this.birthday = birthday;
		this.gender = gender;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLogintype() {
		return logintype;
	}
	public void setLogintype(String logintype) {
		this.logintype = logintype;
	}
	public String getAccess_token() {
		return access_token;
	}
	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	
	
	
	
}
