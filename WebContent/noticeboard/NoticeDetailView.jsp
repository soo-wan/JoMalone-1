<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice Detail | Jo Malone</title>
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
    
    
    
	#titleBox {margin-top: 5px; margin-bottom: 5px;}
	#contents {padding-top: 10px; padding-bottom: 10px;	min-height: 500px;}
	#detail-page {margin-top: 80px;}
	#detail-title {margin-bottom: 30px; padding: 0px; height: 50px;}
	#detail-title>h4 {width: 100%; line-height: 45px; text-align: center;}
	
	input[type="button"] {width: 100px; height: 30px; border: 0px; background-color: lightgray; font-size: 13px;}
</style>


</head>
<body>

	<c:choose>
	<c:when test="${sessionScope.adminId !=null}">
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
	</c:when>
	<c:otherwise>
	<jsp:include page="/Resource/key/top.jsp" flush="true" />
	</c:otherwise>
</c:choose>




	<div class=container>
		<div class="row" style="text-align: center;" id="headDiv">
			<div class="col-12"><h3>공지</h3></div>
		</div>

		<div class="row" id="titleBox">
			<div class="col-12" style="font-weight:bold;">${readDTO.title }</div>
		</div>
		<div class="row" style="font-size: 13px;">
			<form action="modify.notice" method="post" id="modifyFrm">
				<input type=hidden name=noticeSeq id=noticeSeq value=${readDTO.notice_seq }>
			</form>
			<div class="col-3">공지번호 : ${readDTO.notice_seq }</div>
			<div class="col-9">작성일 : ${readDTO.formedFullDate }</div>
		</div>
		<hr>
		<div class="row">
			<div class="col-12" id=contents>${readDTO.contents}</div>
		</div>
		<hr>
		<div class="row">
			<div class="col-12" style="text-align: right;">
				<input type="button" value="목록" id="toMainNotice"> 
				<c:choose>
	                <c:when test="${sessionScope.adminId != null}">
	                    <input type="button" value="수정" id="toModify">
	                    <input type="button" value="삭제" id="toDelete">
	                </c:when>
                </c:choose>				
			</div>
		</div>
		<br>
	</div>
<c:choose>
		<c:when test="${sessionScope.adminId !=null}">
		</div>
		</c:when>
		<c:otherwise>
		<jsp:include page="/Resource/key/bottom.jsp" flush="true" />
		</c:otherwise>
	</c:choose>
	<script>
            $("#toMainNotice").on("click", function() {
            	location.href="list.notice";
            });

            $("#toModify").on("click", function() {
            	document.getElementById("modifyFrm").submit();
            });

            $("#toDelete").on("click",function() {
                var check = confirm("정말 삭제하시겠습니까?");
                if (check) {
                    location.href = "${pageContext.request.contextPath}/delete.notice?no=${readDTO.notice_seq}";
                }
            });
                      
        </script>
        
</body>
</html>


