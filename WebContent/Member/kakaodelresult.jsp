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
<c:when test="${result != null }">
<script>
alert("정상적으로 탈퇴되었습니다.");
location.href="${pageContext.request.contextPath}/home.jsp"
</script>
</c:when>
</c:choose>
</body>
</html>