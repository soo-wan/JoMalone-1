<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <!DOCTYPE html>
        <html>
            <head>
                <meta charset="UTF-8">
                <title>Insert title here</title>
                <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
            </head>
        <body>
            <a class="nav-link" href="${pageContext.request.contextPath}/prodPerCategory.admin?category=Citrus">Citrus</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/prodPerCategory.admin?category=Fruits">Fruits</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/prodPerCategory.admin?category=Woody">Woody</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/prodPerCategory.admin?category=Spicy">Spicy</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/prodPerCategory.admin?category=Floral">Floral</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/prodPerCategory.admin?category=Light Floral">Light Floral</a>
        </body>
    </html>