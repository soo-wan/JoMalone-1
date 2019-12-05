<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>
        <head>
            <meta charset="UTF-8">
            <title>Goods Detail | Jo Malone</title>
            <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
            <style>

            </style>
        </head>
        <body>
            <jsp:include page="/Resource/key/top.jsp" flush="false"/>

            <form action=../insert.ca method=post id="frm">
                <input type=hidden name=seq value="1"> <!-- value값을 seq -->
                <div class="container" style="margin: 70px auto 70px auto; height: 600px; background-color: #FAECC5;">
                    <div class="row" style="margin: auto;">
                        <img src="/JoMalone/Resource/img/DCi001.jpg" style="margin: 30px auto auto auto; border-radius: 30px;">
                        <div style="padding: 10px 30px 10px 30px; position: relative; left: 600px; bottom: 520px; width: 400px; height: 500px; border: 1px solid darkgray; border-radius: 10px; text-align: center;">
                            <h4 style="margin: 30px 0px 30px 0px;">라임 바질 앤 만다린 코롱</h4> 
                            <input type=hidden name=prod_name value="라임 바질 앤 만다린 코롱"> <!-- value값을 list형 이름으로 -->
                            <h6 style="margin: 30px 0px 30px 0px; font-size: 13px;">조 말론 런던의 시그니처 향. 열정적인 허브의 독특한 조합으로 이루어져 있습니다. 카리브해의 산들바람에서 실려온 듯한 라임향에 톡 쏘는 바질과 향기로운 백리향이 더해져서 독특한 조합을 만들어 냅니다. 현대적인 감각의 클래식한 향입니다.</h6>
                            <button type="button" data-toggle="modal" data-target="#exampleModalCenter"  style="height: 30px; color: darkgray; background-color:transparent; border: 0px;"><h6 style="line-height: 25px;">전성분</h6></button>
                            <div style="margin: 20px auto 10px auto; padding: 0px 5px 0px 5px; width: 300px; height: 25px; border: 1px solid lightgray; text-align: left;">
                                <input type=hidden name=price value="940"> <!-- value값을 list형 가격으로 -->
                                <h6 style="float: left; padding: 5px 0px 5px 0px;">₩ 94,000</h6>
                                <h6 style="float: left; margin: 0px 10px 0px 10px; padding: 5px 0px 5px 0px;">100ML</h6>
                            </div>
                            <div style="width: 100%; height: 50px;">
                                <h6 style="float: left; margin: 20px 0px 0px 20px;">관련 키워드 : </h6><a href="#" style="float: left; margin: 20px 5px 0px 10px;"><h6>봄</h6></a><a href="#" style="float: left; margin: 20px 10px 0px 5px;"><h6>가을</h6></a>
                            </div>
                            <div style="margin: 80px 0px 10px 0ox; width: 100%; height: 50px; float: left;">
                                <h6 style="float: left; margin: 10px 10px 0px 0px; padding: 5px 0px 5px 20px;">수량 : </h6><input type=text size=1 id=prod_quantity name=prod_quantity value="1" style="float: left; margin: 13px 3px 0px 0px; width: 40px; height: 20px; text-align: right;"><h6 style="float: left; margin: 15px 0px 0px 0px;">개</h6>
                            </div>
                            <div style="margin: 80px 0px 10px 0px; width: 100%;">
                                <input type="button" id="btnCart" value="장바구니" style="margin: 0px 10px 0px 0px; width: 130px; height: 25px; font-size: 14px; border: 0px; background-color: lightgray;">
                                <input type="button" value="구매하기" style="margin: 0px 0px 0px 10px; width: 130px; height: 25px; font-size: 14px; border: 0px; background-color: lightgray;">
                            </div>
                        </div>
                    </div>
                </div>
            </form>

            <!-- Modal -->
            <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalCenterTitle">Modal title</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            전성분 설명을 넣어주세요.
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="/Resource/key/bottom.jsp" flush="false"/>

            <script>    
                var change = $("#prod_quantity").change();
               // console.log("change완료");
				
                if(change){
                        $("#btnCart").on("click",function(){
                        	//console.log($("#prod_quantity").val());
                    		<c:choose>
                    		<c:when test="${loginInfo == null}">
                	    		alert("로그인이 필요한 서비스 입니다.");
                    			location.href = "/JoMalone/Member/login.jsp";
                    		</c:when>
                    		<c:otherwise>
	                            if($("#prod_quantity").val() == 0 || $("#prod_quantity").val() == ""){
	                                alert("수량을 입력해주세요");
	                            }
	                            else{
	                            $("#frm").submit();
	                            $.ajax({
	                                url:"../insert.ca",
	                                type:"post",
	                                data:{}
	                            }).done(function(){
	                                var cf = confirm("장바구니 상품이 정상적으로 담겼습니다.\n장바구니로 이동 하시겠습니까?");
	                                if(cf){
	                                    location.href="${pageContext.request.contextPath}/list.ca";
	                                }
	                                else{
	                                    location.href="${pageContext.request.contextPath}/Goods/goods_detail.jsp";
	                                    //$("#prod_quantity").val() == 1; 
	                                    return false;
	                                }
	                            })
	                        }
                    		</c:otherwise>
                    		</c:choose>                 	
				})
              }           
                else{
                    $("#btnCart").on("click",function(){
                		<c:choose>
                		<c:when test="${loginInfo == null}">
            	    		alert("로그인이 필요한 서비스 입니다.");
                			location.href = "/JoMalone/Member/login.jsp";
                		</c:when>
                		<c:otherwise>
	                        $("#frm").submit();
	                        $.ajax({
	                            url:"../insert.ca",
	                            type:"post",
	                            data:{}
	                        }).done(function(){
	                            var cf = confirm("장바구니 상품이 정상적으로 담겼습니다.\n장바구니로 이동 하시겠습니까?");
	                            if(cf){
	                                location.href="${pageContext.request.contextPath}/list.ca";
	                            }
	                            else{
	                                location.href="${pageContext.request.contextPath}/Goods/goods_detail.jsp";
	                                //$("#prod_quantity").val() == 1; 
	                                return false;
	                            }
	                        })
                		</c:otherwise>
                		</c:choose>
                    })
                }
            </script>
        </body>
    </html>	