<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- 화폐 표시 tag lib -->

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>Insert title here</title>
<style>
* {
	margin: auto;
}
input{
	width:20px;
}
</style>
</head>
<body>
<c:choose>
<c:when test="${list.size() == 0}">
	<div align=center style="margin:100px;">장바구니 내역이 없습니다.</div>
	<div align=center><a href=${pageContext.request.contextPath}/Cart/index.jsp>쇼핑 페이지 이동</a></div>
</c:when>
<c:otherwise>
<p align=center>담은 결과
		<div div align=center class="checkbox"><input type="checkbox" id="ck_all">전체 선택</div>		
<c:forEach items="${list}" var="dto">
	<table border=1>
		<!-- <caption>담은결과</caption> -->
		<!-- <tr align=center><td colspan=2>${dto.seq}번 장바구니</tr> -->
		<tr data-tr_value="${dto.seq}">
			<td style="width: 40px;">
				<input type="checkbox" id="check${dto.seq}" name="checks" class="delcheck">
			</td>
			<td colspan=2>선택</td>
		</tr>
		<tr align=center>
			<td>품명</td>
			<td colspan=2>${dto.prod_name}</td>
			
		</tr>
		<tr align=center>
			<td>가격</td>
			<td colspan=2>${dto.price}</td>
		</tr>
		<tr align=center>
			<td>수량</td>
			<td><input type="text" class="count${dto.seq}" value="${dto.prod_quantity}"></td>
			<td><button id="updateBtn" onclick ="updateCart(${dto.seq})">변경</button></td>
		</tr>	
		<tr align=center>
			<td>합계</td>
			<td colspan=2><fmt:formatNumber value="${dto.price*dto.prod_quantity }" pattern="#,###" />
			<c:set var= "sum" value="${sum + dto.price*dto.prod_quantity}"/>
			</td>
		</tr>
	</table>
<!--	<div align=center><button id="delete" onclick ="deleteCart(${dto.seq})">선택 삭제</button></div>-->
</c:forEach>
	<table>
		<tr>
			<td>총 합계</td>
			<td><fmt:formatNumber value="${sum}" pattern="#,###" /></td>	 <!-- cout 대신에 formatNumber -->	
		</tr>
	</table>
		<div align=center><button id="deleteSelected">선택 삭제</button></div>
		<div align=center><button id="deleteAll">전체 삭제</button></div>
		<div align=center><a href=${pageContext.request.contextPath}/Cart/index.jsp>쇼핑 페이지 이동</a></div>
		<div align=center><a href="#">주문하기</a></div>
		
</c:otherwise>
</c:choose>
	
	<script>
	
	$(".delcheck").on("change",function(){
		if($(this).prop("checked")){
			$(this).val("check");
		}else{
			$(this).val("");
		}

	});
	
		function updateCart(seq){
			var countval = $(".count"+seq).val();
			location.href="update.ca?prod_quantity="+countval+"&seq="+seq;
        }
		
//		function deleteCart(seq){
//	        if(confirm("삭제하시겠습니까?")){
//	            $("input:checkbox[name=checks]:checked").each(function(){
//	            	location.href="delete.ca?seq="+seq;     
//	            });
//	        }else{
//	            return false;
//	        }
//        }
		
		
    // 체크박스 전체 선택&해제
	    $('#ck_all').click(function(){
	         if($("#ck_all").prop("checked")){
	            $("input[type=checkbox]").prop("checked",true); 
	        }else{
	            $("input[type=checkbox]").prop("checked",false); 
	        }
	    });
	    
//	    //동적할당 test
//	   $("body").on("click","#delete",function(){
//	        if(confirm("삭제하시겠습니까?")){
//	            $("input[name=checks]:checked").each(function(){
//	            	var seq = $("#check"+"${dto.seq}").val();
//	                location.href="delete.ca?seq="+seq;
//	            });
//	        }else{
//	            return false;
//	        }
//	    });
	    
		$("#deleteSelected").on("click",function(){ // 선택 체크 삭제
			var check = $(".delcheck").get(); //.get()은 선택한 요소를 배열로 가져온다.
			if(confirm("삭제하시겠습니까?")){
				for(var i=0;i<check.length;i++){
					//console.log(check[i].value);
					if(check[i].value=="check"){
						//console.log(check[i].id);
					//	ArrayList<String> list = new ArrayList<>();
					//	list.add(check[i].id);
						var seq = check[i].id;
					//	location.href="delete.ca?seq="+list;
						console.log(seq);
						$.ajax({
							url:"delete.ca",
							type:"post",		
							data:{
								seq:seq
							},dataType:"json"
						}).done(function(data){
							console.log("성공");
						}).fail(function(){
							console.log("실패");
						});
					}
				}
			}else{
	            return false;
	        }
		});
		
        $("#deleteAll").on("click",function(){
            location.href="deleteAll.ca";
        })
 
    </script>
</body>
</html>