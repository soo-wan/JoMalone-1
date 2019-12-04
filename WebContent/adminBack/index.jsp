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
                <button id="productBtn">상품 등록</button>
                <button id="proListBtn">상품 수정/삭제</button>
                <button id="detailBtn">상세정보 등록</button>
                <button id="detailListBtn">상세정보 수정</button>
                <button id="orderBtn">주문 관리</button>
                <script>
                    $("#productBtn").on("click",function(){
                        location.href = "${pageContext.request.contextPath}/adminBack/insertProduct.jsp";
                    })

                    $("#proListBtn").on("click",function(){
                        location.href = "${pageContext.request.contextPath}/productList.admini";
                    })
                    
                    $("#detailBtn").on("click",function(){
                        location.href = "${pageContext.request.contextPath}/adminBack/insertDetail.jsp";
                    })
                    
                    $("#detailListBtn").on("click",function(){
                        location.href = "${pageContext.request.contextPath}/detailBoard.admini";
                    })
                    
                    $("#orderBtn").on("click",function(){
                        location.href = "${pageContext.request.contextPath}/orderManagement.admini";
                    })
                </script>
            </body>
        </html>