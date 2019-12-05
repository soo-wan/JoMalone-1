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



                    
                    .firstCol{background-color:#1e2d47; color:white; font-weight:bold; text-align:center; width:100px;}
                    .secondCol{width:250px;}
                    input,select,textarea{width:100%;}


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






                        <form action="${pageContext.request.contextPath}/insertProduct.admini" method="post" id="frm" enctype="multipart/form-data">
                            <table>
                                <tr>
                                    <td class=firstCol>상품분류
                                    <td class=secondCol>
                                        <select name="category" id="category">
                                            <option value="" selected disabled>카테고리</option> 
                                            <option value="Citrus">Citrus</option>
                                            <option value="Fruits">Fruits</option>
                                            <option value="Light Floral">Light Floral</option>
                                            <option value="Floral">Floral</option>
                                            <option value="Spicy">Spicy</option>
                                            <option value="Woody">Woody</option>
                                            <option value="Others">Others</option>
                                        </select>               
                                    <td rowspan="11"><img id="img">
                                </tr>
                                <tr>
                                    <td class=firstCol>상품 코드</td>
                                    <td class=secondCol><input type="text" name="productCode" id="productCode"></td>
                                </tr>
                                <tr>
                                    <td class=firstCol>상품명</td>
                                    <td class=secondCol><input type="text" name="productName" id="productName"></td>
                                </tr>
                                <tr>
                                    <td class=firstCol>가격</td>
                                    <td class=secondCol><input type="text" name="price" id="price"></td>
                                </tr>
                                <tr>
                                    <td class=firstCol>수량</td>
                                    <td class=secondCol><input type="text" name="quantity" id="quantity"></td>
                                </tr>
                                <tr>
                                    <td class=firstCol>상품 정보</td>
                                    <td class=secondCol><textarea type="text" name="description" id="description"></textarea></td>
                                </tr>
                                <tr>
                                    <td class=firstCol>spring</td>
                                    <td class=secondCol><input type="text" name="spring" id="spring" placeholder="0 또는  1 값을 입력해주세요"></td>
                                </tr>
                                <tr>
                                    <td class=firstCol>summer</td>
                                    <td class=secondCol><input type="text" name="summer" id="summer" placeholder="0 또는  1 값을 입력해주세요"></td>
                                </tr>
                                <tr>
                                    <td class=firstCol>fall</td>
                                    <td class=secondCol><input type="text" name="fall" id="fall" placeholder="0 또는  1 값을 입력해주세요"></td>
                                </tr>
                                <tr>
                                    <td class=firstCol>winter</td>
                                    <td class=secondCol><input type="text" name="winter" id="winter" placeholder="0 또는  1 값을 입력해주세요"></td>
                                </tr>
                                <tr>
                                    <td class=firstCol>상품 이미지</td>
                                    <td class=secondCol><input type="file" name="img" id="img"></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <button type=button id=insertBtn>등록</button>
                                        <button type="button">취소</button>
                                    </td>
                            </table>
                        </form>
                        <script>
                            $("#insertBtn").on("click",function(){
                 

                                if($("#category").val() == null){
                                	alert("카테고리를 선택해주세요"); 
                                	return;
                                }
                                
                                if($("#productCode").val()==""){
                                	alert("상품코드를 입력해주세요"); 
                                	return;
                                }
                                
                                if($("#productName").val()==""){
                                	alert("상품명을 입력해주세요"); 
                                	return;
                                }
                                
                                if($("#price").val()==""){
                                	alert("가격을 입력해주세요"); 
                                	return;
                                }
                                
                                if($("#quantity").val()==""){
                                	alert("수량을 입력해주세요"); 
                                	return;
                                }
                                
                                if($("#description").val()==""){
                                	alert("상품정보를 입력해주세요"); 
                                	return;
                                }
                                
                                if($("#spring").val()=="" || !($("#spring").val()==0 || $("#spring").val()==1)){
                                	alert("spring값을 입력해주세요"); 
                                	return;
                                }
                                
                                if($("#summer").val()==""){
                                	alert("summer값을 입력해주세요"); 
                                	return;
                                }
                                
                                if($("#fall").val()==""){
                                	alert("fall값을 입력해주세요"); 
                                	return;
                                }
                                
                                if($("#winter").val()==""){
                                	alert("winter값을 입력해주세요"); 
                                	return;
                                }
                                
                                if($("#winter").val()==""){
                                	alert("winter값을 입력해주세요"); 
                                	return;
                                }
                                
                                
                                var productCode = $("#productCode").val();
                                $.ajax({
                                    url:"${pageContext.request.contextPath}/checkProduct.admini",
                                    type:"post",
                                    data:{productCode:productCode}
                                }).done(function(result){
                                    if(result == "exist"){
                                        alert('이미 등록된 상품코드 입니다.');
                                        return;
                                    }else{
                                        if(confirm("등록하시겠습니까?")){                         	
                                            $("#frm").submit();
                                        }
                                    }
                                }).fail(function(){
                                    console.log("fail");
                                })
                            })
                        </script>
                    </div>
                </div>
            </body>
        </html>