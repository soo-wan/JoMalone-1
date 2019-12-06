<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login | Jo Malone</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="/JoMalone/Resource/css/login.css">
<style>
	#check {padding-left: 30px; font-size: 13px; text-align: left;}
</style>
</head>
<body>
	<jsp:include page="/Resource/key/top.jsp" flush="false" />
	<%
		String clientId = "VsJ9BGH2srkgM7uumvNE";//애플리케이션 클라이언트 아이디값";
		String redirectURI = URLEncoder.encode("http://localhost:8080/JoMalone/Ncallback", "UTF-8");
		// 상태 토큰으로 사용할 랜덤 문자열 생성
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130, random).toString();
		String napiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
		napiURL += "&client_id=" + clientId;
		napiURL += "&redirect_uri=" + redirectURI;
		napiURL += "&state=" + state;
		session.setAttribute("state", state);
		
		String kapiURL = "https://kauth.kakao.com/oauth/authorize?";
		kapiURL += "client_id=6d5630d4385069dbc2b5bcdc92d10cd4";
		kapiURL += "&redirect_uri=http://192.168.60.32:8080/JoMalone/Kcallback&response_type=code";
	%>
	
	<div id="general-login" class="container">
		<div id="login-title" class="row">
			<h4>LOGIN</h4>
		</div>
		<div id="login-inputbox" class="row">
			<div id="login-id" class="col-12">
				<input type="text" placeholder="Input Your ID " name="id" id="id">
			</div>
			<div id="login-pw" class="col-12">
				<input type="password" placeholder="Input Your PW " name="pw" id="pw">
			</div>
			<div id="check" class="col-12"></div>
			<div id="cookie-check" class="col-12">
				<input type="checkbox" id="rem">
				<h6>아이디저장</h6>
			</div>
			<div id="login-btn" class="col-12">
				<input type="button" value="LOGIN" id="loginbtn">
			</div>
			<div id="button-list" class="col-12">
				<input type="button" value="FIND ID" id="general-findid"> <input
					type="button" value="FIND PW" id="general-findpw" > <input
					type="button" value="SIGN UP" id="general-signup">
			</div>
		</div>
	</div>
	
	<c:choose>
		<c:when test="${result>0 }">
		<script>
			alert("회원가입이 완료되었습니다.");
			location.href = "login.jsp";
		</script>
		</c:when>
	</c:choose>

	<div id="sns-login" class="container">
		<div id="sns-title" class="row">
			<h5>SNS 간편 로그인</h5>
		</div>
		<hr style="margin-bottom: 30px;">
		<div id="sns-btn" class="row">
			<div id="kakao" class="col-12">
				<img src="/JoMalone/Resource/img/kakao.png">
				<h5>카카오 로그인</h5>
			</div>
			<div id="naver" class="col-12">
				<img src="/JoMalone/Resource/img/naver.jpg">
				<h5>네이버 로그인</h5>
			</div>
		</div>
	</div>

	<script>
		$("#general-signup").on("click", function() {
			location.href = "signup.jsp";
		})
		
		$("#loginbtn").on("click",function(){
		$.ajax({
			url:"login.log",
			type:"post",
			data:{
				id : $("#id").val(),
				pw : $("#pw").val()
				
			},
			dataType:"json"
		}).done(function(data){
			console.log(data.id);
			if(data.result == "false"){
				$("#check").html("아이디 및 비밀번호를 확인해주세요.");
			}else{
				alert("로그인되었습니다.")
				if(data.id == "admin1"){
					location.href="${pageContext.request.contextPath}/admin.mem"	
				}else{
				location.href="${pageContext.request.contextPath}/home.jsp"
					
				}
			}
			
		})
	})
	$(document).ready(function() {
            $("#pw").keydown(function(key) {
                if (key.keyCode == 13) {
                	$.ajax({
            			url:"login.log",
            			type:"post",
            			data:{
            				id : $("#id").val(),
            				pw : $("#pw").val()
            				
            			},
            			dataType:"json"
            		}).done(function(data){
            			console.log(data.id);
            			if(data.result == "false"){
            				$("#check").html("아이디 및 비밀번호를 확인해주세요.");
            			}else{
            				alert("로그인되었습니다.")
            				if(data.id == "admin1"){
            					location.href="${pageContext.request.contextPath}/admin.mem"	
            				}else{
            				location.href="${pageContext.request.contextPath}/home.jsp"
            					
            				}
            			}
            			
            		})
                	
                	
                	
                }
            });
        });


출처: https://alpreah.tistory.com/101 [생각에 취하는날]
	
 		$("#naver").on("click",function(){
	 		location.href = "<%=napiURL%>"
		})
		$("#kakao").on("click",function(){
	 		location.href = "<%=kapiURL%>"
		})
		
		$("#general-findid").on("click",function(){
			location.href="findid.jsp"
		})
		$("#general-findpw").on("click",function(){
			location.href="findpw.jsp"
		})
		
		//아이디기억하기
		function cookieAsJSON() {
			var cookieJSON = {};
			var cookie = document.cookie;
			console.log(cookie);
			var trimedCookie = cookie.replace(/ /g, "");
			console.log(trimedCookie);
			var entryArr = trimedCookie.split(";");
			console.log(entryArr);
			for (var i = 0; i < entryArr.length; i++) {
				var entry = entryArr[i].split("=");
				console.log(entry);
			}
			cookieJSON[entry[0]] = entry[1];
			return cookieJSON;
		}

		$("#rem").on("change", function() {
			var exDate = new Date();
			if ($("#rem").prop("checked")) {
				exDate.setDate(exDate.getDate() + 30);
				var id = $("#id").val();
				document.cookie = "id=" + id + ";expires=" + exDate.toString();
			} else {
				exDate.setDate(exDate.getDate() - 1);
				document.cookie = "id=+;expires=" + exDate.toString();
			}
		})
		$(function() {
			if (document.cookie != "") {
				var cookie = cookieAsJSON();
				$("#id").val(cookie.id);
				$("#rem").prop("checked", "true");
			}
		});
	</script>

	<jsp:include page="/Resource/key/bottom.jsp" flush="false" />
</body>
</html>