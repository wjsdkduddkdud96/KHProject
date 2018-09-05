<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>		
		<!-- <script src="resources/js/jquery-1.11.3.min.js"></script> -->
		<script src="resources/js/zer0boxPaging.js?ver=2" type="text/javascript"></script>
		<title>Insert title here</title>
		<style>
        button{
            height: 21px;
            vertical-align: middle;
            
        }
        #reviewSearch{
            width: 15px;
            height: 15px;
            
        }
        textarea{
            width: 400px;
            height: 200px;
            resize: none;
        }
        input[type=button]{
            vertical-align: middle;
            padding: 0px 5px;
            background-color: #33aaaaff;
            color: white;
            border-radius: 7px;
            width: 50px;
            height: 27px;
            outline: 0px;
            border: 0px;
        }
        
        #write{
        vertical-align: middle;
            padding: 0px 5px;
            background-color: #33aaaaff;
            color: white;
            border-radius: 7px;
            width: 80px;
            height: 27px;
            outline: 0px;
            border: 0px;
        }
        #hash{
            margin-right: 5px;
        }
        .hashTag{
            border: 2px solid #33aaaaff;
            font-size: 14px;
            width: auto;            
            text-align: center; 
            float: left;
            margin-left: 20px;
            margin-top: 10px;
            padding-left: 10px;
        }
        #sendForm{
            text-align: center;
            margin: 0 auto;
            width: 600px;
            
        }
        #reviewPhoto{
            width: 80px;
            margin-top: 20px;
            margin-right: 315px;
        }
       
        #userName{
        	height: 30px;
        	border: 0px;
        	font-size: 15px;
        }
       .div{
       	height: 100px;
       }
       #tag,#editable{
       	width: 600px;
       	height: auto;
       	overflow: hidden;
       }
       #imgDiv{
       	float: left; 
       	margin-left: 20px;
       }
       /* #editable{
       	width: 600px;
       	height: auto;
       	overflow: hidden;
       } */
       .hashDel{
       	width: 20px;
       	background-color: #33aaaaff;
        outline: 0px;
        border: 0px;
        color: white;
        float:right;
        text-align: center;
        font-size: 15px;
        margin-left: 10px;
       }
       #user_Id{
       	border: 0px;
       	font-size: 15px;
       	font-weight: bold;
       	margin-left: 15px;
       }
       #searchList{
		width: 300px;
		height: 400px; 
		background-color: rgba(46,100,254,0.7);
		margin-top:-42px;     
		margin-left: 405px;
		z-index: 2;
		position: absolute;
		display: none;
		text-align: left;
       }
       #formDiv{
       position: relative;
       	z-index: 1;
       }
       #mapDiv{
       	width: 400px;
		height: 400px;
		background-color: orange;
		margin-top:-42px;  
		margin-left:4px;   
		z-index: 2;
		position: absolute;
		display: none;
       }
       #listClose{
       	width: 25px;
       	float: right;
       	border-radius: 0px;
       }
       .store_list{
       	color: black;
       	text-decoration: none;
       	line-height: 2.0;
       	font-weight: 550;
       	margin-left: 10px;
       }
       .store_list:hover {
		color: #33aaaaff;
	   }
	   .store_addr{
	    color: black;
       	text-decoration: none;
       	font-size: 12px;
       	margin-left: 10px;
	   }
	   #map{
	   	width: 400px;
		height: 400px;
	   }
	   #review_profile{
	   	width: 80px;
	   	height: 80px;
	   	border-radius:7px;
	   	float: left;
	   	margin-left: 170px;
	   	margin-right: 0px;
	   	overflow: hidden;
	   }
	   #starText{
	   	color: red;
	   }
	   #containerA{
	   	height: 40px;
	   	margin-top: 35px;
	   	background-color: rgba(255,255,255,0.7);
	   	padding-top: 2px;
	   	position: absolute;    
	   	bottom: 0px;
	   	width: 100%;
	   	vertical-align: middle;	  	
	   }
	   #containerA ul{
	   	padding-left: 0px;
	   }
	   #infoW{	   	
	   	border: 1px solid black;
	   	width: 150px;
	   	height: 25px;
	   }
	   #review_content{
	   	font-size: 15px;
	   }
	   #storeNameList{
	   	width: 300px;
        display: inline-block;
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden;
	   }
    </style>
    <script>
    	var mapLevel=7;
    	var mapLocation="서울특별시 동대문구 외대역동로 101";
    </script>
	</head>
	<body>	
	<br/><br/><br/>
	<form id="sendForm" action="reviewWrite" method="post">

	<div id ="formDiv">
	<input type="hidden" name="review_idx" value="${review_updateForm.review_idx }"/>
	<div id="review_profile">
		<img id="profileImage"  width='80px' height='80px'  src="${sessionScope.loginProfile }"/>
		<input id="profileHidden" type="hidden" name='review_profile' value="${sessionScope.loginProfile }"/>
	</div>
	<br/>
	작성자 : <input id="user_Id" name="id" type="text" value="${ sessionScope.loginId}" readonly/>
	<br/><br/><br/><br/>
    상호명 : <input id="review_storeName" type="text" placeholder="상호명을 입력해 주세요" name="review_storeName" value="${review_updateForm.review_storeName}" maxlength="20"/>
    <input type='hidden'  id="review_storeidx"  name='review_storeidx' />
    <button type="button" id="search" onclick="StoreName()">
    	<img id="reviewSearch" src="resources/img/search.png"/>
    </button><br/><br/><br/>
    <div id="searchList">
    	
    	
    </div>
    <div id="mapDiv" >
    	 <c:import url="/WEB-INF/views/include/common/map.jsp"/>
    </div>
    <div id="starDIV">
    
    별점 : <jsp:include page="star.jsp"></jsp:include><br/>
    <span id="starText">별점은 0.5점 이상부터 작성해 주세요.</span> <br/>
    <script>
    starChk("${review_updateForm.review_star}");
    function starChk(elem){
    	$("input:radio[value='"+elem+"']").attr('checked', true);
    	$("#starScore").text(elem);
    }
    </script>
    </div><br/>
    내용<br/>
    <textarea id="review_content" name="review_content" maxlength="300" placeholder="리뷰 내용을 입력해 주세요.">${review_updateForm.review_content }</textarea><br/><br/>
    
    해시태그 : <input id="hash" type="text" value='#' placeholder="해시태그를 입력해 주세요." maxlength="20"/><input id="add" type="button" value="추가"/><br/>
    
    <div id="tag"></div>
    
    <script>    
    hashtag("${review_updateForm.review_idx}")
  //해시태그,사진
	function hashtag(elem){
		 $.ajax({
			url:"./reviewHashPhoto",
			type:"post",
			dataType:"json",
			data:{"review_idx":elem},
			success:function(d){
				//console.log(d.reviewPhoto);
				printHash(d.reviewHash,elem);		
				printPhoto(d.reviewPhoto,elem);
			},
			error:function(e){console.log(e);}
		});	 
	}
	
	//해시태그 리스트
	var tag="";
	function printHash(hash,elem){
		tag="";
		hash.forEach(function(item){
			tag += "<div class='hashTag' id='hashTag'>"+item.hash_tag+
			"<button onclick='hashDel(this)' class='hashDel'>-</button>"+
			"<input type='hidden' name='hash_tag' value='"+item.hash_tag+"'/></div>";				
		});
		
		$("#tag").append(tag);	
	}
	//사진 리스트
	var img="";
	function printPhoto(photo,elem){
		img="";
		photo.forEach(function(item){
			img += "<div id='imgDiv'><img width='100' height='100' src='"+item.revPhoto_Photo+"'/></br>";
			img += "<input id='"+item.revPhoto_Photo+"' type='button' value='삭제' onclick='del(this)' />";
			img += "</div><input type='hidden' name='review_photo' value='"+item.revPhoto_Photo+"'/>";
		})
		$("#editable").append(img);
	}
    </script>
    
	<div id="rePhoto">
    <input id="reviewPhoto" type="button" value="사진 추가" onclick="fileUp()"/><br/><br/>
    <input type="hidden" name="review_photo"/>
    <div id="editable"></div>
    </div><br/><br/>
    <input type="button" id="write" value="작성하기"/>
    <input type="button" value="취소" id="reviewWriteCancel"/>
    </div>
    </form>
     
	</body>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c7f29813d0150c2927c1529f7d432392&libraries=services"></script>
	<script>
	//console.log(store_name);
	if("${sessionScope.store_Name}" != ""){
		$("#review_storeName").val("${sessionScope.store_Name}");
		$("#review_storeName").attr("readonly",true);
		$("#search").css("pointer-events", "none");
		 $("#review_storeidx").val("${sessionScope.store_Idx}");
	}
	var loginId="";
	if("${sessionScope.loginProfile}" == "0"){
		$("#profileImage").attr("src","resources/img/member/noprofile.jpg");
		$("#profileHidden").val("resources/img/member/noprofile.jpg");
	}else{
	}
	var loginId = "${sessionScope.loginId}";
	//console.log(loginId);
	var div = "";//div 추가 변수
	
	$("#reviewWriteCancel").click(function(){
		<%-- <%
		session.removeAttribute("store_Name");
		session.removeAttribute("store_Idx");
		%> --%>
		if("${sessionScope.store_Idx}" == ""){
			location.href="./";
		}else{
			location.href="storeDetail?store_idx="+"${sessionScope.store_Idx}";
		}
		
	});
	$(document).ready(function(){
		console.log("${sessionScope.loginProfile}");
		$("#Logo").css("pointer-events","none");
		$("#searchBtn").css("pointer-events","none");
		$("#search_content").css("pointer-events","none");
		window.history.forward(1);
		history.pushState(null, document.title, location.href); 
		window.addEventListener('popstate', function(event) { history.pushState(null, document.title, location.href); });

	//새로고침, 뒤로가기 막기
	document.onkeydown = function(e){
	      key = (e) ? e.keyCode : event.keyCode;
	      if(key==116){
	    	  alert("새로고침을 할 수 없습니다. 취소를 눌러주세요.");
	         if(e){
	            e.preventDefault();
	         }
	         else{
	            event.keyCode = 0;
	            event.returnValue = false;
	         }
	      }
	     
	}
	document.addEventListener('keydown', function(event) {
	    if (event.keyCode === 13) {
	        event.preventDefault();
	    }
	}, true);
	//오른쪽마우스 막기
	document.oncontextmenu = function(e){
	     if(e){
	        e.preventDefault();
	     }
	     else{
	        event.keyCode = 0;
	        event.returnValue = false;
	     }
	} 
	});
	
	$("#write").click(function(){
		if($("#tag").text() == ""){
			alert("해시태그를 작성 해 주세요.");
			$("#hash").focus();
		}else if($("#review_content").val() == ""){
			alert("내용을 작성 해 주세요");
			$("#review_content").focus();
		}else if($("#review_storeName").val()==""){
			alert("상호명을 작성 해 주세요.");
			$("#review_storeName").focus
		}else if($("#starScore").text()=="" || $("#starScore").text()=="0"){
			alert("별점을 작성 해 주세요");
		}else{			
<%-- 			<%
				session.removeAttribute("store_Name");		
			session.removeAttribute("store_Idx");
			%> --%>
			$("#sendForm").submit();			
		}
		
	});
	
	//해시태그 추가 버튼시 div 생성
	$("#add").click(function(){
		if($("#hash").val() != "#"){
		div = "<div class='hashTag' id='hashTag'>"+$("#hash").val()+
		"<button onclick='hashDel(this)' class='hashDel'>-</button>"+
		"<input type='hidden' name='hash_tag' value='"+$("#hash").val()+"'/></div>";		
		$("#tag").append(div);	
		//hashtagArr[i] = $("#hash").val();
		//i++;
		$("#hash").val("#");
		}
		
	});
	
	function hashDel(elem){
		//var sp = elem.id.split("_")[1];
		//console.log(elem.target);
		//console.log(elem.parentNode);
		//delete hashtagArr[sp];
		elem.parentNode.remove();
		$(elem).remove();
	}
	
	//사진추가 새창
	function fileUp(){
		//fileUpload 새창을 띄운다.
		var myWin = window.open("./uploadForm","File Upload","width=400, height=100");
		
	}
	
	//사진 삭제시 초기화가 되지 않기 위해 Ajax 사용
	function del(elem){
		var fileName = elem.id.split("/")[2];
		//console.log(fileName);
		$.ajax({
			url : "./fileDel",
			type : "get",
			data : {"fileName":fileName},
			success : function(data){
				console.log(data);
				if(data.success == 1 || data.result == 1){
					//이미지 삭제
					//console.log($(elem).parent().next());
					 $(elem).prev().prev().remove();
					 $(elem).parent().next().remove();
					//버튼 삭제
					$(elem).remove();  
					
				}
			},
			error : function(e){
				console.log(e);
			}
		});
	}
	
	
	showPage = 1;//보여줄 페이지
	function StoreName(){
		StoreName_Search(showPage);
	}
	
	//가게 검색 리스트
	var storeList="";
	var btn="";
	function StoreName_Search(page){
		//console.log("search click");
		//console.log($("#review_storeName").val());
		$("#searchList").empty();
		btn = "<input id='listClose' type='button' value='X'/><br/>";
		$("#searchList").append(btn);
		$.ajax({
			url : "./revStoreSearch/5/"+page,
			data : {"review_storeName":$("#review_storeName").val()},
			success : function(data){
				//console.log(data.list.length);
				showPage = data.currPage;
				if(data.list.length == 0){					
					storeList += "<h3>찾으시는 상호명이 없습니다.</h2>";
				}else{
					for(var i=0; i<data.list.length; i++){
						storeList += "<div id='storeNameList'><a class='store_list' href='#' onclick='mapDiv(this)'>"+data.list[i].store_name+"</a><br/>";
						storeList += "<a class='store_addr' href = '#'>"+data.list[i].store_addr+"</a><hr/>";
						storeList += "<input type='hidden' id='store_idx' value='"+data.list[i].store_idx+"'/></div>";
					}
				}
				$("#searchList").append(storeList);
				$("#searchList").append("<div id='containerA'></div>");
				storeList = "";
				btn="";
				
				
				 $("#containerA").zer0boxPaging({
		                viewRange : 5,
		                currPage : data.currPage,
		                maxPage : data.range,
		                clickAction : function(e){
		                    //console.log(e);
		                    StoreName_Search($(this).attr('page'));
		                }
		            });
				
				
			},
			error : function(e){
				console.log(e);
			}
		});
		$("#starDIV").css("pointer-events", "none");
		$("#searchList").css("display","block");
	}
	
	
	
	
	
	 function mapDiv(elem){
		// console.log($(elem).next().next().next().next().val());
		//console.log(elem.parentNode.children[2].text);
		mapLocation=elem.parentNode.children[2].text;
		$("#mapDiv").css("display","block");		
		/* $("#mapDiv").text(elem.parentNode.children[2].text); */
		$.getJSON("resources/json/seoul.json", function(geojson) {
				 
			    var data = geojson.features;
			    var coordinates = []; //좌표 저장할 배열
			 
			    $.each(data, function(index,val) {
			        coordinates = val.geometry.coordinates;
			        displayArea(coordinates);
			 
			    })
			})
		
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new daum.maps.LatLng(37.567427, 126.978889), // 지도의 중심좌표
		        level: mapLevel // 지도의 확대 레벨
		    };  
		var map = new daum.maps.Map(mapContainer, mapOption); 
		//행정구역 폴리곤
		function displayArea(coordinates) {
			var path = []; //선 그려줄 path
			$.each(coordinates[0], function(index, coordinate) {
		        var point = new Object(); 
		        point.x = coordinate[1];
		        point.y = coordinate[0];
		        path.push(new daum.maps.LatLng(coordinate[1], coordinate[0]));
		    })
		 	// 지도에 표시할 선을 생성합니다
			var polyline = new daum.maps.Polyline({
			    path: path, // 선을 구성하는 좌표배열 입니다
			    strokeWeight: 3, // 선의 두께 입니다
			    strokeColor: 'red', // 선의 색깔입니다
			    strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
			    strokeStyle: 'solid' // 선의 스타일입니다
			});
			// 지도에 선을 표시합니다 
			polyline.setMap(map);  
		}
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new daum.maps.services.Geocoder();
		geocoder.addressSearch(mapLocation, function(result, status) {
		    // 정상적으로 검색이 완료됐으면 
		     if (status === daum.maps.services.Status.OK) {
		        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new daum.maps.Marker({
		            map: map,
		            position: coords
		        });
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		        
		        var iwContent = '<div id="infoW" style="padding:5px;">마커를 클릭해주세요</div>', // 인포윈도우에 표출될 내용
		        iwPosition = new daum.maps.LatLng(coords); //인포윈도우 표시 위치입니다

		    // 인포윈도우를 생성합니다
		    var infowindow = new daum.maps.InfoWindow({
		        position : iwPosition, 
		        content : iwContent 
		    });
		      
		    // 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
		    infowindow.open(map, marker); 
		     // 마커에 클릭이벤트를 등록합니다
		        daum.maps.event.addListener(marker, 'click', function() {
				      $("#review_storeName").val(elem.text);
				      $("#review_storeidx").val($(elem).next().next().next().next().val());
				      $("#searchList").css("display","none");
						$("#mapDiv").css("display","none");
						$("#starDIV").css("pointer-events", "");
				});
		    } 
		}); 
		console.log(mapLocation);
		function relayout(){
			console.log(map);
			map.relayout();
		}
		
		
		relayout();
	} 

		$(document).on("click","#listClose",function(){
			$("#searchList").css("display","none");
			$("#mapDiv").css("display","none");
			$("#starDIV").css("pointer-events", "");
		});
	</script>
</html>