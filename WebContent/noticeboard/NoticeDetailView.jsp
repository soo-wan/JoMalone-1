<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<style>
#titleBox {
	margin-top: 5px;
	margin-bottom: 5px;
}
#contents {
	padding-top: 10px;
	padding-bottom: 10px;
	min-height: 500px;
}

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

</style>


</head>
<body>

	<div class=container>
		<div class="row" style="text-align: center;" id="headDiv">
			<div class="col-12">공지사항</div>
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


