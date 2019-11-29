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


<input type="button" value="로그아웃" id="btn">
<input type="button" value="탈퇴" id="delbtn">
<script>
$("#btn").on("click",function(){
	var result = confirm("정말 로그아웃 하시겠습니까?");
	
	if(result){
		location.href="logout.log";
	}
})
$("#delbtn").on("click",function(){
	var result = confirm("정말 탈퇴 하시겠습니까?");
	
	if(result){
		location.href="pw.jsp";
	}
})

</script>

</body>
</html>