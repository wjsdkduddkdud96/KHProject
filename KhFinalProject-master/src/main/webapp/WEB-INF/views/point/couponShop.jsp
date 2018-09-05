<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>Insert title here</title>
		<style>
			.navi{list-style-type: none; height: 40px; padding: 50px; padding-left: 98px; padding-top: 15px; margin: 0px;}
        	.navi li{float: left; position: relative; padding:10px; margin: 0px; text-align: right;}
        
      	  	div#coupon_mainDiv1{position: relative; top:100px; left: 310px; border: none; width: 930px; height: 850px;}
        	div#coupon_subDiv1{position: absolute; top: 5px; left: 5px; border: none; width: 917px; height: auto;}
        	li.li2{padding-left: 5px; padding-right: 90px;}
        
        	li img{border-radius: 30px;}
        	button.coupon_btn{border: none; border-radius: 1px; cursor: pointer;}
		</style>
	</head>
	<body>
	<c:import url="/WEB-INF/views/include/main/nav.jsp"/>
		<div id="coupon_mainDiv1">
            <div id="coupon_subDiv1">
                <ul class="navi">
                    <li class="li1"><img src="./resources/img/coupon/1000.jpg" alt="1000원 쿠폰" width="200px;" height="130px;"/></li>
                    <li class="li2"><br><span style="font-size: 12px;">할인쿠폰</span><br/><span><b>1,000원</b></span><br><br><button class="coupon_btn" id="1000" name="1000쿠폰">구매하기</button></li>
                    
                    <li class="li1"><img src="./resources/img/coupon/2000.jpg" alt="2000원 쿠폰" width="200px;" height="130px;"/></li>
                    <li class="li2"><br><span style="font-size: 12px;">할인쿠폰</span><br/><span><b>2,000원</b></span><br><br><button class="coupon_btn" id="2000" name="2000쿠폰">구매하기</button></li>
                    
                    <li class="li1"><img src="./resources/img/coupon/3000.jpg" alt="3000원 쿠폰" width="200px;" height="130px;"/></li>
                    <li class="li2"><br><span style="font-size: 12px;">할인쿠폰</span><br/><span><b>3,000원</b></span><br><br><button class="coupon_btn" id=3000 name="3000쿠폰">구매하기</button></li>
                    
                    <li class="li1"><img src="./resources/img/coupon/4000.jpg" alt="4000원 쿠폰" width="200px;" height="130px;"/></li>
                    <li class="li2"><br><span style="font-size: 12px;">할인쿠폰</span><br/><span><b>4,000원</b></span><br><br><button class="coupon_btn" id="4000" name="4000쿠폰">구매하기</button></li>
                    
                    <li class="imli1g_li"><img src="./resources/img/coupon/5000.jpg" alt="5000원 쿠폰" width="200px;" height="130px;"/></li>
                    <li class="li2"><br><span style="font-size: 12px;">할인쿠폰</span><br/><span><b>5,000원</b></span><br><br><button class="coupon_btn" id="5000" name="5000쿠폰">구매하기</button></li>
                </ul>
            </div>
		</div>
		
	</body>
	<script>
	
	//printList 구매 버튼 
	$(".coupon_btn").click(function (e) {
		var confirmz = confirm("구매하시겠습니까?");
		if(confirmz){
			$.ajax({ 
				type : "post",
				url : "./couponPurchase",
				data : {
					price : $(this).attr("id"),
					name : $(this).attr("name")
				},
				dataType : "json",
				success : function (data) {
					console.log(data);
					if(data.couponPurchaseMsg > 0/*  && data.couponBoxMsg > 0 */){
						alert(data.msg);
					}else{
						alert(data.msg);
					}
					
				},
				error : function (error) {
					console.log(error);
				}
			});
		}else{
			return;
		}
		//console.log($(this).attr("id"));
		//console.log($(this).attr("name"));
		
	});
	
	
	/* $(document).ready(function() {
		$.ajax({
			type : "post",
			url : "./couponShop",
			dataType : "json",
			success : function (data) {
				console.log(data);
				if(data.list != null){
					printList(data.list);
				}
			},
			error : function (error) {
				console.log(error);
			}
		});
	}); */
	
	
	//받아온 리스트
	/* function printList(list) {
		var content = "";
		list.forEach(function(item, idx) {
			content += "<tr>";
			content += "<td>"+item.couponBox_name+"</td>";
			content += "<td>"+item.couponBox_price+"</td>";
			content += "<td><button id='"+item.couponBox_code+"' class='btn'>구매</button></td>";
			content += "</tr>";
		});
		$("#list").empty();
		$("#list").append(content);
		
		console.log($("").attr("id"));   
	} */
	
	

	</script>
</html>