<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>
            <head>
                <meta charset="UTF-8">
                <title>adminPage</title>
                <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

                <style>
                    #sidebar{ float:left; width:200px; margin:0px; padding:0px; }
                    #sidebar>.menu{ list-style-type: none; text-align: right; margin:auto; color:#1e2d47; text-align:center;
                        padding:0px 10px; margin: 10px; width:80%; line-height:30px; background-color : #1e2d47; color:white;}
                    .menu{height:30px; width:100%; font-family: 'Alata', sans-serif; border:1px solid black; border-radius:3px;}

                    .Wrap{height:800px;  width:200px; margin:0px; float:left; }
                    h4{margin:0px; padding:20px 20px; text-align: right; font-size: 20px; font-family: 'Alata', sans-serif;
                    }
                    .menu>a{text-decoration: none; color:white;}
                    #wrapper{width:1500px; overflow:hidden; margin:auto; }

                    #container{
                        height:800px;
                        width:1297px;
                        float:left;
                        padding: 20px;
                        overflow-x:scroll;
                        border:1px solid black;
                    }

                    .firstCol{width:100px; text-align: center; }
                    .secondCol{width:200px; text-align: center;}


                </style>
            </head>
            <body>
                <jsp:include page="../Resource/key/topAdmin.jsp" flush="false"/>
                <div id="wrapper">
                    <div class=Wrap>
                        <h4>상품관리</h4>
                        <ul id="sidebar">
                            <li class="menu"><a href="${pageContext.request.contextPath}/adminBack/insertProduct.jsp">상품등록</a></li>
                            <li class="menu"><a href="${pageContext.request.contextPath}/productList.admini">상품 수정/삭제</a></li>
                            <li class="menu"><a href="${pageContext.request.contextPath}/adminBack/insertDetail.jsp">상세 정보 등록</a></li>
                            <li class="menu"><a href="${pageContext.request.contextPath}/detailBoard.admini">상세 정보 수정</a></li>
                        </ul>
                    </div>
                    <div id="container">






                        <c:choose>
                            <c:when test="${list.size() == 0 }">
                                <table border=1>

                                    <tr>
                                        <th class=firstCol class=firstRow>글 번호</th>
                                        <th class=secondCol class=firstRow>상품 코드</th>
                                    </tr>
                                    <tr>
                                        <td colspan="2">표시할 내용이 없습니다.</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">navigator</td>
                                    </tr>
                                </table>

                            </c:when>

                            <c:otherwise>
                                <table border=1>

                                    <tr>
                                        <th class=firstCol>글 번호</th>
                                        <th class=secondCol>상품 코드</th>
                                    </tr>
                                    <c:forEach items="${list }" var="dto">
                                        <tr>
                                            <td class=firstCol>${dto.seq }
                                            <td class=secondCol><a href="${pageContext.request.contextPath}/detailView.admini?prod_code=${dto.prod_code}">${dto.prod_code }</a>
                                        </tr>
                                    </c:forEach>

                                </table>

                            </c:otherwise>
                        </c:choose>




                    </div>
                </div>
            </body>
        </html>