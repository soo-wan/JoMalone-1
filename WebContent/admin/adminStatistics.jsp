<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminPage</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>

<style>

       .Menu:hover{
            background-color: red;
        }

        table,tr,th,td{
            border:1px solid black;
        }
        tr{
        background-color:#e3e3e3;
        }
      	table{
      		width:1500px;
      		margin:auto;
      	text-align:center;
      	}
       #container{
       	height:800px;
     	width:1300px;
     	float:left;
     	padding: 20px;
     	overflow-x:scroll;
     	border:1px solid black;
       }
  
	#sidebar{ float:left; width:150px; margin:0px; padding:0px; }
    #sidebar .menu{ list-style-type: none; text-align: right; margin:15px 0px; color:#1e2d47; width:100%;}
    .menu{height:30px; width:100%;}
    .Wrap{height:800px;  width:200px; margin:0px; float:left; }
    h4{margin:0px; padding:20px 10px; text-align: right; font-size: 20px;  }
    .menu>a{text-decoration: none; color:#1e2d47}
    
    #wrapper{width:1500px; bolder:1px solid black; overflow:hidden; margin:auto; }
</style>
</head>
<body>
<jsp:include page="../Resource/key/topAdmin.jsp" flush="false"/>
<div id="wrapper">
	<div class=Wrap>
		<h4>상품관리</h4>
			<ul id="sidebar">
			    <li class="menu"><a href="#">통계</a></li>
                
			</ul>
      </div>
	<div id="container">
 		<div style="width:500px;">
			<canvas id="myChart" ></canvas>
		</div>
    </div>
    </div>
    
    	<script>
		var ctx = document.getElementById('myChart').getContext('2d');
		var myChart = new Chart(ctx,
				{
					type : 'bar',
					data : {
						labels : ${nameString},
						datasets : [ {
							label : '많이 판매된 제품',
							data : ${countString},
							backgroundColor : [ 'rgba(255, 99, 132, 0.2)',
									'rgba(54, 162, 235, 0.2)',
									'rgba(255, 206, 86, 0.2)',
									'rgba(75, 192, 192, 0.2)',
									'rgba(153, 102, 255, 0.2)'],
							borderColor : [ 'rgba(255, 99, 132, 1)',
									'rgba(54, 162, 235, 1)',
									'rgba(255, 206, 86, 1)',
									'rgba(75, 192, 192, 1)',
									'rgba(153, 102, 255, 1)'],
							borderWidth : 3
						} ]
					},
					options : {
						scales : {
							yAxes : [ {
								ticks : {
									beginAtZero : true
								}
							} ]
						}
					}
				});
		
	</script>
</body>
</html>