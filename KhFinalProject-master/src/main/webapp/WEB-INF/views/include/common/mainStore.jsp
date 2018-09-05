<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>Insert title here</title>
		<style>
			#searchPage{
				width:1150px;
				height: 500px;
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
	        #moreStore{
	        	margin-left: 950px;
	        	cursor: pointer;
	        }
	        .store_De{
	        	float: left;
	        	margin-right: 18px;
	        }
		</style>
	</head>
	<body>
		<input id="moreStore" onclick="moreStore()" type="button" value="더보기"/>
		<div id="searchPage"></div>
		<input id="mainStore" type="hidden" value="<c:out value="${param.mainStore}"/>">
	</body>
	<script>
		tableSort("리뷰 최신 순","");
		function tableSort(val, search_content) {
			$.ajax({
				url : "./searchSort/6/1",
				data : {data : val,search_content : search_content,mainStore:$("#mainStore").val()},
				success : function(data) {
 					console.log(data.list);
					console.log(data.list_hash);
					$("#searchPage").empty();
					storePrintList(data.list, data.list_hash);
				},
				error : function(e) {
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
		
		function moreStore(){
			location.href = "./search?search_content=&search_map=";
		}
	</script>
</html>