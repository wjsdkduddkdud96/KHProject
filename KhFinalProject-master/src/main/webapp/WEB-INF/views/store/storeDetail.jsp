<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<c:import url="/WEB-INF/views/include/main/nav.jsp"/>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c7f29813d0150c2927c1529f7d432392&libraries=services"></script>
		<title>맛집 상세보기</title>
		<style>
			#detailFrame{position: relative;top: 50px; left: 20%;height: 700px;}
			#infoFrame{width:1000px; height: 100px;position: absolute;top: 70px;}
			#infoFrame ul{width: 500px;}
			#infoFrame li{list-style: none;  display: inline; padding: 0px 10px; border: solid 2px #2637a4; font-size: x-large; width: 100px;}
			#contFrame{width: 1000px; height: 500px; border: solid 2px #2637a4;position: absolute;top: 130px;}
			.divChg{display: none;}
			
			.tab{cursor: pointer;}
			#contFrame table{
				font-size: 17px;
				width: 700px;
				height: 500px;
				border: 0px;
				border-collapse: collapse;
				width: 1000px;
				position: absolute;
			}
			#contFrame td{
				border-bottom: solid 2px #F2F2F2;
				padding: 10px;

			}
			#contFrame th{
				border-bottom: solid 2px #F2F2F2;
				padding: 10px;
				width: 150px;
				
			}
			#title{font-size: 50px; position: absolute;border-bottom: solid 2px #2637a4;}
			.hashTag{
			border: 2px solid #33aaaaff;
            font-size: 17px;
            width: auto;          
            text-align: center; 
            float: left;
            margin-right: 10px;
            margin-bottom: 5px;
            padding: 0px 10px;
			}
			
			#menu{
				 text-align: center;
				 padding: 5px;
			}
			#menu img{
			 vertical-align: middle;
			}
			.menuBtn{
			cursor: pointer;
			}
			#menuD{
			border: solid 2px #2637a4;
			}
			
			#back{
				cursor: pointer;
				vertical-align: middle;
				border: 2px solid #33aaaaff; 
	            background-color: white;
	            outline: 0px;
	            padding: 5px 5px;
	            font-size: 15px;
	            border-radius: 3px;
			}
		</style>
	</head>
	<body>
		<div style="position: absolute; left: 1%; top: 33%;">
			<img src="resources/upload/store/${storeDetail.store_photo}"  width="250" height="160"/>
		</div>
		<div id="detailFrame">
		<span id="title">
			${storeDetail.store_name}
			<c:if test="${sessionScope.loginId == '관리자' }">
					<button id="back" onclick="backBtn()">승인/거절 하기</button>
			</c:if>
		</span>
			<div id="infoFrame">
				
				<div style="position: absolute; left: -40px;">
					<ul>
						<li class="tab" id="defau" onclick="divSnH(this)">정보</li>
						<li class="tab" onclick="divSnH(this)">메뉴</li>
						<li class="tab" onclick="divSnH(this)">위치</li>
					</ul>
				</div>
				<div style="position: absolute; top: 0px; right: -30px; ">
					<ul>
						<li>별점 ${storeDetail.store_star}</li>
						<li>조회 ${storeDetail.store_bHit}</li>
						<li>리뷰 ${storeDetail.store_revCnt}</li>
						<li id="likeCnt">찜수 ${storeDetail.store_storeLikeCnt}</li>
					</ul>
				</div>
				<div style="position: absolute; top: 15px; right: 0px; ">
					<img class="tab"  id="storeLike" alt="찜하트" src="" width="35px" onclick="storeLike()">
				</div>
			</div>
			
			<div id="contFrame">
				<div class="divChg" id="info">

					<table>
						<tr>
							<th>주소</th>
							<td>
								<span>${storeDetail.store_addr}</span>
							</td>
						</tr>
						<tr>
							<th>음식 종류</th>
							<td>
								<span>${storeDetail.store_food}</span>
							</td>
						</tr>
						<tr>
							<th>예상 예산(2인기준)</th>
							<td>
								<span>${storeDetail.store_price}원</span>
							</td>
						</tr>
						<tr>
							<th>영업 시간</th>
							<td>
								<span>${storeDetail.store_time}</span>
							</td>
						</tr>
						<tr>
							<th>휴무일</th>
							<td>
								<span>${storeDetail.store_rest}</span>
							</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>
								<span>${storeDetail.store_phone}</span>
							</td>
						</tr>
						<tr>
							<th>해시 태그</th>
							<td>
								<c:forEach items="${storeHash}" var="tag">
								<div class='hashTag'>${tag.hash_tag}</div>
								</c:forEach>
							</td>
						</tr>
					</table>
				</div>
				<div class="divChg" id="menu">
					<div id="menuB">
						<img src="resources/img/store/leftArrow.png" class="menuBtn" onclick="nextPreMenu(0)" width="50">
						<img id="menuD" alt="menu0" src="resources/upload/store/${storeMenuD}" width="270" height="360">
						<img src="resources/img/store/rightArrow.png" class="menuBtn" onclick="nextPreMenu(1)" width="50">
					</div>
					<div id="menuS">
						<c:set var="i" value="0"/>
						<c:forEach items="${storeMenu}" var="menu">
							<img alt="메뉴" id="menu${i}" class="menuImg" src="resources/upload/store/${menu}" width="60" height="80" onclick="menuShow(this)">
							<c:set var="i" value="${i+1}"/>
						</c:forEach>
					</div>
				</div>
				<div class="divChg" id="loca">
					<div id="map" style="width:100%;height:100%;"></div>
				</div>
			</div>
		</div>
	
	

		<br><br><br><br>
		
		<c:import url="/WEB-INF/views/review/reviewList.jsp">
			<c:param name="idx" value="${storeDetail.store_idx}"/>
		</c:import>
	</body>
	<script>
	
	//뒤로가기 버튼 클릭이벤트
	var cate = "가게";
	var alarmuserid="${sessionScope.loginId}";
	function backBtn() {
		//history.back();
		location.href="./alarmtimeline?id="+alarmuserid+"&cate="+cate;
	}
	
	var id="";
	var likeChk=0;
	infoDefau();
	storeLikeChk();
	
	//정보로 초기화
	function infoDefau() {
		$("#defau").css("background-color","#2637a4");
		$("#defau").css("color","white");
		$("#info").css("display","inline");
	}
	
	var map;
	var isMap=false;//맵 생성 여부
	//선택에 따라 정보,메뉴,위치 보기
	function divSnH(e) {
		$(".tab").css("background-color","white");
		$(".tab").css("color","black");
		$(e).css("background-color","#2637a4");
		$(e).css("color","white");
		
		$(".divChg").css("display","none");
		if($(e).html()=="정보"){
			$("#info").css("display","inline");
		}else if($(e).html()=="메뉴"){
			$("#menu").css("display","inline");
		}else if($(e).html()=="위치"){
			$("#loca").css("display","inline");
			
			mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		        
		    };  

			// 지도를 생성합니다    
			map = new daum.maps.Map(mapContainer, mapOption); 
			
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new daum.maps.services.Geocoder();
			
			// 주소로 좌표를 검색합니다
			geocoder.addressSearch('${storeDetail.store_addr}', function(result, status) {
			
			    // 정상적으로 검색이 완료됐으면 
			     if (status === daum.maps.services.Status.OK) {
			
			        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
			
			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new daum.maps.Marker({
			            map: map,
			            position: coords
			        });
			
			        // 인포윈도우로 장소에 대한 설명을 표시합니다
			        var infowindow = new daum.maps.InfoWindow({
			            content: '<div style="width:150px;text-align:center;padding:6px 0;">${storeDetail.store_name}</div>'
			        });
			        infowindow.open(map, marker);
			
			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
			    } 
			});
			map.setZoomable(false);
			isMap = true;
		}else{
			alert("올바른 명령이 아닙니다.")
		}
		
	}
	
	// 버튼 클릭에 따라 지도 확대, 축소 기능을 막거나 풀고 싶은 경우에는 map.setZoomable 함수를 사용합니다
	function setZoomable(zoomable) {
	    // 마우스 휠로 지도 확대,축소 가능여부를 설정합니다
	    map.setZoomable(zoomable);    
	}
	
	var zoom=false;//줌인or아웃 플레그
	//맵에서만 줌인
	$("body").click(function(e) {
		if(isMap==true){
		setZoomable(zoom)
		}
		zoom=false;
	});
	$("#map").click(function(e) {
		zoom=true;
	});
	
	//이전 , 다음 메뉴판
	$(".menuImg").css("border","solid 2px white");
	$("#menu0").css("border","solid 2px red");
	var currMenu="";
	var currMenuNum=0;
	var menuSize = ${storeMenu.size()};
	if(menuSize<2){
		$(".menuBtn").css("visibility","hidden");
	}
	
	//메뉴판 선택
	function menuShow(e) {
		$("#menuD").attr("src",$(e).attr("src"));
		$("#menuD").attr("alt",$(e).attr("id"));
		$(".menuImg").css("border","solid 2px white");
		$(e).css("border","solid 2px red");
	}
	
	function nextPreMenu(pm) {
		currMenu = $("#menuD").attr("alt");
		currMenuNum = parseInt(currMenu[4]);
		if(pm==1){
			if(currMenuNum<menuSize-1){
				currMenuNum += 1;
			}else{
				currMenuNum = 0;
			}
		}else{
			if(currMenuNum>0){
				currMenuNum -= 1;
			}else{
				currMenuNum = menuSize-1;
			}
		}
		currMenu = "menu"+currMenuNum;
		$("#menuD").attr("alt",currMenu);
		$("#menuD").attr("src",$("#"+currMenu).attr("src"));
		$(".menuImg").css("border","solid 2px white");
		$("#"+currMenu).css("border","solid 2px red");
	}
	
	//찜 확인
	function storeLikeChk() {    
		$.ajax({  
			url:"./storeLikeChk",
			type:"get",
			data:{
				"store_idx":${storeDetail.store_idx}
			},
			success:function(data){
				id=data.loginId;
				if(data.likeChk==1){
					$("#storeLike").attr("src","./resources/img/storeLike/heart2.png");
					likeChk=1;
				}else{
					$("#storeLike").attr("src","./resources/img/storeLike/heart.png");
					likeChk=0;
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	//찜하기
	function storeLike() {
		if(id==null){
			alert("로그인이 필요한 서비스입니다.");
		}else{
			$.ajax({
				url:"./storeLike",
				type:"get",
				data:{
					"store_idx":${storeDetail.store_idx}
				},
				success:function(data){
					alert(data.msg);
					storeLikeChk();
					$("#likeCnt").html("찜수 "+data.likeCnt);
					
				},
				error:function(e){
					console.log(e);
				}
			});
		}
		
	}

	</script>
</html>