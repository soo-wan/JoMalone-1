<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile | Jo Malone</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="Resource/css/profile.css">
</head>
<body>
	<jsp:include page="Resource/key/top.jsp" flush="false"/>
	
	<div id="profile" class="container">
		<div id="profile-title" class="row"><h4>MY PROFILE</h4></div>
		<div id="profile-inputbox" class="row">
			<div id="su-id"><h5><span>*</span>아이디 : </h5><input type="text" placeholder="Input Your ID" style="width: 200px; height: 30px;" id="id" name="id"></div>
			<div class="id regex" style="padding-left: 135px; height: 20px; font-size: 13px;">영어 소문자 및 숫자 4~12자리를 입력하세요.</div>
			<div id="su-pw"><h5><span>*</span>패스워드 : </h5><input type="password" placeholder="Input Your PW" style="width: 200px; height: 30px;" id="pw" name="pw"></div>
			<div class="pw regex" style="padding-left: 135px; height: 20px; font-size: 13px;">영어대소문자 및 숫자 8-12자리를 입력하세요.</div>
			<div id="su-pw-check"><h5><span>*</span>패스워드 확인 : </h5><input type="password" placeholder="Input Your PW Check" style="width: 200px; height: 30px;" id="repw"></div>
			<div class="repw regex" style="padding-left: 135px; height: 20px; font-size: 13px;"></div>
			<div id="su-name"><h5><span>*</span>이름 : </h5><input type="text" placeholder="Input Your Name" style="width: 200px; height: 30px;" name="name"></div>
			<div id="su-phone">
				<h5><span>*</span>전화번호 : </h5>
				<select name="phone1" id="phone1" style="margin-left: 15px; padding-left: 5px; width: 70px; height: 30px; border-radius: 5px;">
					<option value="010">010</option>
					<option value="011">011</option>
					<option value="016">016</option>
					<option value="017">017</option>
					<option value="017">018</option>
					<option value="017">019</option>
				</select>
				<span style="margin: 0px 5px 0px 5px; height:30px; color: black;"> - </span>
				<input type="text" name="phone2" id="phone2" style="margin-left: 0px; width: 70px; height: 30px;">
				<span style="margin: 0px 5px 0px 5px; height:30px; color: black;"> - </span>
				<input type="text" name="phone3" id="phone3" style="margin-left: 0px; width: 70px; height: 30px;">
			</div>
			<div id="su-email">
				<h5><span>*</span>이메일 : </h5>
				<input type="text" name="email1" id="email1" style="width: 80px; height: 30px;">
				<span style="margin: 0px 5px 0px 5px; height:30px; color: black;">@</span>
				<input type="text" placeholder="직접입력" name="email2" style="margin-left: 0px; width: 90px; height: 30px;">
				<select name="email2" id="email2" style="margin-left: 10px; padding-left: 5px; width: 105px; height: 30px; border-radius: 5px; font-size: 13px;">
					<option value="input">-- 선택없음</option>
					<option value="naver">naver.com</option>
					<option value="daum">daum.net</option>
					<option value="gmail">gmail.com</option>
				</select>
			</div>
			<div id="su-address" style="height: 110px;">
				<h5><span>*</span>주소 : </h5><input type="text" id="zipcode"><input type="button" onclick="postcode()" value="주소 찾기" name="zipcode"><br>
				<input type="text" id="address1" placeholder="Input Your Road Name Address" style="margin: 8px 0px 0px 15px; width: 250px; height: 30px;" name="address1"><br>
				<input type="text" id="address2" placeholder="Input Your Detail Address" style="margin: 8px 0px 0px 135px; width: 250px; height: 30px;" name="address2">				
			</div>
			<div id="su-birth">
				<h5>생년월일 : </h5>
				<select name="year" id="year" style="margin-left: 15px; padding-left: 5px; height: 30px;">
					<option value="year">-- 년</option>
				</select>
				<select name="month" id="month" style="margin-left: 8px; padding-left: 5px; height: 30px;">
					<option value="month">-- 월</option>
				</select>
				<select name="day" id="day" style="margin-left: 8px; padding-left: 5px; height: 30px;">
					<option value="day">-- 일</option>
				</select>
			</div>
			<div id="su-gender">
				<h5>성별 : </h5>
				<input type="radio" value="M" name="gender" id="gender"><h6>남</h6>
				<input type="radio" value="F" name="gender" id="gender"><h6>여</h6>
			</div>
		</div>
	</div>
	
	<jsp:include page="Resource/key/bottom.jsp" flush="false"/>
</body>
</html>