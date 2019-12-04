<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Enquiry Detail | Jo Malone</title>
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
                <li class="menu"><a href="#">신규 신고글</a></li>
                <li class="menu"><a href="#">전체 신고글</a></li>
                <li class="menu"><a href="#">리뷰</a></li>
			</ul>
      </div>
	</c:when>
	<c:otherwise>
	<jsp:include page="/Resource/key/top.jsp" flush="true" />
	</c:otherwise>
</c:choose>



	<div class=container>
		<div class="row" style="text-align: center;" id="headDiv">
			<div class="col-12">1:1 문의</div>
		</div>

		<!--                    문의제목-->
		<div class="row">
			<div class="col-12" style="font-weight: bold;">[${readDTO.askCodeKor }]</div>
		</div>
		<div class="row" id="titleBox">
			<div class="col-12">${readDTO.title }</div>
		</div>
		<div class="row" style="font-size: 13px;">
			<form action="modify.ask" method="post" id="modifyFrm">
				<input type=hidden name=askSeq id=askSeq value=${readDTO.ask_seq }>
			</form>
			<input type=hidden name=ansCondition id=ansCondition value=답변상황>
			<div class="col-12">작성일 : ${readDTO.formedFullDate }</div>
		</div>
		<hr>

		<!--                    문의본문-->
		<div class="row">
			<div class="col-12" id=contents>${readDTO.contents}</div>
		</div>
		<div class="row">
			<div class="col-12" id=emailCheck>
			<c:choose>
				<c:when test="${readDTO.email_yn eq 'Y'}">
					<span style="color:green;">이메일 답변 알람을 요청하셨습니다.</span>
				</c:when>
				<c:otherwise>
					<span style="color:crimson;">이메일 답변 알람을 요청하지 않으셨습니다.</span>
				</c:otherwise>
			</c:choose>
			</div>
		</div>
		<hr>
		<div class="row comments">
			<div class="col-12" id="commentsInner">
				<c:choose>
					<c:when test="${coList.size()==0}">
					문의가 접수되었습니다. 문의 접수 후 관리자 답변에 1~2일 정도 소요될 수 있습니다.
                    </c:when>
					<c:otherwise>
						<!-- 댓글 만들기 -->
						<c:forEach items="${coList}" var="co">
							<div class="row commentDiv${co.co_seq} commentBox">
								<div class="col-12">
									<div class="row" style="font-size: 13px;">
										<div class="col-3">관리자</div>
										<div class="col-3">${co.formedFullDate }</div>
										<div class="col-6" align="right">
											<c:choose>
												<c:when test="${sessionScope.adminId !=null}">
													<input type="button" value="수정" id="toCoModify"
														onclick="modifyComment(${co.co_seq},'${co.contents}')">
													<input type="button" value="삭제" id="toCoDelete"
														onclick="deleteComment(${readDTO.ask_seq},${co.co_seq})">
												</c:when>
											</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-12 commentView${co.co_seq}">${co.contents }</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

		<c:choose>
			<c:when test="${sessionScope.adminId !=null}">
				<div class="row coWritingDiv">
					<div class="col-10">
						<textarea rows="3" style="width: 100%;" id="commentWriting"
							name="commentWriting" placeholder="답변 내용을 입력하세요."></textarea>
					</div>
					<div class="col-2">
						<input type="button" value="등록" id="coBtn">
					</div>
				</div>
			</c:when>
		</c:choose>

		<!-- 글 수정삭제버튼 -->
		<hr>
		<div class="row">
			<div class="col-12" style="text-align: right;">
				<input type="button" value="목록" id="toMain"> 
				<c:choose>
	                <c:when test="${sessionScope.loginInfo == readDTO.mem_id}">
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
	var answerCheck = "${readDTO.answer_yn}";
	var adminCheck = "${sessionScope.adminId}";
            $("#toMain").on("click", function() {
            	var fromAdminRoot = "${sessionScope.fromAdminAskPage}";            	
            	console.log(fromAdminRoot);
            	if(fromAdminRoot=="new"){
            		location.href="newList.ask";
            	}else if(fromAdminRoot=="entire"){
                    location.href = "allList.ask";
            	}else if(fromAdminRoot==""){
            		location.href = "list.ask";
            	}
            });

            $("#toModify").on("click", function() {
            	console.log(adminCheck);
            	if(adminCheck!=""){
            		alert("관리자는 수정할 수 없습니다.");
            		return false;
            	}
            	if(answerCheck=="Y"){
            		alert("답변완료된 문의글은 수정할 수 없습니다.");
            		return false;
            	}
            	document.getElementById("modifyFrm").submit();
            });

            $("#toDelete").on("click",function() {
            	if(adminCheck!=""){
            		alert("관리자는 삭제할 수 없습니다.");
            		return false;
            	}
            	if(answerCheck=="Y"){
            		alert("답변완료된 문의글은 삭제할 수 없습니다.");
            		return false;
            	}
                var check = confirm("정말 삭제하시겠습니까?");
                if (check) {
                    location.href = "${pageContext.request.contextPath}/delete.ask?no=${readDTO.ask_seq}";
                }
            });

            $("#coBtn").on("click",function(){
                if ($("#commentWriting").val() == "") {
                    alert("댓글 내용을 입력해주세요.");
                    return false;
                }
                console.log("${readDTO.ask_seq}");

                $.ajax({
                    url : "writeComment.ask",
                    type : "post",
                    dataType : "json",
                    data : {
                        writingSeq : "${readDTO.ask_seq}",
                        contents : $("#commentWriting").val()
                    }
                }).done(function(upload) {
                    $("#commentWriting").val("");
                    $("#commentsInner").html("");                   
                    var writingNo = "${dtoList.ask_seq}";
                    
                    console.log(upload);
                    console.log(upload.co_seq);
                    for(var i=0;i<upload.length;i++){
                        $("#commentsInner").append('<div class="row commentDiv'+upload[i].co_seq+' commentBox"><div class="col-12"><div class="row" style="font-size:13px;">'+
                                                   '<div class="col-3">관리자</div>'+
                                                   '<div class="col-3">'+upload[i].formedFullDate+'</div>'+
                                                   '<div class="col-6" align="right"><input type="button" value="수정" id="toCoModify" onclick="modifyComment('+upload[i].co_seq+',\''+upload[i].contents+'\')"> '+
                                                   '<input type="button" value="삭제" id="toCoDelete" onclick="deleteComment('+writingNo+','+upload[i].co_seq+')">'+
                                                   '</div></div>'+
                                                   '<div class="row"><div class="col-12 commentView'+upload[i].co_seq+'">'+upload[i].contents+'</div></div></div></div>');         					
                    }

                }).fail(function(upload) {
                    console.log(upload);
                });
                
                
            });

            function deleteComment(writingNo,coNo){
                //var check = confirm("정말 삭제하시겠습니까? 댓글 번호 : "+coNo);
                var check = confirm("정말 삭제하시겠습니까?");
                if(check){
                    location.href="${pageContext.request.contextPath}/deleteComment.ask?no="+writingNo+"&coNo="+coNo;            	
                }
            }

            function modifyComment(coNo,coContents){
                //console.log(coNo+" : "+coContents);        	
                var mod = '';
                mod+='<div class="col-11 p-1"><input type="hidden" name="modSeq" value="'+${readDTO.ask_seq }+'"><input type="hidden" name="modCoNo" value="'+coNo+'">';
                mod+='<textarea rows="3" style="width:100%;" id="modComment" name="modComment">'+coContents+'</textarea></div>';
                mod+='<div class="col-1 p-0"><input type="button" value="수정" id="toCoModifyConfirm">';
                mod+='<input type="button" value="취소" id="toCoModifyCancel"></div>';

                $(".commentView"+coNo).parent("div").wrap('<form action="modifyCommentConfirm.ask" method="post" id="modCoFrm"></form>');
                $(".commentView"+coNo).parent("div").html("").append(mod);

                //console.log($(".commentDiv"+coNo).find("#toCoModify"));
                $(".commentDiv"+coNo).find("#toCoModify").attr("type","hidden");
                $(".commentDiv"+coNo).find("#toCoDelete").attr("type","hidden");
            }        

            $(document).on("click","#toCoModifyConfirm",function(){
                var check = confirm("수정하시겠습니까?");
                if(check){
                    document.getElementById("modCoFrm").submit();
                }
            });

            $(document).on("click","#toCoModifyCancel",function(){
                var check = confirm("댓글 수정을 취소 하시겠습니까?");
                if(check){
                    location.href="read.ask?no="+${readDTO.ask_seq };
                }
            });                    

        </script>
        
</body>
</html>


