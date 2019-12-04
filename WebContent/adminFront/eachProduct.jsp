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
            <style>
                .season{display: none;}
                #productImg{width:300px; height:400px;}

            </style>
            <body>
                <form action="/JoMalone/insert.ca" method="post">
                    <div>
                        <div>
                            <img id=productImg src="${pageContext.request.contextPath}/Resource/img/${eachProduct.productCode}.jpg" alt=""></div>
                        <div>${eachProduct.productName}</div>
                        <div>${eachProduct.description}</div>
                        <div id=ingredi>${eachProduct.ingredients}</div>
                        <div>
                            <select name="" id="">
                                <option value="" selected>${eachProduct.price}</option>
                            </select>
                        </div>
                        <div id=quantity>
                            <c:choose>
                                <c:when test="${eachProduct.quantity == 0}">
                                    일시적으로 품절된 상품입니다.
                                </c:when>
                            </c:choose>    
                        </div>
                        <div>구매수량<input type="number" name="buy"></div>
                        <button id="basketBtn">장바구니 담기</button>
                        <div id=spring class=season>#봄</div>
                        <div id=summer class=season>#여름</div>
                        <div id=fall class=season>#가을</div>
                        <div id=winter class=season>#겨울</div>
                        <div>${eachProduct.content}</div>
                    </div>
                </form>
                <script>
                    if(${eachProduct.spring} == 1){$("#spring").css("display","block");}
                    if(${eachProduct.summer} == 1){$("#summer").css("display","block");}
                    if(${eachProduct.fall} == 1){$("#fall").css("display","block");}
                    if(${eachProduct.winter} == 1){$("#winter").css("display","block");}

                    var quantityDiv = $("#quantity").html();
                    console.log(quantityDiv);
                    if(quantityDiv.indexOf('품절') != -1){
                        $("#basketBtn").attr("disabled","true");
                    }

                </script>
            </body>
        </html>