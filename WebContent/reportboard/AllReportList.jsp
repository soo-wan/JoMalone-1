<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin All Report | Jo Malone</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
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
    
    
    
    
    
	#headDiv {padding: 0px;	margin: 0px; padding-top: 20px;	padding-bottom: 20px;}
	#headDiv>div {padding: 0px; margin: 0px; font-weight: bold; font-size: 20px; line-height: 30px;}
	.article {padding-bottom: 10px;}
	.article:hover {background-color: #cbe7ff90;}	
	a:hover {text-decoration: none;}
.naviBar{
	font-size: 20px;
    word-spacing: 5px;
    font-weight: bold;    
}
.naviPage:visited{
	color: black;
}
input[type="button"] {width: 100px; height: 30px; border: 0px; background-color: lightgray; font-size: 13px;}
</style>
</head>

<body>

<jsp:include page="../Resource/key/topAdmin.jsp" flush="false"/>
<div id="wrapper">
	<div class=Wrap>
		<h4>게시판관리</h4>
			<ul id="sidebar">
			    <li class="menu"><a href="list.notice">공지</a></li>
			    <li class="menu" id="askNew"><a href="newList.ask">신규 1:1 문의</a></li>
			    <li class="menu" id="askAll"><a href="allList.ask">전체 1:1 문의</a></li>
                <li class="menu"><a href="newList.report">신규 신고글</a></li>
                <li class="menu"><a href="allList.report">전체 신고글</a></li>
                <li class="menu"><a href="allList.review">리뷰</a></li>
			</ul>
      </div>
      
      <c:choose>
		<c:when test="${sessionScope.adminId!=null }">		
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
						style="text-align: center; height: 500px; line-height: 500px;">신고글이
						없습니다.</div>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${selectResult }" var="dto">
					<div class="row article p-1" style="text-align: center;">
						<div class="col-3">${dto.reportTypeKor }</div>
						<div class="col-3" style="text-align: left;">
						<c:if test="${dto.check_YN eq 'Y' }">
							<span>[확인완료]</span>
						</c:if>
							<a href="read.report?no=${dto.report_seq }&article=${dto.review_seq}&location=allReports">
							<c:choose>
							<c:when test="${dto.mem_id=='admin1' }">관리자 직접 접수</c:when><c:otherwise>신고합니다</c:otherwise>
							</c:choose>
							</a>							
						</div>
						<div class="col-1"><span id="reporterId">${dto.mem_id }</span></div>
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
			</div>
		</div>
	</div>
	</c:when>
		<c:otherwise>
		<div><p>잘못된 접근입니다.</p></div>
		</c:otherwise>
	</c:choose>
</div>

	<script>

		$("#toIndex").on("click", function() {
			location.href = "home.jsp";
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