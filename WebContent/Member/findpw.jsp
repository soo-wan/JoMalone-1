<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="/JoMalone/Resource/css/find.css?log=1">
</head>

<body>
<jsp:include page="/Resource/key/top.jsp" flush="false"/>

<div id="find" class="container">
	<div id="find-title" class="row">
		<h4>Find PW</h4>
	</div>
<div id="findinputbox">
<form action="pw.find" method="post" id="form">
아이디를 입력해주세요<br>
<input type="text" id="id" name="id"><br>
<br>
이메일을 입력해주세요<br>
<input type="text" id="email" name="email"><br>
<div id="findbtn">
<br>
<input type="submit" id="checkemail" >
</div>
</form>
</div>
</div>
<c:choose>
<c:when test="${result == false}">
<script>
alert("존재하지 않는 이메일입니다");
</script>
</c:when>
<c:when test="${result == true }">
<script>
alert("이메일로 임시비밀번호가 전송되었습니다.")
</script>
</c:when>
</c:choose>
	<jsp:include page="/Resource/key/bottom.jsp" flush="false" />
</body>

</html>