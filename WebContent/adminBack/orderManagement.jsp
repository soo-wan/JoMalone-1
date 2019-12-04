<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>
            <head>
                <meta charset="UTF-8">
                <title>adminPage</title>
                <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

                <style>
                    #sidebar{ float:left; width:200px; margin:0px; padding:0px; }
                    #sidebar>.menu{ list-style-type: none; text-align: right; margin:auto; color:#1e2d47; text-align:center;
                        padding:0px 10px; margin: 10px; width:80%; line-height:30px; background-color : #1e2d47; color:white;}
                    .menu{height:30px; width:100%; font-family: 'Alata', sans-serif; border:1px solid black; border-radius:3px;}

                    .Wrap{height:800px;  width:200px; margin:0px; float:left; }
                    h4{margin:0px; padding:20px 20px; text-align: right; font-size: 20px; font-family: 'Alata', sans-serif;
                    }
                    .menu>a{text-decoration: none; color:white;}
                    #wrapper{width:1500px; bolder:1px solid black; overflow:hidden; margin:auto; }

                    #container{
                        height:800px;
                        width:1300px;
                        float:left;
                        padding: 20px;
                        overflow-x:scroll;
                        border:1px solid black;
                    }
                </style>
            </head>
            <body>
                <jsp:include page="../Resource/key/topAdmin.jsp" flush="false"/>
                <div id="wrapper">
                    <div class=Wrap>
                        <h4>배송관리</h4>
                        <ul id="sidebar">
                            <li class="menu"><a href="${pageContext.request.contextPath}/orderManagement.admini">배송관리</a></li>
                        </ul>
                    </div>
                    <div id="container">


                        <table>
                            <tr>
                                <th>주문코드</th>
                                <th>결제날짜</th>
                                <th>회원아이디</th>
                                <th>결제품목</th>
                                <th>수량</th>
                                <th>결제상태</th>
                                <th>배송상태</th>
                                <th>환불여부</th>
                            </tr>

                            <c:forEach items="${list }" var="dto">
                                <tr>
                                    <td id=merchant_uid>${dto.merchant_uid}</td>
                                    <td>${dto.order_date}</td>
                                    <td>${dto.mem_id}</td>
                                    <td>${dto.prod_name}</td>
                                    <td>${dto.prod_quantity}</td>
                                    <td>${dto.order_state}</td>
                                    <td><div id=div>${dto.delivery_check}</div><button id=delivery>배송</button></td>
                                    <td>
                                        <c:if test="${dto.refund == 'Y'}"><button>환불</button></c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>

                        <script>
                            $("body").on("click","#delivery",function(){
                                var td = $(this).closest("td");
                                $.ajax({
                                    url:"${pageContext.request.contextPath}/delivery.admini",
                                    type:"post",
                                    data:{merchant_uid:$(this).closest("tr").find("#merchant_uid").html()}
                                }).done(function(data){
                                    if(data == "success"){
                                        td.find("#div").html("배송중");
                                    }else{
                                        location.href="${pageContext.request.contextPath}/adminBack/error.jsp";
                                    }
                                }).fail(function(){
                                });
                            });


                        </script>


                    </div>
                </div>
            </body>
        </html>