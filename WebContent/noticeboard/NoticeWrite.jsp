<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice Write | Jo Malone</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js"></script>
<script src="/JoMalone/Resource/lang/summernote-ko-KR.js"></script>



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
    
    
    
    
* {box-sizing: border-box;}
	#titleBox {margin-top: 5px; margin-bottom: 5px;}
	* {
	box-sizing: border-box;
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
	input[type=text], textarea {margin-top: 3px; margin-bottom: 3px; font-size: 15px;}
	input[type=button] {width: 100px; height: 30px; border: 0px; background-color: lightgray; font-size: 13px;}	
</style>
</head>
<body>

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
	<form action="/JoMalone/write.notice" method="post" id="writeFrm">
		<div class=container>
			<div class="row" style="text-align: center;" id="headDiv">
				<div class="col-12">공지 작성</div>
			</div>
			<div class="row" id=titleBox>
				<div class="col-12 p-0">
					<input type=text placeholder="제목을 입력해주세요." id="titleNotice" name="title"
						style="width: 100%; text-align:left;">
				</div>
			</div>
			<div class="row" id=contentsBox>
				<div class="col-12 p-0">
					<textarea class="summernote" style="width: 100%;" id="contentsNotice"
						name="contents"></textarea>
				</div>
			</div>
			<hr>
			<div class="row" id=btnBox>
				<div class="col-12 p-0" style="text-align: right;">
					<input type="button" value="취소" id="cancel"> <input
						type="button" value="글쓰기" id="toWrite">
				</div>
			</div>
		</div>
	</form>
			</c:when>
		<c:otherwise>
		<div><p>잘못된 접근입니다.</p></div>
		</c:otherwise>
	</c:choose>
</div>

	<script>
		$("#cancel").on("click", function() {
			var check = confirm("정말 취소하시겠습니까?");
			if(check){
				$('.summernote').summernote('reset');
				location.href = "/JoMalone/list.notice";			
			}
		});
		$("#toWrite").on("click", function() {
			if ($("#titleNotice").val() == "") {
				alert("제목을 입력해주세요.");
				return false;
			}
			if ($("#contentsNotice").val() == "" || $("#contentsNotice").val()=="<p><br></p>") {
				alert("내용을 입력해주세요.");
				return false;
			}
			document.getElementById("writeFrm").submit();
		});

		(function($) {
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
						url : "/JoMalone/summernote.notice",
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
		})(jQuery);
	</script>
</body>
</html>