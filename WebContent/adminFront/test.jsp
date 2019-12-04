<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Citrus | Jo Malone</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<style>
   .look {margin: 10px 0px 5px 0px; width: 100px; height: 30px; border: 0px; background-color: #353535; color: white;}
</style>
</head>
<body>
<!--
   <jsp:include page="/Resource/key/top.jsp" flush="false"/>
-->  
   <div class="container">
      <div class="row" style="margin-bottom: 130px;">
         <img src="/JoMalone/Resource/img/citrus-main.jpg" style="margin: 10px 0px 10px 0px; width: 100%;">
         <div style="width: 100%; height: 0px;">
            <div style="position: relative; bottom: 130px; width: 100%; height: 70px; text-align: center; background-color: #FAECC5; opacity: 0.6;"></div>
            <div style="position: relative; bottom: 195px; width: 100%; height: 70px; text-align: center;">
               <h4 style="line-height: 35px;">시트러스 코롱</h4>
               <h6 style="line-height: 20px;">밝고 에너지 넘치는 생기 발랄한 향</h6>
            </div>
         </div>
      </div>
      
      <div class="row" style="margin-bottom: 130px; border: 1px solid green;">
         <div style="margin: 10px auto 20px auto; width: 300px; height: 300px; border: 1px solid red; text-align: center;">
            <img src="/JoMalone/Resource/img/Ci001.jpg">
            <h5 style="margin: 10px 0px 10px 0px; font-size: 17px;">라임 바질 앤 만다린 코롱</h5>
            <h6 style="margin: 5px 0px 5px 0px; font-size: 14px;">$94,000 - $188,000</h6>
            <input class="look" type="button" value="자세히보기">
         </div>
      </div>
   </div>

<!--   
   <jsp:include page="/Resource/key/bottom.jsp" flush="false"/>
-->
</body>
</html>