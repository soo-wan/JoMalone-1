<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<style>
* {
	margin: auto;
}
body{
	margin:50px;
}
</style>
</head>
<body>
<div align="center"><a href="prod1.jsp">상품명 : 조말론 향수 1</a></div>
<div align="center">판매가 : 27,900원</div>
<div align="center"><a href="prod1.jsp"><img src="${pageContext.request.contextPath}/image11.gif" width=100 height=100></a></div>
<br>
<br>
<br>
<br>
<div align="center"><a href="prod2.jsp">상품명 : 조말론 향수 2</a></div>
<div align="center">판매가 : 18,900원</div>
<div align="center"><a href="prod2.jsp"><img src="${pageContext.request.contextPath}/image12.gif" width=100 height=100></a></div>
<div align="center"><button id="list">리스트 보기</button></div>
<script>
    $("#list").on("click",function(){
        location.href="../list.ca";
    })
</script>
</body>
</html>