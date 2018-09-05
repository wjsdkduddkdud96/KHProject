<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<script src="resources/js/zer0boxPaging.js" type="text/javascript"></script>
		<title>검색</title>
		<style>
			#searchPage{
				width:1150px;
				height: auto;
			}
			#map{
				width:1000px;
				height:500px;
				margin-left: 50px;
			}
			.storeTable{
				float: left;
				margin-right: 10px;
				margin-top: 10px;
				width: 365px;
				border: 2px solid #142e5b;
				border-collapse: collapse;
				padding: 5px 10px;
				text-align: center;
			}
			.storeTable tr, .storeTable td{
				border: none;
				border-collapse: collapse;
				padding: 5px 10px;
				text-align: center;
			}
			.storeTable th{
				width: 200px;
				display: inline-block;
				text-overflow: ellipsis;
				white-space: nowrap;
				overflow: hidden;
			}
			.storeImg{
				width: 300px;
				height: 250px;
			}
			#sortSel{
				height: 30px;
				float: left;
				margin-left: 1000px;
				border-radius: 5px;
			}
			#storehashtag{
	        	border: 2px solid #33aaaaff;
	            font-size: 14px;
	            width: 70px;            
	            text-align: center; 
	            float: left;
	            padding: 0px 5px;
	            margin-right: 5px;
	            margin-bottom: 2px;
				padding: 3px;
	            
				display: inline-block;
				text-overflow: ellipsis;
				white-space: nowrap;
				overflow: hidden;
	        }
	        #tableLine{
	        	overflow: auto;
	        }
	        #store_container{
	        	margin-left: 400px;
	        }
	        .store_De{
	        	float: left;
	        	margin-right: 18px;
	        }
		</style>
	</head>
	
	<body>
		
		<script>
			/* var mapLocation = new Array();
			var mapContent = new Array(); */
			var mapLevel = 9;
			/* <c:forEach items="${list}" var="sto">
				mapContent.push("${sto.store_name}");
				mapLocation.push("${sto.store_addr}");
			</c:forEach> */
		</script>
	
		<c:import url="/WEB-INF/views/include/common/map.jsp"/><br/>
		<!-- <script>displayMap(mapLocation, mapContent)</script> -->
		
		<!-- <p>
			<button onclick="setZoomable(true)">지도 확대/축소 켜기</button>
			<button onclick="setZoomable(false)">지도 확대/축소 끄기</button>
		</p> -->
		
		<select id="sortSel" name="sortSel" onchange="sort(this.value)">
			<option value="리뷰 최신 순" selected="selected" >리뷰 최신 순</option>
			<option value="별점 순">별점 순</option>
			<option value="조회수 순">조회수 순</option>
			<option value="리뷰수 순">리뷰수 순</option>
		</select>
		<br/><br/>
		
		<div id="searchPage">
		<%-- <c:forEach items="${list}" var="sto" varStatus="status">
			<table class="storeTable" style="cursor:pointer;" onclick="location.href='storeDetail?store_idx=${sto.store_idx}'">

				<tr>
					<td colspan="3"><img class="storeImg" src="resources/upload/store/${sto.store_photo}" /></td>
				</tr>
				<tr>
					<td>상호명</td>
					<th>${sto.store_name}</a></th>
					<td rowspan="2">하트</td>
				</tr>
				<tr>
					<td>주소</td>
					<th>${sto.store_addr}</th>
				</tr>
				<tr>
					<td colspan="3">
						<c:set var="i" value="${status.index}"/>
						<c:forEach items="${list_hash[i]}" var="hash">
							<div id='hashtag'>#${hash.hash_tag}</div>
						</c:forEach>
					</td>
				</tr>
			</table>
		</c:forEach> --%>
		</div>
		<br/><br/><br/>
	</body>
	<script>
	$(document).ready(function(){
		$("#sortSel option:eq(0)").prop("selected", true);//셀렉트박스 원래대로
	});
	
	showPage = 1;//보여줄 페이지
	var id = "${sessionScope.loginId}";
	var search_content = "<%=request.getParameter("search_content") %>";
	var search_map = "<%=request.getParameter("search_map") %>";
	tableSort("리뷰 최신 순",search_content,showPage);
	
	
		function markerRefresh(list){
			var mapLocation = new Array();
			var mapContent = new Array();
			var mapLevel = 9;
			/* <c:forEach items="${list}" var="sto">
				mapContent.push("${sto.store_phone}");
				mapLocation.push("${sto.store_addr}");
			</c:forEach> */
			list.forEach(function(item){
				mapContent.push(item.store_name);
				mapLocation.push(item.store_addr);
			});
			displayMap(mapLocation, mapContent);
		}
		
		function remo(){
			removeMarker();
		}
	
		function sort(val){
			switch (val) {
			case "리뷰 최신 순":
				console.log("1");
				tableSort(val,search_content,showPage);
				break;
			case "별점 순":
				console.log("2");
				tableSort(val,search_content,showPage);
				break;
			case "조회수 순":
				console.log("3");
				tableSort(val,search_content,showPage);
				break;
			case "리뷰수 순":
				console.log("4");
				tableSort(val,search_content,showPage);
				break;
			}
		}

		//정렬
		function tableSort(val,search_content,page){
			console.log(val+"/"+page);
			$.ajax({
				url:"./searchSort/6/"+page,
				data:{data:val,search_content:search_content,search_map:search_map},
				success:function(data){
					if(data.size>0){
						console.log(data.list);
						console.log(data.list_hash);
						$("#searchPage").empty();
						if(val=="별점 순"){
							$("#searchPage").append("<h2 align='center'>별점 순은 리뷰가 5개 이상인 가게부터 정렬됩니다.</h2>");
						}
						
						storePrintList(data.list,data.list_hash);
						
						showPage = data.currPage;
						$("#store_container").zer0boxPaging({
			                viewRange : 5,
			                currPage : data.currPage,
			                maxPage : data.range,
			                clickAction : function(e){
			                    //console.log(e);
			                    console.log($(this).attr('page'));
			                    tableSort(val,search_content,$(this).attr('page'));
			                }
			            });
						removeMarker();
						markerRefresh(data.list);
					}else{
						$("#searchPage").empty();
						removeMarker();
						$("#searchPage").append("<h2 align='center'>검색 결과가 없습니다.</h2>");
					}
				},
				error:function(e){
					console.log(e)
				}
			});
		}
		
		//가게 리스트 출력
		function storePrintList(list,list_hash){		 
			var content = "";
			list.forEach(function(item,index){
				if(index%3==0){
					content += "<div id='tableLine' style='width:1000px; height:5px;'></div>";
				}
				content += "<table class='storeTable' style='cursor:pointer;'>";
				
				content += "<tr><td style='border-bottom: 2px solid #142e5b; height:50px;' colspan='5'>";
				content += "<div class='store_De'>별점 : "+item.store_star+"</div>";
				content += "<div class='store_De'>조회수 : "+item.store_bHit+"</div>";
				content += "<div class='store_De'>리뷰수 : "+item.store_revCnt+"</div>";
				content += "<div class='store_De'>찜 : "+item.store_storeLikeCnt+"</div>";
				content += "</td></tr>";
				
				content += "<tr><td colspan='5'><img class='storeImg' src='resources/upload/store/"+item.store_photo+"' onclick=location.href='storeDetail?store_idx="+item.store_idx+"' /></td></tr>";
				content += "<tr><td colspan='3'>상호명</td>";
				content += "<th><span onclick=location.href='storeDetail?store_idx="+item.store_idx+"'>"+item.store_name+"</span></th>";
				content += "<td rowspan='2'><img class='storeLikeImg' id='storeLike"+item.store_idx+"' width='30px' height='30px' src='resources/img/storeLike/heart.png' onclick='storeLike("+item.store_idx+")'/></td></tr>";
				content += "<tr><td colspan='3'>주소</td>";
				content += "<th>"+item.store_addr+"</th></tr>";
				
				if(list_hash[index].length != 0){
					content += "<tr><td style='border-top: 2px solid #142e5b; height:70px;' id='"+item.store_idx+"' colspan='5'>";
					
					list_hash[index].forEach(function(item){
						content += "<div id='storehashtag'>"+item.hash_tag+"</div>";
					});
					content += "</td></tr>";
				}else{
					content += "<tr><td style='border-top: 2px solid #142e5b; height:70px;' id='"+item.store_idx+"' colspan='5'>";
					content += "해시태그가 없습니다.</td></tr>";
				}

				content += "</table>";
				storeLikeChk(item.store_idx);
			});
			$("#searchPage").append(content);
			$("#searchPage").append("<div id='tableLine' style='width:1000px; height:5px;'></div>");
			$("#searchPage").append("<div id='store_container'></div>");
		}
		
		//찜하기
		function storeLike(idx) {
			if(id==null){
				alert("로그인이 필요한 서비스입니다.");
			}else{
				$.ajax({
					url:"./storeLike",
					type:"get",
					data:{
						"store_idx":idx
					},
					success:function(data){
						alert(data.msg);
						if(data.msg == "찜 했습니다."){
							$("#storeLike"+idx).attr("src","resources/img/storeLike/heart2.png");
						}else if(data.msg == "찜 취소했습니다."){
							$("#storeLike"+idx).attr("src","resources/img/storeLike/heart.png");
						} 
					},
					error:function(e){
						console.log(e);
					}
				});
			}
		}
		
		//찜 확인
		function storeLikeChk(idx) {
			$.ajax({
				url:"./storeLikeChk",
				type:"get",
				data:{
					"store_idx":idx
				},
				success:function(data){
					id=data.loginId;
					if(data.likeChk==1){
						$("#storeLike"+idx).attr("src","resources/img/storeLike/heart2.png");
					}else{
						$("#storeLike"+idx).attr("src","resources/img/storeLike/heart.png");
					}
				},
				error:function(e){
					console.log(e);
				}
			});
		}
		
		var zoom=false;//줌인or아웃 플레그
		//맵에서만 줌인
		$("body").click(function(e) {
			setZoomable(zoom)
			zoom=false;
		});
		$("#map").click(function(e) {
			zoom=true;
		});
	</script>
</html>