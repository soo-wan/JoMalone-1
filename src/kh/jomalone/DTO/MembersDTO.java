package kh.jomalone.DTO;


import java.sql.Array;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;



public class MembersDTO {
   private String id, logintype, pw, name, phone1, phone2, phone3, email1, email2, zip_code, address1, address2, gender, black_yn;
   private String year, month, day, agree_s, agree_p;
   private Timestamp enrolldate,blackdate, lastlogin;
   private String phone;
   private String email;
   private String birth;
   
   
   public MembersDTO() {};
   //정보수정
   public MembersDTO(String id, String pw, String phone1, String phone2, String phone3, String email1, String email2,
         String zip_code, String address1, String address2, String year, String month, String day, String gender) {
      this.id = id;
      this.pw = pw;
      this.phone1 = phone1;
      this.phone2 = phone2;
      this.phone3   = phone3;
      this.email1 = email1;
      this.email2 = email2;
      this.zip_code = zip_code;
      this.address1 = address1;
      this.address2 = address2;
      this.year = year;
      this.month = month;
      this.day = day;
      this.gender = gender;
      if(phone1 != null || phone2 != null || phone3 != null) {
          phone = phone1+"-"+phone2+"-"+phone3;         
       }
       if(email1 != null || email2 != null) {
          email = email1+"@"+email2;         
       }
       if(year != null || month != null || day != null) {
          birth = year+"-"+month+"-"+day;         
       }

   }
   //sns회원가입 , 관리자가 회원정보 조회.
   public MembersDTO(String id, String logintype, String pw,String name, String phone, String email, String zip_code,
         String address1, String address2, String birth, String gender,Timestamp enrolldate, Timestamp lastlogin, String black_yn,Timestamp blackdate,String agree_s, String agree_p) {
      super();
      this.id = id;
      this.logintype = logintype;
      this.pw = pw;
      this.name = name;
      this.phone = phone;
      this.email = email;
      this.zip_code = zip_code;
      this.address1 = address1;
      this.address2 = address2;
      this.gender = gender;
      this.black_yn = black_yn;
      this.birth = birth;
      this.agree_s = agree_s;
      this.agree_p = agree_p;
      this.lastlogin = lastlogin;
      this.enrolldate = enrolldate;
      this.blackdate = blackdate;

      if(phone != null) {
          String[] array = phone.split("-");
          phone1 = array[0];
          phone2 = array[1];
          phone3 = array[2];
       }
       if(email != null) {
          String[] emailarray = email.split("@");
          email1 = emailarray[0];
          email2 = emailarray[1];
       }   
       if(birth != null) {
          String[] birtharray = birth.split("-");
          year = birtharray[0];
          month = birtharray[1];
          day = birtharray[2];   
       }


   }
   //회원가입 
   public MembersDTO(String id, String logintype, String pw, String name, String phone1,
         String phone2, String phone3, String email1, String email2, String zip_code, String address1,
         String address2,  String year, String month, String day, String gender,
         Timestamp enrolldate, Timestamp lastlogin, String black_yn, Timestamp blackdate, String agree_s, String agree_p) {
      super();
      this.id = id;
      this.logintype = logintype;
      this.pw = pw;
      this.name = name;
      this.phone1 = phone1;
      this.phone2 = phone2;
      this.phone3 = phone3;
      this.email1 = email1;
      this.email2 = email2;
      this.zip_code = zip_code;
      this.address1 = address1;
      this.address2 = address2;
      this.gender = gender;
      this.black_yn = black_yn;
      this.year = year;
      this.month = month;
      this.day = day;
      this.agree_s = agree_s;
      this.agree_p = agree_p;
      this.lastlogin = lastlogin;
      this.enrolldate = enrolldate;
      this.blackdate = blackdate;
      if(phone1 != null || phone2 != null || phone3 != null) {
          phone = phone1+"-"+phone2+"-"+phone3;         
       }
       if(email1 != null || email2 != null) {
          email = email1+"@"+email2;         
       }
       if(year != null || month != null || day != null) {
          birth = year+"-"+month+"-"+day;         
       }

      
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
public String getPw() {
	return pw;
}
public void setPw(String pw) {
	this.pw = pw;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getPhone1() {
	return phone1;
}
public void setPhone1(String phone1) {
	this.phone1 = phone1;
}
public String getPhone2() {
	return phone2;
}
public void setPhone2(String phone2) {
	this.phone2 = phone2;
}
public String getPhone3() {
	return phone3;
}
public void setPhone3(String phone3) {
	this.phone3 = phone3;
}
public String getEmail1() {
	return email1;
}
public void setEmail1(String email1) {
	this.email1 = email1;
}
public String getEmail2() {
	return email2;
}
public void setEmail2(String email2) {
	this.email2 = email2;
}
public String getZip_code() {
	return zip_code;
}
public void setZip_code(String zip_code) {
	this.zip_code = zip_code;
}
public String getAddress1() {
	return address1;
}
public void setAddress1(String address1) {
	this.address1 = address1;
}
public String getAddress2() {
	return address2;
}
public void setAddress2(String address2) {
	this.address2 = address2;
}
public String getGender() {
	return gender;
}
public void setGender(String gender) {
	this.gender = gender;
}
public String getBlack_yn() {
	return black_yn;
}
public void setBlack_yn(String black_yn) {
	this.black_yn = black_yn;
}
public String getYear() {
	return year;
}
public void setYear(String year) {
	this.year = year;
}
public String getMonth() {
	return month;
}
public void setMonth(String month) {
	this.month = month;
}
public String getDay() {
	return day;
}
public void setDay(String day) {
	this.day = day;
}
public String getAgree_s() {
	return agree_s;
}
public void setAgree_s(String agree_s) {
	this.agree_s = agree_s;
}
public String getAgree_p() {
	return agree_p;
}
public void setAgree_p(String agree_p) {
	this.agree_p = agree_p;
}
public Timestamp getEnrolldate() {
	return enrolldate;
}
public void setEnrolldate(Timestamp enrolldate) {
	this.enrolldate = enrolldate;
}
public Timestamp getBlackdate() {
	return blackdate;
}
public void setBlackdate(Timestamp blackdate) {
	this.blackdate = blackdate;
}
public Timestamp getLastlogin() {
	return lastlogin;
}
public void setLastlogin(Timestamp lastlogin) {
	this.lastlogin = lastlogin;
}
public String getPhone() {
	return phone;
}
public void setPhone(String phone) {
	this.phone = phone;
}
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
public String getBirth() {
	return birth;
}
public void setBirth(String birth) {
	this.birth = birth;
}

   
   
}