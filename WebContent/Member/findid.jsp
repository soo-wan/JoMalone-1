<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="/JoMalone/Resource/css/find.css?log=2">
<style>

</style>
</head>
<body>
<jsp:include page="/Resource/key/top.jsp" flush="false"/>
<div id="find" class="container">
	<div id="find-title" class="row">
		<h4>Find ID</h4>
</div>
<div id="findinputbox">
이름을 입력해주세요<br>
<input type="text" id="name" name="name"><br>
<br>
'-'를 붙혀 핸드폰번호를 입력해주세요<br>
<input type="text" id="phone" name="phone" placeholder="'-'를 붙혀 번호를 입력해주세요"><br>
<br>
<div id="findbtn">
<input type="button"  id="findid" value="확인">
</div>
<br>
<div id="checkid"></div>
</div>
</div>
<script>
$("#findid").on("click",function(){
	$.ajax({
		url:"id.find",
		type:"post",
		data:{
			name : $("#name").val(),
			phone : $("#phone").val()
			
		},
		dataType:"json"
	}).done(function(data){
		if(data.id != null){
		$("#checkid").html("고객님의 아이디는 "+data.id+"입니다");			
		}else if(data.nullid != null){
			alert("존재하지 않는 정보 입니다");
		}
		
		
	})
})
</script>
<jsp:include page="/Resource/key/bottom.jsp" flush="false"/>
</body>
</html>