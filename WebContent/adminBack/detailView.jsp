
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
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



                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
                <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
                <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css" rel="stylesheet">
                <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js"></script>





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
       
       
                           .firstCol{width:150px;}
                    #oriCode{display:none;}
         
                                   
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
	                
	                
 
                 <form action="${pageContext.request.contextPath}/modifyDetail.admini" method="post" id="frm" enctype="multipart/form-data">
                    <table>
                        <tr>
                            <td class=firstCol>상품 분류</td>
                            <td><input type="text" id="category" name="category" value="${Product.category}" disabled="disabled"></td>
                            <td rowspan="10"><img id="img" src=""></td>
                        </tr>
                        <tr>
                            <td class=firstCol>상품 코드</td>
                            <td><input type="text" id="productCode" name="productCode" value="${Product.productCode}" disabled="disabled"></td>
                            <input type="text" id="oriCode" name="oriCode" value="${Product.productCode}" >
                        </tr>
                        <tr>
                            <td class=firstCol>상품명</td>
                            <td><input type="text" id="productName" name="productName" value="${Product.productName}" disabled="disabled"></td>
                        </tr>
                        <tr>
                            <td class=firstCol>가격</td>
                            <td><input type="text" id="price" name="price" value="${Product.price}" disabled="disabled"></td>
                        </tr>
                        <tr>
                            <td class=firstCol>수량</td>
                            <td><input type="text" id="quantity" name="quantity" value="${Product.quantity}" disabled="disabled"></td>
                        </tr>
                        <tr>
                            <td name=ingredients class=firstCol>전성분
                            <td><textarea id="ingredients" name="ingredients">${Product.ingredients}</textarea>
                        </tr>
                        <tr>
                            <td class=firstCol>상품 설명</td>
                            <td><textarea id="description" name="description" value="" disabled="disabled">${Product.description}</textarea></td>
                        </tr>
                        <tr>
                            <td class=firstCol>spring</td>
                            <td><input type="text" id="spring" name="spring" value="${Product.spring}" disabled="disabled"></td>
                        </tr>
                        <tr>
                            <td class=firstCol>summer</td>
                            <td><input type="text" id="summer" name="summer" value="${Product.summer}" disabled="disabled"></td>
                        </tr>
                        <tr>
                            <td class=firstCol>fall</td>
                            <td><input type="text" id="fall" name="fall" value="${Product.fall}" disabled="disabled"></td>
                        </tr>
                        <tr>
                            <td class=firstCol>winter</td>
                            <td><input type="text" id="winter" name="winter" value="${Product.winter}" disabled="disabled"></td>
                        </tr>
                    </table>
                    <textarea name="content" id="summernote">${Detail.content }</textarea>
                    <input type="button" id="prePageBtn" value="이전페이지">
                    <input type="button" id="modifyBtn" value="수정">
                    
                </form>
                <script>
	                $("#prePageBtn").on("click", function(){
	                    location.href = "${pageContext.request.contextPath}/detailBoard.admini";
	                })
                    
	                $("body").on("click", "#modifyBtn", function(){
	                	console.log($("#ingredients").val());
	                	console.log($("#oriCode").val());

                        $("#summernote").val($(".note-editable").html());
                        if(confirm("수정 하시겠습니까?")){
                            $("#frm").submit();
                        }
                    })
                    
                    $("#summernote").summernote({
                        height : 500,
                        width : 800,
                        callbacks : {
                            onImageUpload : function(files) {

                                var data = new FormData();
                                data.append("img", files[0]);

                                $.ajax({
                                    url : "${pageContext.request.contextPath}/detailProduct.admini",
                                    enctype : "multipart/form-data",
                                    type : "post",
                                    data : data,
                                    contentType : false,
                                    processData : false,
                                    cache : false,
                                    dataType : "json"
                                }).done(function(resp) {
                                    console.log("성공: " + resp);
                                    var img = $("<img>");
                                    $(img).attr("src", resp.url);
                                    $(".note-editable").append(img);

                                }).fail(function(resp) {
                                    console.log("실패: " + resp);
                                })
                            }
                        }
                    });
                </script>
 
 
 			 
 			 
 			 
 			 
    </div>
    </div>
</body>
</html>