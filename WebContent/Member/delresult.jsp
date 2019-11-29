<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:choose>
<c:when test="${result >0 }">
<script>
alert("탈퇴되었습니다.");
location.href="${pageContext.request.contextPath}/home.jsp"
</script>
</c:when>
<c:otherwise>
<script>
alert("비밀번호가 일치하지않습니다.");
history.back()
</script>
</c:otherwise>
</c:choose>
</body>
</html>