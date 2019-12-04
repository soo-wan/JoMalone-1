<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/JoMalone/Resource/css/profile22.css?log=2">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>

<body>
	<jsp:include page="/Resource/key/top.jsp" flush="false"/>
	
	<form action="modi.my" method="post" id="profileform">
	
		<div id="signup-page" class="container">
			<div id="signup-title" class="row"><h4>MY PROFILE</h4></div>
			<div id="signup-inputbox" class="row">
				<div id="su-id"><h5><span>*</span>아이디 : </h5><input type="text" placeholder="Input Your ID" style="width: 200px; height: 30px;" id="id" name="id" value="${dto.id }" readonly></div>
				<br>
				<c:choose>
				<c:when test="${dto.logintype == 'normal'}">
				<div id="su-pw"><h5><span>*</span>패스워드 : </h5><input type="password" placeholder="Input Your PW" style="width: 200px; height: 30px;" id="pw" name="pw"></div>
				<div class="pw regex" style="padding-left: 135px; height: 20px; font-size: 13px;">영어대소문자 및 숫자 8-12자리를 입력하세요.</div>
				<div id="su-pw-check"><h5><span>*</span>패스워드 확인 : </h5><input type="password" placeholder="Input Your PW Check" style="width: 200px; height: 30px;" id="repw"></div>
				<div class="repw regex" style="padding-left: 135px; height: 20px; font-size: 13px;"></div>
				</c:when>
				<c:otherwise>
				<div id="su-pw"><h5><span>*</span>패스워드 : </h5><input type="password" style="width: 200px; height: 30px; background-color:lightgray;" id="pw" name="pw" readonly ></div>
				<br>
				<div id="su-pw-check"><h5><span>*</span>패스워드 확인 : </h5><input type="password"  style="width: 200px; height: 30px; background-color: lightgray;" id="repw" readonly></div>
				<br>
				</c:otherwise>
				</c:choose>
				<div id="su-name"><h5><span>*</span>이름 : </h5><input type="text" placeholder="Input Your Name" style="width: 200px; height: 30px;" name="name" value="${dto.name }" readonly></div>
				<div id="su-phone">
					<h5><span>*</span>전화번호 : </h5>
					<input type="text" name="phone1" id="phone2" style="margin-left: 15px; width: 70px; height: 30px;" value="${dto.phone1 }">
					<span style="margin: 0px 5px 0px 5px; height:30px; color: black;"> - </span>
					<input type="text" name="phone2" id="phone2" style="margin-left: 0px; width: 70px; height: 30px;" value="${dto.phone2 }">
					<span style="margin: 0px 5px 0px 5px; height:30px; color: black;"> - </span>
					<input type="text" name="phone3" id="phone3" style="margin-left: 0px; width: 70px; height: 30px;" value="${dto.phone3 }">
				</div>
				<div id="su-email">
					<h5><span>*</span>이메일 : </h5>
					<input type="text" name="email1" id="email1" style="padding-left: 5px; width: 80px; height: 30px;" value="${dto.email1 }">
					<span style="margin: 0px 5px 0px 5px; height:30px; color: black;">@</span>
					<input type="text" name="email2" style="margin-left: 0px; width: 90px; height: 30px;" value="${dto.email2 }">
					
				</div>
				<div id="su-address" style="height: 110px;">
					<h5><span>*</span>주소 : </h5><input type="text" id="zip_code" name="zip_code" value="${dto.zip_code }"><input type="button" onclick="postcode()" value="주소 찾기"><br>
					<input type="text" id="address1" placeholder="Input Your Road Name Address" style="margin: 8px 0px 0px 15px; width: 250px; height: 30px;" name="address1" value="${dto.address1 }"><br>
					<input type="text" id="address2" placeholder="Input Your Detail Address" style="margin: 8px 0px 0px 135px; width: 250px; height: 30px;" name="address2" value="${dto.address2 }">				
				</div>
				<div id="su-birth">
					<h5>생년월일 : </h5>
					<select name="year" id="year" style="margin-left: 15px; padding-left: 5px; height: 30px;">
						<option value="${dto.year }">${dto.year }</option>
					</select>
					<select name="month" id="month" style="margin-left: 8px; padding-left: 5px; height: 30px;">
						<option value="${dto.month }">${dto.month }</option>
					</select>
					<select name="day" id="day" style="margin-left: 8px; padding-left: 5px; height: 30px;">
						<option value="${dto.day }">${dto.day }</option>
					</select>
				</div>
				<div id="su-gender">
					<h5>성별 : </h5>
					<c:choose>
					<c:when test="${dto.gender == 'M'}">
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
				<input id="profile-modi" type="button" value="수정하기">
				<!-- Button trigger modal -->
				<button type="button" data-toggle="modal" data-target="#exampleModalCenter" id="profile-del">탈퇴하기</button>
				<input id="profile-back" type="button" value="뒤로가기">
			</div>
		</div>

	</form>
	
	<!-- Modal -->

<form action="check.sign" method="post" id="pwform">
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalCenterTitle">비밀번호입력</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <c:choose>
      <c:when test="${dto.logintype == 'normal' }">
      <div class="modal-body">
	    탈퇴하시겠습니까?<br>
	    비빌번호를 입력해주세요.<br><br>
      <input type="password" placeholder="비밀번호입력" id="pw" name="pw" style="text-align: center;">
      </div>
      </c:when>
      <c:otherwise>
      <div class="modal-body">
        	탈퇴하시겠습니까?<br>
      </div>
      </c:otherwise>
      </c:choose>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" id="check" >확인</button>
      </div>
    </div>
  </div>
</div>
</form>


	<script>
	// 주소찾기	
    function postcode() {
        new daum.Postcode({
            oncomplete: function(data) {
            	var roadAddr = data.roadAddress;
                var extraRoadAddr = '';
                document.getElementById("zip_code").value = data.zonecode;
                document.getElementById("address1").value = roadAddr;
            }
        }).open();
    }
	
	
	// 비밀번호유효성검사 영어대소문자 및 숫자 8-12자리
	$("#pw").on("focusout", function() {
		var regex = /^[A-Za-z\d]{8,12}$/;
		var result = regex.exec($("#pw").val())
		if (result == null) {
			$(".pw.regex").html("영어대소문자 및 숫자 8-12자리를 입력하세요.")

		} else {
			$(".pw.regex").html("사용 가능한 비밀번호입니다.")
		}

	})
	// 비밀번호 확인
	$("#repw").on("focusout", function() {
		var pw = $("#pw").val();
		var repw = $("#repw").val();
		if (pw == repw) {
			$(".repw.regex").html("비밀번호가 일치 합니다.")
		} else {
			$(".repw.regex").html("비밀번호가 일치하지 않습니다.")
		}
	})
	
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
	$("#profile-modi").on("click",function(){
			var pw = $("#pw").val();
			var repw = $("#repw").val();
			var phone2 = $("#phone2").val();
			var phone3 = $("#phone3").val();

			var pwregex = /^[A-Za-z\d]{8,12}$/;
			var phoneregex = /^\d{3,4}$/;
			
			if(${dto.logintype == 'normal'}){
				if(pw == ""){
					alert("비밀번호 항목은 필수 입력값입니다.")
					return;
				}
				if(pwregex.exec(pw) == null){
					alert("비밀번호 양식을 다시 확인해주세요.");
					$("#pw").focus();
					return;
				}
				
				if(repw == ""){
					alert("비밀번호 확인을 다시 확인해주세요.");
					$("#repw").focus();
					return;
				}
				if(repw != pw){
					alert("비밀번호가 일치하지 않습니다.");
					$("#repw").focus();
					return;
				}
		
			}
			
			
			$("#profileform").submit();
	});
	
	$("#check").on("click",function(){
		if(${dto.logintype == 'normal'}){
			$("#pwform").submit();
		}else{ 
			location.href = "del.sign";
		}
		
	});
	
	$("#profile-back").on("click", function() {
		location.href = "/JoMalone/Member/mypage.jsp";
	})
	</script>
</body>
</html>