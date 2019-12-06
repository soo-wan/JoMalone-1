<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Report Admin | Jo Malone</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js"></script>
<script src="/JoMalone/Resource/lang/summernote-ko-KR.js"></script>


<style>
* {
	box-sizing: border-box;
}

input[type=text], textarea {
	margin-top: 3px;
	margin-bottom: 3px;
	font-size: 15px;
}

#write-page {
	margin-top: 80px;
	height: 900px;
}

#write-title {
	margin-bottom: 35px;
	padding: 0px;
	height: 50px;
}



input[type=button] {
	width: 100px;
	height: 30px;
	border: 0px;
	background-color: lightgray;
	font-size: 13px;
}

input[type=button]:hover {
	cursor: pointer;
}

#noticeMsg {
	color: crimson;
}

.clickEdit {
	display: none;
}

#contentsBox {
	padding-top: 10px;
}

#sidebar {
	float: left;
	width: 200px;
	margin: 0px;
	padding: 0px;
}

#sidebar>.menu {
	list-style-type: none;
	text-align: center;
	margin: auto;
	color: #1e2d47;
	text-align: center;
	padding: 0px 10px;
	margin: 10px;
	width: 80%;
	line-height: 30px;
	background-color: #1e2d47;
	color: white;
}

.menu {
	height: 30px;
	width: 100%;
	font-family: 'Alata', sans-serif;
	border: 1px solid black;
	border-radius: 3px;
}

.Wrap {
	height: 800px;
	width: 200px;
	margin: 0px;
	float: left;
}

h4 {
	margin: 0px;
	padding: 20px 20px;
	text-align: center;
	font-size: 20px;
	font-family: 'Alata', sans-serif;
}

.menu>a {
	text-decoration: none;
	color: white;
}

#wrapper {
	width: 1500px;
	bolder: 1px solid black;
	overflow: hidden;
	margin: auto;
}

#container {
	height: 800px;
	width: 1300px;
	float: left;
	padding: 20px;
	overflow-x: scroll;
	border: 1px solid black;
}

textarea {
	height: 100px;
	width: 95%;
}
</style>
</head>
<body>

	<div id="wrapper">
		<div class=Wrap>
			<h4>게시판관리</h4>
			<ul id="sidebar">
				<li class="menu"><a href="list.notice">공지</a></li>
				<li class="menu" id="askNew"><a href="newList.ask">신규 1:1
						문의</a></li>
				<li class="menu" id="askAll"><a href="allList.ask">전체 1:1
						문의</a></li>
				<li class="menu"><a href="newList.report">신규 신고글</a></li>
				<li class="menu"><a href="allList.report">전체 신고글</a></li>
				<li class="menu"><a href="allList.review">리뷰</a></li>
			</ul>
		</div>

		<c:choose>
			<c:when test="${sessionScope.adminId!=null }">
				<form action="dealConfirm.report" method="post" id="writeFrm">
					<div id="write-page" class=container>
						<div id="write-title" class="row">
							<div class="col-12 p-0">
								<h4>REPORT ADMIN</h4>
							</div>
						</div>



						<div class="row checkReportBox">
							<div class="col-12 p-0">

								<c:choose>
									<c:when test="${preCheckDTO.check_YN=='Y'}">
										<!--  -->

										<p style="font-weight: bold;">
											<span style="color: crimson;">*</span> 기존 조치 내역이 있습니다.
										</p>

										<span>* 조치 방안 : <span style="color: crimson;">${preCheckDTO.checkTypeKor }</span></span>
										<br>
										<span>* 조치일 : ${preCheckDTO.checkDateFormedFullDate }</span>
										<br>
										<span>* 신고사유 : ${preCheckDTO.reportTypeKor }</span>
										<br>
										<span>* 추가 기재 메모 : ${preCheckDTO.checkCommentsBlank }</span>
										<br>

										<br>
										<hr>

											<input type="hidden" name="reviewSeq" id="reviewSeq"
												value=${reviewSeq }>
												<p id=reportType style="font-weight: bold;">게시물 관리 대상 접수
													사유를 선택해주세요.</p>
												<input type="radio" name="reportType" value="r1">
												부적절한 홍보<br> <input type="radio" name="reportType"
													value="r2"> 명예훼손/사생활 침해<br> <input
													type="radio" name="reportType" value="r3"> 저작권 침해<br>
												<input type="radio" name="reportType" value="r4"> 스팸<br>
												<input type="radio" name="reportType" value="r5"> 기타<br>
												<p></p>
											
										<p style="font-weight: bold;">해당 리뷰를 어떻게 관리하겠습니까?</p>
										<input type="radio" name="checkType"
											value="${preCheckDTO.check_type }">
										<span style="color: crimson;">기존 조치 유지</span>
										<br>
										<input type="radio" name="checkType" value="none"> 1. 별도 조치 없음<br>
										<input type="radio" name="checkType" value="blind"> 2. 블라인드 처리<br>
										<input type="radio" name="checkType" value="delete"> 3. 삭제 처리<br>
										<br>
										<span>(선택사항)해당 리뷰에 대해 남길 메모가 있다면 작성해주세요.</span>
										<br>
										<textarea id="checkComments" name="checkComments"></textarea>
										<br>
										<input type="checkbox" id="confirmAll">
										<span style="color: crimson; font-weight: bold;">모든 내용을
											확인했습니다.</span>
										<br>

									</c:when>

									<c:otherwise>


										
											<input type="hidden" name="reviewSeq" id="reviewSeq"
												value=${reviewSeq }>
												<p id=reportType style="font-weight: bold;">게시물 관리 대상 접수
													사유를 선택해주세요.</p>
												<input type="radio" name="reportType" value="r1">
												부적절한 홍보<br> <input type="radio" name="reportType"
													value="r2"> 명예훼손/사생활 침해<br> <input
													type="radio" name="reportType" value="r3"> 저작권 침해<br>
												<input type="radio" name="reportType" value="r4"> 스팸<br>
												<input type="radio" name="reportType" value="r5"> 기타<br>
												<p></p>
										
										<p style="font-weight: bold;">해당 리뷰를 어떻게 관리하겠습니까?</p>
										<input type="radio" name="checkType" value="none"> 1. 별도 조치 없음<br>
										<input type="radio" name="checkType" value="blind"> 2. 블라인드 처리<br>
										<input type="radio" name="checkType" value="delete"> 3. 삭제 처리<br>
										<br>
										<span>(선택사항)해당 리뷰에 대해 남길 메모가 있다면 작성해주세요.</span>
										<br>
										<textarea id="checkComments" name="checkComments"></textarea>
										<br>
										<input type="checkbox" id="confirmAll">
										<span style="color: crimson; font-weight: bold;">모든 내용을
											확인했습니다.</span>
										<br>
									</c:otherwise>

								</c:choose>
							</div>
						</div>


						<hr>
						<div class="row" id=btnBox>
							<div class="col-12 p-0" style="text-align: right;" id=innerBtnBox>
								<input type="button" value="취소" id="cancel"> <input
									type="button" value="접수하기" id="toWrite">
							</div>
						</div>
					</div>
				</form>
			</c:when>
			<c:otherwise>
				<div>
					<p>잘못된 접근입니다.</p>
				</div>
			</c:otherwise>
		</c:choose>
	</div>


	<script>
		$("#cancel")
				.on(
						"click",
						function() {
							location.href = "read.review?no=${reviewSeq }&location=adminReviews";//원래 리뷰페이지
						});
		$("#toWrite")
				.on(
						"click",
						function() {
							var check = $('input:radio[name=reportType]').is(
									':checked');
							if (!check) {
								alert("접수 사유를 선택해주세요.");
								return false;
							}
							var check = $('input:radio[name=checkType]').is(
									':checked');
							if (!check) {
								alert("게시물 관리 방법을 선택해주세요.");
								return false;
							}
							var checkBox = $("#confirmAll").prop("checked");
							if (!checkBox) {
								alert("\"모든 내용을 확인했습니다.\"에 체크해주세요.");
								return false;
							}

							var checkConfirm = confirm("선택한 내용대로 진행할까요?");
							if (checkConfirm) {
								$
										.ajax(
												{
													url : "/JoMalone/dealConfirm.report",
													type : "post",
													dataType : "json",
													data : {
														reviewSeq : "${reviewSeq }",
														reportType : $(
																':radio[name="reportType"]:checked')
																.val(),
														checkType : $(
																':radio[name="checkType"]:checked')
																.val(),
														checkComments : $(
																"#checkComments")
																.val()
													}
												})
										.done(
												function(data) {
													console.log(data);
													$("#reportType").remove();
													$("#innerBtnBox").children(
															"input").remove();

													var checkType = '';
													if (data.check_type == "none") {
														checkType = "별도 조치 없음";
													} else if (data.check_type == "blind") {
														checkType = "블라인드";
													} else if (data.check_type == "delete") {
														checkType = "삭제";
													}
													var checkComments = '';
													if (data.check_comments == null) {
														checkComments = "없음";
													} else {
														checkComments = data.check_comments;
													}
													var fillet = '';
													fillet += '<p style="font-weight: bold;">조치 방안 : <span style="color: crimson;">'
															+ checkType
															+ '</span></p>';
													fillet += '<p style="font-weight: bold;">조치일 : <span>'
															+ data.formedDate
															+ '</span></p>';
													fillet += '<p style="font-weight: bold;">추가 기재 메모 : <span>'
															+ checkComments
															+ '</span></p>';
													$(".checkReportBox")
															.children("div")
															.html("").append(
																	fillet);

													var newBtnBox = '<input type="button" value="리뷰목록보기" id="toAllReviews">';
													$("#innerBtnBox").append(
															newBtnBox);

												}).fail(function(data) {

										})
							}

						});

		$(document).on("click", "#toAllReviews", function() {
			location.href = "/JoMalone/allList.review";
		});
	</script>
</body>
</html>