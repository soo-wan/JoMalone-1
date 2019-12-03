<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 후기 수정</title>
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
.star_rating {font-size:0; letter-spacing:-4px; padding-top: 10px;}
.star_rating a {
    font-size:15px;
    letter-spacing:0;
    display:inline-block;
    margin-left:-1px;
    color:#ccc;
    text-decoration:none;
}
.star_rating a:first-child {margin-left:0;}
.star_rating a.on {color:#ffd800;}
</style>

</head>
<body>
	<form action="modifyConfirm.review" method="post" id="modifyFrm">
		<div class=container>
			<div class="row" style="text-align: center;" id="headDiv">
				<div class="col-12">상품 후기 수정</div>
			</div>
			<div class="row" id=orderNumBox>
				<input type=hidden name=buySeq id=buySeq
					value="${readDTO.order_seq }"> <input type=hidden
					name=reviewSeq id=reviewSeq value="${readDTO.review_seq }">
			</div>
			<div class="row" id=orderProdBox>
				<div class="col-12 p-0"><span style="font-weight:bold;">${readDTO.prod_name }</span></div>
			</div>
			<div class="row" id=starBox>
				<div class="col-12 p-0">
				<p class="star_rating">
					    <a href="#">★</a>
					    <a href="#">★</a>
					    <a href="#">★</a>
					    <a href="#">★</a>
					    <a href="#">★</a>
					</p>
				</div>
				<input type=hidden name="grade" id="grade">
			</div>
			<div class="row" id=titleBox>
				<div class="col-12 p-0">
					<input type=text placeholder="제목을 입력하세요." id="title" name="title"
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
	$(".star_rating a:nth-child(${readDTO.grade})").prevAll("a").addClass("on");
	$(".star_rating a:nth-child(${readDTO.grade})").addClass("on");
			    $( ".star_rating a" ).click(function() {
				    $(this).parent().children("a").removeClass("on");
				    $(this).addClass("on").prevAll("a").addClass("on");
				    return false;
				});
	            var prodMenu = "${readDTO.prod_name}";
	            $("#prodMenu").val(prodMenu);
	            $("#cancel").on("click", function() {
                    var check = confirm("정말 취소하시겠습니까?");
        			if(check){
        				//location.href = "";//마이페이지				
        				location.href = "read.review?no="+${readDTO.review_seq };//원래글
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
                    if($(".star_rating").children(".on").length==0){
                    	alert("별점을 선택해주세요.");
                    	return false;
                    }
                    $("#grade").val($(".star_rating").children(".on").length);
                    document.getElementById("modifyFrm").submit();
                    
                });
                
                $(".summernote").summernote({
        			lang : 'ko-KR',
        			minHeight: 500,
        			maxHeight: 500,    
        			placeholder : "리뷰를 자유롭게 작성해주세요. (사진 업로드 크기는 10MB까지만 가능합니다.)",
        			callbacks : {
        				onImageUpload : function(files) {
        					console.log(files);
        					var data = new FormData();
        					for (var i = 0; i < files.length; i++) {
        						data.append("img" + i, files[i]);
        					}
        					$.ajax({
        						url : "summernote.review",
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