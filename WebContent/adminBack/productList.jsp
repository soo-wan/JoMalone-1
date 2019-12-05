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
                    #wrapper{width:1500px; overflow:hidden; margin:auto;}

                    #container{
                        height:800px;
                        width:1297px;
                        float:left;
                        padding: 20px;
                        overflow-x:scroll;
                        border:1px solid black;
                    }




                    #eachBox{border-bottom: 1px solid black;}
                    #oriCode{display:none;}

                    .firstCol{background-color:#1e2d47; color:white; font-weight:bold; text-align:center; width:100px;}
                    .secondCol{width:300px;}
                    .secondCol_inner{width:100%;}

                    button{margin:2px;}



                </style>
            </head>
            <body>
                <jsp:include page="../Resource/key/topAdmin.jsp" flush="false"/>
                <div id="wrapper">
                    <div class=Wrap>
                        <h4>상품관리</h4>
                        <ul id="sidebar">
                            <li class="menu"><a href="${pageContext.request.contextPath}/adminBack/insertProduct.jsp">상품등록</a></li>
                            <li class="menu"><a href="${pageContext.request.contextPath}/productList.admini">상품 수정/삭제</a></li>
                            <li class="menu"><a href="${pageContext.request.contextPath}/adminBack/insertDetail.jsp">상세 정보 등록</a></li>
                            <li class="menu"><a href="${pageContext.request.contextPath}/detailBoard.admini">상세 정보 수정</a></li>
                        </ul>
                    </div>
                    <div id="container">



                        <c:choose>
                            <c:when test="${productList.size() == 0 }">
                                등록된 상품이 없습니다.
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${productList }" var="dto">

                                    <form action="${pageContext.request.contextPath}/modifyProduct.admini" method="post" id="frm">
 
 
                                        <table id=eachBox>

                                            <tr>
                                                <td class=firstCol>상품 코드</td>
                                                <td class=secondCol><input value="${dto.productCode }" name="fakeProductCode" disabled="disabled" class=secondCol_inner></td>
                                                <td><input type="text" id="oriCode" name="productCode"></td>                                    
                                                <td rowspan=6><img src="Resource/img/${dto.productCode }.jpg"></td>
                                            
                                            </tr>
                                            <tr>
                                                <td class=firstCol>상품 분류</td>
                                                <td class=secondCol><input value="${dto.category }" disabled="disabled" class=secondCol_inner></td>
                                            </tr>
                                            <tr>
                                                <td class=firstCol>상품명</td>
                                                <td class=secondCol><input value="${dto.productName }" name=productName class=secondCol_inner></td>
                                            </tr>
                                            <tr>
                                                <td class=firstCol>가격</td>
                                                <td class=secondCol><input value="${dto.price }" name=price class=secondCol_inner></td>
                                            </tr>
                                            <tr>
                                                <td class=firstCol>수량</td>
                                                <td class=secondCol><input value="${dto.quantity }" name=quantity class=secondCol_inner></td>
                                            </tr>
                                            <tr>
                                                <td class=firstCol>상품정보</td>
                                                <td class=secondCol><textarea value="" name=description class=secondCol_inner rows="8">${dto.description }</textarea></td>
                                            </tr>
                                            <br>
                                            <tr>
                                                <td colspan=2 align=center><button type="button" id=mod>수정</button><button type="button" id=delBtn>삭제</button></td>
                                            </tr>
                                        </table>

                                    </form>	
                                    <br>

                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        <script>
                            $("body").on("click","#mod",function(){
                                var productCode = $(this).closest("#eachBox").find("[name=fakeProductCode]").val();
                                var productName = $(this).closest("#eachBox").find("[name=productName]").val();
                                var price = $(this).closest("#eachBox").find("[name=price]").val();
                                var quantity = $(this).closest("#eachBox").find("[name=quantity]").val();
                                var description = $(this).closest("#eachBox").find("[name=description]").val();

                                console.log(productCode);
                                console.log(productName);
                                console.log(price);
                                console.log(quantity);
                                console.log(description);

                                $("[name=productCode]").val(productCode);
                                $("[name=productName]").val(productName);
                                $("[name=price]").val(price);
                                $("[name=quantity]").val(quantity);
                                $("[name=description]").val(description);
                                
                                if($("[name=productName]").val()==""){
                                	alert("상품명을 입력해주세요"); 
                                	return;
                                }
                                
                                if($("[name=price]").val()==""){
                                	alert("가격을 입력해주세요"); 
                                	return;
                                }
                                
                                if($("[name=quantity]").val()==""){
                                	alert("수량을 입력해주세요"); 
                                	return;
                                }
                                
                                if($("[name=description]").val()==""){
                                	alert("상품정보를 입력해주세요"); 
                                	return;
                                }
                                
                                if(confirm("수정 하시겠습니까?")){
                                    $("#frm").submit();
                                }	
                            })

                            $("body").on("click","#delBtn",function(){
                                var productCode = $(this).closest("#eachBox").find("[name=fakeProductCode]").val();
                                console.log(productCode);
                                if(confirm("삭제 하시겠습니까?")){
                                    location.href = "/JoMalone/deleteProduct.admini?productCode="+productCode;
                                }
                            })
                        </script>



                    </div>
                </div>
            </body>
        </html>