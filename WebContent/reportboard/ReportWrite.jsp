<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 신고</title>
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
<script src="Resource/lang/summernote-ko-KR.js"></script>


<style>
* {
	box-sizing: border-box;
}

#titleBox {
	margin-top: 5px;
	margin-bottom: 5px;
}

input[type=text], textarea {
	margin-top: 3px;
	margin-bottom: 3px;
	font-size: 15px;
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

#notice{
	color: crimson;
}
.clickEdit{
	display: none;
}
#contentsBox{
	padding-top: 10px;
}
</style>
</head>
<body>
	<form action="writeConfirm.report" method="post" id="writeFrm">
		<div class=container>
			<div class="row" style="text-align: center;" id="headDiv">
				<div class="col-12">신고글 작성</div>
			</div>
			<div class="row" id=reportType>
				<div class="col-12 p-0">
				<input type="hidden" name="articleSeq" id="articleSeq" value=${reportSeq }>
				<p id=reportType style="font-weight: bold;">신고 사유를 선택해주세요.</p>
					<input type="radio" name="reportType" value="r1"> 부적절한 홍보<br> <input
						type="radio" name="reportType" value="r2"> 명예훼손/사생활 침해<br> <input
						type="radio" name="reportType" value="r3"> 저작권 침해<br> <input
						type="radio" name="reportType" value="r4"> 스팸<br> <input
						type="radio" name="reportType" value="r5"> 기타<br>
						<p></p>
				<p id=notice>모든 신고는 관리자 검토 후 처리되며, 신고에 대한 조치내용은 별도 통보되지 않습니다.</p>
				</div>
			</div>
			<div class="row">
				<div class="col-12 p-0">
				<input type="button" value="내용추가작성" id="edit">
				<input type="button" value="내용작성창닫기" id="save">
				</div>
			</div>
			<div class="row" id=contentsBox>
				<div class="col-12 p-0 clickEdit">
					<textarea class="summernote" style="width: 100%;" id="contents"
						name="contents"></textarea>
				</div>
			</div>
			<hr>
			<div class="row" id=btnBox>
				<div class="col-12 p-0" style="text-align: right;">
					<input type="button" value="취소" id="cancel"> <input
						type="button" value="신고하기" id="toWrite">
				</div>
			</div>
		</div>
	</form>


	<script>
       $("#cancel").on("click", function() {
           location.href = "read.review?no=${reportSeq }";//원래 리뷰페이지
       });
       $("#toWrite").on("click", function() {
       	var check = $('input:radio[name=reportType]').is(':checked');
       	if(!check){
       		alert("신고 사유를 선택해주세요.");
       		return false;
       	}
       	alert("신고접수가 완료되었습니다.");
       	document.getElementById("writeFrm").submit();
       });
       
       $("#edit").on("click",function(){
       	$('.clickEdit').css("display","block");
       	$(".summernote").summernote({
   			lang : 'ko-KR',
   			minHeight: 300,
   			maxHeight: 300,    
   			focus: true,
   			placeholder : "추가로 기재할 내용이 있다면 작성해주세요. (사진 업로드 크기는 10MB까지만 가능합니다.)",
   			callbacks : {
   				onImageUpload : function(files) {
   					console.log(files);
   					var data = new FormData();
   					for (var i = 0; i < files.length; i++) {
   						data.append("img" + i, files[i]);
   					}
   					$.ajax({
   						url : "summernote.report",
   						enctype : "multipart/form-data",
   						type : "post",
   						data : data,
   						contentType : false,
   						processData : false,
   						cache : false,
   						dataType : "json"
   					}).done(function(resp) {
   						console.log(resp);
   						console.log(resp.length);
   						for (var i = 0; i < resp.length; i++) {
   							var imgBox = document.createElement("p");
   							var imgTag = document.createElement("img");
   							$(imgTag).attr("src", resp[i].url);
   							$(imgTag).attr("style", "max-width: 80%; height: auto;");
   							imgBox.append(imgTag);
   							$(".summernote").summernote('insertNode', imgBox);
   						}
   						var pTag = "<p><br></p>";
   						$(".summernote").summernote('pasteHTML', pTag);
   						$('.summernote').summernote('focus');
   					}).fail(function(resp) {

   					})
   				}
   			}
   		});
       });
       
       $("#save").on("click",function(){
          	//$('.summernote').summernote('reset');
          	$('.clickEdit').css("display","none");
      	  	$('.summernote').summernote('destroy');                	
       });
 	</script>
</body>
</html>