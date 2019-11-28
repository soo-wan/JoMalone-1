<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:choose>
		<c:when test="${result>0 }">
		<script>
		alert("회원가입이 완료되었습니다");
		</script>
		</c:when>
	</c:choose>
</body>
</html>