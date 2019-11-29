<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<body>

이름을 입력해주세요
<input type="text" id="name" name="name">
핸드폰번호를 입력해주세요
<input type="text" id="phone" name="phone">

<input type="button" id="findid" value="확인">

<div id="checkid"></div>

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
		console.log(data.id);
		$("#checkid").html("고객님의 아이디는 "+data.id+"입니다");
		
		
	})
})
</script>
</body>
</html>