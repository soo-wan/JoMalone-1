<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 신고 내역</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<style>
#headDiv {
	padding: 0px;
	margin: 0px;
	padding-top: 20px;
	padding-bottom: 20px;
}

#headDiv>div {
	padding: 0px;
	margin: 0px;	
	
	font-weight: bold;
	font-size: 20px;
	line-height: 30px;
}
.article{
	padding-bottom: 10px;
}
.article:hover{
	background-color: #cbe7ff90;
}
a:link{
	color: black;
}
a:visited{
	color: #887f7f;
}
a:hover{
	text-decoration: none;
}
.naviBar{
	font-size: 20px;
    word-spacing: 5px;
    font-weight: bold;    
}
.naviPage:visited{
	color: black;
}

</style>
</head>

<body>

	<div class=container>
		<div class="row" style="text-align: center;" id="headDiv">
			<div class="col-12">전체 신고 내역</div>
		</div>
		<div class="row" style="text-align: center;">
			<div class="col-3 d-none d-sm-block">신고사유</div>
			<div class="col-3 d-none d-sm-block">제목</div>
			<div class="col-1 d-none d-sm-block">신고자</div>
			<div class="col-3 d-none d-sm-block">신고일</div>
			<div class="col-2 d-none d-sm-block">처리결과</div>			
		</div>
		<hr>
		<c:choose>
			<c:when test="${selectResult.size()==0 }">
				<div class="row">
					<div class="col-12"
						style="text-align: center; height: 500px; line-height: 500px;">새로 등록된 신고글이
						없습니다.</div>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${selectResult }" var="dto">
					<div class="row article p-1" style="text-align: center;">
						<div class="col-3">${dto.report_type }</div>
						<div class="col-3" style="text-align: left;">
						<c:if test="${dto.check_YN eq 'Y' }">
							<span>[확인완료]</span>
						</c:if>
							<a href="read.report?no=${dto.report_seq }&article=${dto.review_seq}&location=allReports">신고합니다.</a>							
						</div>
						<div class="col-1">${dto.mem_id }</div>
						<div class="col-3">${dto.formedFullDate }</div>
						<div class="col-2"><c:if test="${dto.check_type !=null}">${dto.checkTypeKor }</c:if></div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<hr>
		
		
		
		<form action="report.search" method="get" id="searchFrm">
			<div class="row" style="text-align: center;">
				<div class="col-12 searchBar">
					<input type="hidden" name="rootPage" value="fromAdminEntire"> <select
						name="reportSearch" id="reportSearch">
						<option value="contents">내용</option>
						<option value="report_type">신고유형</option>
						<option value="mem_id">아이디</option>
					</select> <input id="searchInput" name="searchInput" type=text> <input
						type="button" value="검색" id="toSearch">
				</div>
			</div>
		</form>
		
		
		
		<div class="row" style="text-align: center;">
			<div class="col-12 naviBar" style="color:black;">${pageNavi }</div>
		</div>
		<div class="row">
			<div class="col-12" style="text-align: right;">
				<input type="button" value="메인으로" id="toIndex"> 
				<input type="button" value="관리자페이지로" id="toAdminPage">
			</div>
		</div>
	</div>
	

	<script>
		$("#toIndex").on("click", function() {
			location.href = "index.jsp";
		});
		$("#toAdminPage").on("click", function() {
			location.href = "";//관리자페이지메인
		});
		
		$("#reportSearch").on("change",function(){
			if($("#reportSearch").val()=="report_type"){
				var reportKor = [null,"부적절한 홍보","명예훼손/사생활 침해","저작권 침해","스팸","기타"];
				$("#searchInput").remove();
				var subSelect ='<select name="reportTypeSearch" id="reportTypeSearch"></select>';
				$("#reportSearch").after(subSelect);
				
				for(var i=1;i<reportKor.length;i++){
					var option = $('<option value="r'+i+'">'+reportKor[i]+'</option>');
					$("#reportTypeSearch").append(option);
				}
				
			}else{
				if($("#reportTypeSearch").length){
					$("#reportTypeSearch").remove();
					$("#reportSearch").after('<input id="searchInput" name="searchInput" type=text>');
				}
			}	
		});
		
		$("#toSearch").on("click", function(){			
			$("#searchFrm").submit();
		});
	</script>
</body>
</html>