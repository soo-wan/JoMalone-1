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
                    <table id=tableInfo>
                        <tr>
                            <td>상품 코드</td>
                            <td><input type="text" name="productCode"></td>
                        </tr>
                        <tr>
                            <td>상품 분류</td>
                            <td><input type="text" name="category"></td>
                        </tr>
                        <tr>
                            <td>상품명</td>
                            <td><input type="text" name="productName"></td>
                        </tr>
                        <tr>
                            <td>가격</td>
                            <td><input type="text" name="price"></td>
                        </tr>
                        <tr>
                            <td>수량</td>
                            <td><input type="text" name="quantity"></td>
                        </tr>
                        <tr>
                            <td>상품 정보</td>
                            <td><textarea type="text" name="description"></textarea></td>
                        </tr>
                        <tr>
                            <td>spring</td>
                            <td><input type="text" name="spring"></td>
                        </tr>
                        <tr>
                            <td>summer</td>
                            <td><input type="text" name="summer"></td>
                        </tr>
                        <tr>
                            <td>fall</td>
                            <td><input type="text" name="fall"></td>
                        </tr>
                        <tr>
                            <td>winter</td>
                            <td><input type="text" name="winter"></td>
                        </tr>
                        <tr>
                            <td>상품 이미지</td>
                            <td><input type="file" name="img"></td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <button type="button" id=modifyBtn>수정</button>
                                <button type="button" id=cancelBtn>취소</button>
                            </td>
                    </table>
                      
            </body>
            <script>

                $("#cancelBtn").on("click",function(){
                    window.close();
                })
                
                $("#modifyBtn").on("click",function(){
                	var oriCode = $(opener.document).find("#oriCode").val();
                	if(confirm("수정하시겠습니까?")){
                		var data = new FormData();
                		data.append("productCode",$("[name=productCode]").val());
                		data.append("category",$("[name=category]").val());
                		data.append("productName",$("[name=productName]").val());
                		data.append("price",$("[name=price]").val());
                		data.append("quantity",$("[name=quantity]").val());
                		data.append("description",$("[name=description]").val());
                		data.append("spring",$("[name=spring]").val());
                		data.append("summer",$("[name=summer]").val());
                		data.append("fall",$("[name=fall]").val());
                		data.append("winter",$("[name=winter]").val());
                		data.append("img",$("[name=img]")[0].files[0]);
                		data.append("oriCode", oriCode);
                		
                		$.ajax({
                			url:"${pageContext.request.contextPath}/modifyProduct.admini",
                			type:"post",
                			enctype: "multipart/form-data",
                			data:data,
                			contentType:false,
                            processData:false,
                            cache:false
                		}).done(function(data){
                			if(data == "success"){
                				alert("수정 완료");
                				window.close();
                				opener.location.href="${pageContext.request.contextPath}/productList.admini";
                			}else{
                				window.close();
                				opener.location.href="${pageContext.request.contextPath}/adminBack/error.jsp";
                			}
                		}).fail(function(){
                			console.log("실패");
                		});
                		
                	}else{
                		return false;
                	}
                })
                
            </script>
        </html>