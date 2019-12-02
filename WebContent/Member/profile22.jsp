<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/Resource/key/top.jsp" flush="false"/>
	
	<form action="modi.my" method="post" id="signform">
	
		<div id="signup-page" class="container">
			<div id="signup-title" class="row"><h4>SIGN UP</h4></div>
			<div id="signup-inputbox" class="row">
				<div id="su-id"><h5><span>*</span>아이디 : </h5><input type="text" placeholder="Input Your ID" style="width: 200px; height: 30px;" id="id" name="id" value="${dto.id }" readonly></div>
				<br>
				<div id="su-pw"><h5><span>*</span>패스워드 : </h5><input type="password" placeholder="Input Your PW" style="width: 200px; height: 30px;" id="pw" name="pw"></div>
				<br>
				<div id="su-pw-check"><h5><span>*</span>패스워드 확인 : </h5><input type="password" placeholder="Input Your PW Check" style="width: 200px; height: 30px;" id="repw"></div>
				<br>
				<div id="su-name"><h5><span>*</span>이름 : </h5><input type="text" placeholder="Input Your Name" style="width: 200px; height: 30px;" name="name" value="${dto.name }" readonly></div>
				<div id="su-phone">
					<h5><span>*</span>전화번호 : </h5>
					<input type="text" name="phone1" id="phone2" style="margin-left: 0px; width: 70px; height: 30px;" value="${phone1 }">
					<span style="margin: 0px 5px 0px 5px; height:30px; color: black;"> - </span>
					<input type="text" name="phone2" id="phone2" style="margin-left: 0px; width: 70px; height: 30px;" value="${phone2 }">
					<span style="margin: 0px 5px 0px 5px; height:30px; color: black;"> - </span>
					<input type="text" name="phone3" id="phone3" style="margin-left: 0px; width: 70px; height: 30px;" value="${phone3 }">
				</div>
				<div id="su-email">
					<h5><span>*</span>이메일 : </h5>
					<input type="text" name="email1" id="email1" style="width: 80px; height: 30px;" value="${email1 }">
					<span style="margin: 0px 5px 0px 5px; height:30px; color: black;">@</span>
					<input type="text" name="email2" style="margin-left: 0px; width: 90px; height: 30px;" value="${email2 }">
					
				</div>
				<div id="su-address" style="height: 110px;">
					<h5><span>*</span>주소 : </h5><input type="text" id="zip_code" name="zip_code" value="${dto.zip_code }"><input type="button" onclick="postcode()" value="주소 찾기"><br>
					<input type="text" id="address1" placeholder="Input Your Road Name Address" style="margin: 8px 0px 0px 15px; width: 250px; height: 30px;" name="address1" value="${dto.address1 }"><br>
					<input type="text" id="address2" placeholder="Input Your Detail Address" style="margin: 8px 0px 0px 135px; width: 250px; height: 30px;" name="address2" value="${dto.address2 }">				
				</div>
				<div id="su-birth">
					<h5>생년월일 : </h5>
					<select name="year" id="year" style="margin-left: 15px; padding-left: 5px; height: 30px;">
						<option value="${year }">${year }</option>
					</select>
					<select name="month" id="month" style="margin-left: 8px; padding-left: 5px; height: 30px;">
						<option value="${month }">${month }</option>
					</select>
					<select name="day" id="day" style="margin-left: 8px; padding-left: 5px; height: 30px;">
						<option value="${day }">${day }</option>
					</select>
				</div>
				<div id="su-gender">
					<h5>성별 : </h5>
					<c:choose>
					<c:when test="${dto.gender == M}">
					<input type="radio" value="M" name="gender" id="gender" checked><h6>남</h6>
					<input type="radio" value="F" name="gender" id="gender"><h6>여</h6>
					</c:when>
					<c:otherwise>
					<input type="radio" value="M" name="gender" id="gender" ><h6>남</h6>
					<input type="radio" value="F" name="gender" id="gender" checked><h6>여</h6>
					</c:otherwise>
					</c:choose>
				</div>
			</div>
			
			
			<div id="myprofile-btn">
				<input id="profile-modi" type="submit" value="수정하기">
				<input id="profile-del" type="reset" value="탈퇴하기">
				<input id="profile-back" type="reset" value="뒤로가기">
			</div>
		</div>

	</form>
	<script>
	$(document).ready(function() {
		setDateBox();
	});
	
	// 생년월일 :select box 연도 , 월 표시
	function setDateBox() {
		var dt = new Date();
		var year = "";
		var com_year = dt.getFullYear();
		// 올해 기준으로 -70년부터 +5년을 보여준다.
		for (var y = (com_year - 70); y <= (com_year); y++) {
			$("#year").append(
				"<option value='"+ y +"'>" + y + "년" + "</option>");
		}
		for (var i = 1; i <= 12; i++) {
			$("#month").append(
				"<option value='"+ i +"'>" + i + "월" + "</option>");
		}
		for (var i = 1; i <= 31; i++) {
			$("#day").append(
				"<option value='"+ i +"'>" + i + "일" + "</option>");
		}
	}
	</script>
</body>
</html>