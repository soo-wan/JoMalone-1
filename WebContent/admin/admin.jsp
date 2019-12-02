<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminPage</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="Resource/css/admin.css">
<style>
            .Wrap{
                color:#1e2d47;
                height: 750px;
                text-align: center;
                position: fixed;
                font-family: "나눔고딕",'NanumGothic','Nanum Gothic', /*'돋움', 'Dotum' ,*/Helvetica;
            }
            .Menus{
                border: 1px solid black;
                height: 100%;
                font-size: 20px;	
            }
            .Menu{
                line-height: 120px;
                width: 150px;
                height: 70px;
            }
            .Menu:hover{
                background-color: red;
            }
</style>
</head>
<body>
	<jsp:include page="../Resource/key/topAdmin.jsp" flush="false"/>
	<div class=Wrap>
		<h4>회원 관리</h4>
			<ul></ul>
            <div class=Menus>
                <div class=Menu id=member>회원관리</div>
            </div>
    </div>
</body>
</html>