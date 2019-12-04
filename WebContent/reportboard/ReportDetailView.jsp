<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Report Detail | Jo Malone</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<style>
#titleBox {margin-top: 5px; margin-bottom: 5px;}
	#contents {padding-top: 10px; padding-bottom: 10px;	min-height: 500px;}
	#coBtn {height: 93%; width: 100%;}
	.commentBox { /*border-bottom: 1px solid #49498690;*/
		border: 1px solid #49498660; padding-top: 15px; padding-bottom: 15px; margin-left: 10px; margin-right: 10px; margin-bottom: 2px;}
	#toCoModify, #toCoDelete {font-size: 13px; line-height: 20px;}
	#toCoModifyConfirm, #toCoModifyCancel {margin-top: 3.5px; width: 100%; height: 40%;	line-height: 30px;}
	.coWritingDiv {padding-top: 20px;}
	#emailCheck{font-size: 15px;}

	#detail-page {margin-top: 80px;}

	#detail-title {margin-bottom: 30px; padding: 0px; height: 50px;}
	#detail-title>h4 {width: 100%; line-height: 45px; text-align: center;}
	
	input[type="button"] {width: 100px; height: 30px; border: 0px; background-color: lightgray; font-size: 13px;}

textarea {
	height: 100px;
	width: 95%;
}
</style>


</head>
<body>
	<jsp:include page="/Resource/key/top.jsp" flush="true" />
	<div class=container id="detail-page">
		<div id="detail-title" class="row">
			<h4>REPORT DETAIL</h4>
		</div>

		<!--                    문의제목-->
		<div class="row">
			<div class="col-12" style="font-weight: bold;">[${resultDTO.reportTypeKor }]</div>
		</div>
		<div class="row" id="titleBox">
			<div class="col-12">신고합니다.</div>
		</div>
		<div class="row" style="font-size: 13px;">
			<div class="col-12">${resultDTO.formedFullDate }</div>
		</div>
		<hr>

		<!--                    문의본문-->
		<div class="row">
			<div class="col-12" id=contents>
				<p style="font-weight: bold;">
					신고 사유 : <span style="color: crimson;">${resultDTO.reportTypeKor }</span>
				</p>
				<p>${resultDTO.contents }</p>
			</div>
		</div>

		<!-- 신고글 새창으로 링크열기 -->
		<hr>
		<div class="row">
			<div class="col-12" id=originArticle>
				<p style="font-weight: bold;">신고된 리뷰 정보</p>
				<span>누적 신고 횟수 : 총 ${accumulation }회</span><br> <br>
				<p>
					<a href="read.review?no=${resultDTO.review_seq }&location=report" target="_blank">신고된
						리뷰 보기</a>
				</p>
			</div>
		</div>
		<!-- 신고글 처리하기 -->
		<hr>
		<div class="row checkReportBox">
			<div class="col-12">
					
				<c:choose>
					<c:when test="${preCheckDTO.check_YN!=null && resultDTO.check_YN != 'Y'}">
						<c:if test="${preCheckDTO.check_YN == 'Y'}">					
							<p style="font-weight: bold;"><span style="color: crimson;">*</span> 기존 조치 내역이 있습니다.</p>
							
							<span>조치 방안 : <span style="color: crimson;">${preCheckDTO.checkTypeKor }</span></span><br>
							<span>조치일 : ${preCheckDTO.checkDateFormedFullDate }</span><br>
							<span>추가 기재 메모 : ${preCheckDTO.checkCommentsBlank }</span><br>							
						</c:if>
						<br>
						<c:if test="${preCheckDTO.check_type == 'none' || preCheckDTO.check_type == 'blind'}">
							<p style="font-weight: bold;">다시 신고된 리뷰를 어떻게 관리하겠습니까?</p>						
							<input type="radio" name="checkType" value="${preCheckDTO.check_type }"> <span style="color:crimson;">기존 조치 유지</span><br>
							<input type="radio" name="checkType" value="none"> 1. 별도 조치 없음<br>
							<input type="radio" name="checkType" value="blind"> 2. 블라인드 처리<br>
							<input type="radio" name="checkType" value="delete"> 3. 삭제 처리<br>
							<br>
							<span>(선택사항)신고된 리뷰에 대해 남길 메모가 있다면 작성해주세요.</span>
							<br>
							<textarea id="checkComments" name="checkComments"></textarea>
							<br>
							<input type="checkbox" id="confirmAll">
							<span style="color: crimson; font-weight: bold;">모든 내용을
								확인했습니다.</span>
							<br>
							<br>
							<input type="button" value="확인" id=reportConfirm>
						</c:if>						
					</c:when>
					
					<c:when test="${preCheckDTO.check_YN==null && resultDTO.check_YN != 'Y'}">
						<p style="font-weight: bold;">신고된 리뷰를 어떻게 관리하겠습니까?</p>						
						<input type="radio" name="checkType" value="none"> 1. 별도 조치 없음<br>
						<input type="radio" name="checkType" value="blind"> 2. 블라인드 처리<br>
						<input type="radio" name="checkType" value="delete"> 3. 삭제 처리<br>
						<br>
						<span>(선택사항)신고된 리뷰에 대해 남길 메모가 있다면 작성해주세요.</span>
						<br>
						<textarea id="checkComments" name="checkComments"></textarea>
						<br>
						<input type="checkbox" id="confirmAll">
						<span style="color: crimson; font-weight: bold;">모든 내용을
							확인했습니다.</span>
						<br>
						<br>
						<input type="button" value="확인" id=reportConfirm>
					</c:when>
					<c:when test="${resultDTO.check_YN == 'Y' }">
						<p style="font-weight: bold;">조치 방안 : <span style="color: crimson;">${resultDTO.checkTypeKor }</span></p>
						<p style="font-weight: bold;">조치일 : <span>${resultDTO.checkDateFormedFullDate }</span></p>
						<p style="font-weight: bold;">추가 기재 메모 : <span>${resultDTO.checkCommentsBlank }</span></p>								
					</c:when>
				</c:choose>
			</div>
		</div>

		<!-- 
		</form>
		 -->

		<!-- 버튼 -->
		<hr>
		<div class="row">
			<div class="col-12" style="text-align: right;">
				<input type="button" value="목록" id="toMain">
			</div>
		</div>

	</div>

	<script>	
		$("#toMain").on("click", function() {
			var root = "${root}";
            if(root=="newReports"){
            	location.href = "newList.report";
            }else if(root=="allReports"){
            	location.href = "allList.report";            	
            }
 		});
		$("#reportConfirm")
				.on(
						"click",
						function() {
							var check = $('input:radio[name=checkType]').is(
									':checked');
							if (!check) {
								alert("신고글 관리 방법을 선택해주세요.");
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
													url : "check.report",
													type : "post",
													dataType : "json",
													data : {
														reportSeq : "${resultDTO.report_seq }",
														reviewSeq : "${resultDTO.review_seq }",
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

												}).fail(function(data) {

										})
							}

						});
	</script>


</body>
</html>


