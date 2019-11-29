<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<body>
이메일을 입력해주세요
<form action="pw.find" method="post" id="form">
<input type="text" id="id" name="id">
<input type="text" id="email" name="email">
<input type="submit" id="checkemail" >
</form>

<c:choose>
<c:when test="${result == false}">
<script>
alert("존재하지 않는 이메일입니다");
</script>
</c:when>
</c:choose>

</body>
</html>