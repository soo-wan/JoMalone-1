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
                <c:forEach items="${list}" var="eachProduct">
                    <div>
                        <div> 
                            <a href="${pageContext.request.contextPath}/eachProduct.admin?productCode=${eachProduct.productCode}"><img src="${pageContext.request.contextPath}/Resource/img/${eachProduct.productCode}.jpg" alt=""></a>
                        </div>
                        <div>
                            <a href="${pageContext.request.contextPath}/eachProduct.admin?productCode=${eachProduct.productCode}">${eachProduct.productName}</a>
                        </div>
                        <div>${eachProduct.price}</div>
                    </div>
                </c:forEach>
            </body>
        </html>