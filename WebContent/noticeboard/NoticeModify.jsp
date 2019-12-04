<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice | Jo Malone</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css" rel="stylesheet">
<script	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js"></script>
<script src="Resource/lang/summernote-ko-KR.js"></script>


<style>
* {box-sizing: border-box;}
	#titleBox {margin-top: 5px; margin-bottom: 5px;}
	input[type=text], textarea {margin-top: 3px; margin-bottom: 3px; font-size: 15px;}
	
	#modify-page {margin-top: 80px; height: 900px;}
	#modify-title {margin-bottom: 35px; padding: 0px; height: 50px;}
	#modify-title>h4 {width: 100%; line-height: 45px; text-align: center;}
	
	input[type=button] {width: 100px; height: 30px; border: 0px; background-color: lightgray; font-size: 13px;}
</style>



</head>
<body>
	<form action="modifyConfirm.notice" method="post" id="modifyFrm">
		<div class=container id="modify-page">
			<div id="modify-title" class="row">
				<h4>NOTICE MODIFY</h4>
			</div>
			<div class="row" id=titleBox>
				<div class="col-12 p-0">
				<input type=hidden name=noticeSeq id=noticeSeq value=${readDTO.notice_seq }>
					<input type=text placeholder="제목을 입력해주세요." id="title" name="title"
						style="width: 100%;" value="${readDTO.title }">
				</div>
			</div>
			<div class="row" id=contentsBox>
				<div class="col-12 p-0">
					<textarea class="summernote" style="width: 100%;" id="contents"
						name="contents">${readDTO.contents }</textarea>
				</div>
			</div>
			<hr>
			<div class="row" id=btnBox>
				<div class="col-12 p-0" style="text-align: right;">
					<input type="button" value="취소" id="cancel"> <input
						type="button" value="수정하기" id="toModify">
				</div>
			</div>
		</div>
	</form>




	<script>
	$("#cancel").on("click", function() {
		var check = confirm("정말 취소하시겠습니까?");
		if(check){
			$('.summernote').summernote('reset');
			location.href = "../list.notice";			
		}
	});
	$("#toModify").on("click", function() {
		if ($("#title").val() == "") {
			alert("제목을 입력해주세요.");
			return false;
		}
		if ($("#contents").val() == "") {
			alert("내용을 입력해주세요.");
			return false;
		}
		document.getElementById("modifyFrm").submit();
	});

	$(".summernote").summernote({
		lang : 'ko-KR',
		minHeight: 500,
		maxHeight: 500,    
		placeholder : "공지 내용을 입력해주세요. (사진 업로드 크기는 10MB까지만 가능합니다.)",
		callbacks : {
			onImageUpload : function(files) {
				console.log(files);
				var data = new FormData();
				for (var i = 0; i < files.length; i++) {
					data.append("img" + i, files[i]);
				}
				$.ajax({
					url : "../summernote.notice",
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
	</script>
</body>
</html>