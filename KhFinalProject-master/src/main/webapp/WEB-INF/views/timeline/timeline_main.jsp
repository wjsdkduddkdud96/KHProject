<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
	<c:import url="/WEB-INF/views/include/main/nav.jsp"/>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
		<script src="resources/js/star.js"></script>
		<script src="resources/js/zer0boxPaging.js" type="text/javascript"></script>
		<title>Insert title here</title>
		<style>
			#profileim{position: absolute;width: 100px;height: 100px;left: 400px;top: 65px;}
			#timelineuserId{position: absolute;width: 150px;height: 60px;text-align: center;left: 500px;top: 50px;}
			#profile{position: absolute;width: 100%;height: 200px;top:178px;}
			#fallow{background-color: lightgray;border:1px solid black;width: 90px;position: absolute;left: 650px;top: 70px;cursor: pointer;}
			#dm{background-color: lightgray;border:1px solid black;width: 110px;position: absolute;left: 750px;top: 70px;cursor: pointer;}
			#myreview{background-color: #2637a4;color : white;border:1px solid black;position: absolute;width:100px;left: 510px;top: 130px;cursor: pointer;}
			#likereview{background-color: lightgray;border:1px solid black;position: absolute;width:100px;left: 610px;top: 130px;cursor: pointer;}
			#likestore{background-color: lightgray;border:1px solid black;position: absolute;width:100px;left: 710px;top: 130px;cursor: pointer;}
			#friend{background-color: lightgray;border:1px solid black;position: absolute;width:120px;left: 810px;top: 130px;cursor: pointer;}
			#userdetai{float: left;width: 180px;position:relative;cursor: pointer;}
			#timeline_reply{background-color: lightgray;border:1px solid black;width:180px;text-align: center;}
			#update{background-color: lightgray;border:1px solid black;width:180px;text-align: center;}
			#message{background-color: lightgray;border:1px solid black;width:180px;text-align: center;}
			#coupon{background-color: lightgray;border:1px solid black;width:180px;text-align: center;}
			#point{background-color: lightgray;border:1px solid black;width:180px;text-align: center;}
			#totalt{background-color: lightgray;border:1px solid black;width:180px;text-align: center;}
			#dm_write{background-color: lightgray;border:1px solid black;width:180px;text-align: center;}
			#store_regist_list{background-color: lightgray;border:1px solid black;width:180px;text-align: center;}
			#complain_list{background-color: lightgray;border:1px solid black;width:180px;text-align: center;}  
			button#complain_move{background-color: #2637a4; color: white; border: none; border-radius: 3px; cursor: pointer;}
			button#store_regist_move{background-color: #2637a4; color: white; border: none; border-radius: 3px; cursor: pointer;}
			button#store_regist_yes{background-color: #2637a4; color: white; border: none; border-radius: 3px; cursor: pointer;}
			button#store_regist_no{background-color: #2637a4; color: white; border: none; border-radius: 3px; cursor: pointer;}
			td.comp_detail1{cursor: pointer;}
			td#comp_content{text-align: left;}
			
			#starBtn{border: none; background-color: #33aaaaff; cursor: pointer;}             
			
			
			#content{position: absolute; width: 600px;height: auto;left : 400px;}
			hr{margin-top:200px;}
			
	        #storeName_td{font-weight: bold;}
	        #reply{border: 1px solid #142e5b;height: 50px;width: 500px;height:auto;}
			#reply_img{width: 50px;height: 40px;padding: 5px;}
			#reply_id{font-size: 20px;width: 100px;text-align: center;}
			#reply_content{padding: 5px;width: 240px;text-align: center;}
			#reply_date{padding: 5px;width: 100px;text-align: center;}
			#reply_table{border-bottom:1px solid black;width:500px;}
			#reply_size{white_space:pre;}
			.reply_btn{width:50px;}
			.reply_clk{display:none;}
			.ddd{display:none;}
			.storeTable{float: left;margin-left:1px; margin-right: 10px;margin-top: 10px;border:1px solid black;width:250px;height:250px;}
			
			.storeImg{width: 250px;height: 100px;}
			#hashtag{border: 2px solid #33aaaaff;font-size: 14px;width: auto;text-align: center;float: left;padding: 0px 5px;margin-right: 5px;}
			#fallowlist{border: 1px solid #33aaaaff;display:none;position:absolute;left:810px;width:410px;top:154px;background-color:white;z-index:15;}
			.followbtn{border:1px solid lightgray;cursor: pointer;}
			#follower{background-color:#2637a4;color:white;width:50px;}
			#following{width:50px;position:absolute;left:50px;top:0px;}
			.friendprofile{width:60px;height:60px;float:left;}
			.followdiv{width:200px;float:left;padding:1px;}
			
			#review_profile{width:50px;height: 50px;float:left;}
			#reviewListDiv{margin-left: 490px;}
			#review{border: 2px solid #142e5b;width: 500px;height: auto;}
        	#listTop{border-bottom: 2px solid #142e5b;height: 50px;line-height: 50px;}
        	#listTop_R{float: right;height: 50px;width: 150px;line-height: 25px;text-align: right;font-size: 13px;}
       		#review_table tr,#review_table td{border-collapse: collapse;margin:0 auto;}
        	#review_table{height: 170px;border-bottom: 2px solid #142e5b;border-collapse: collapse;width: 500px;margin:0 auto;}
        	.starTd{text-align: right; overflow: hidden;}
	        #hashtag{border: 2px solid black;width: 60px;height: 25px;font-size: 12px;text-align: center;line-height: 25px;float: left;margin-left: 5px;}
	        #review_content{border: 0px;width: 99%;height: 100%;resize: none;}
	        #photo{width: 60px;height: 50px;float: left;margin-left: 5px;}
	        
	        .replyDiv{border-bottom: 1px solid #142e5b;border-left: 1px solid #142e5b;border-right: 1px solid #142e5b;width: 500px;}
	        .reviewReply{border-bottom: 1px solid black;border-left: 1px solid black;border-right: 1px solid black;width: 500px;display: none;}
        	#starDiv{width: 100%;height: 30px;}
        	#reviewList_hash,#reviewList_photo{width: 600px;height: auto;overflow: hidden;}
	        #hashtag{border: 2px solid #33aaaaff;font-size: 14px;width: auto;text-align: center; float: left;padding: 0px 5px;}
	        #storeName_td{font-weight: bold;width: 300px;}
	        #tableTop{height: 40px;}
	        .span{text-decoration: none;color: black;font-size: 13px;cursor: pointer;}
	        .span:hover{color: red;}
	        .bigPhoto{width: 505px;height: 250px;background-color: white;display: none;}
	        #review_Write{margin-left: 490px;}
       		#review_range{width: 80px;height: 28px;border-radius: 5px;font-size: 15px;text-align-last: center;margin-left: 350px;border: 1px solid black;}
			#reviewListPro{float: left;border-radius: 8px;overflow: hidden;}
			#likeCntTr{height: 30px;}
			#replySpan{display: table-cell;height: 30px;vertical-align: middle;cursor: pointer;}
			#reply_img{width: 30px;height: 30px;}
			#reply_table{font-size: 13px;}
			.reply_textarea{resize: none;width: 250px;border-radius: 5px;}
			
			.reply_ck{width: 50px;font-size: 12px;margin-right: 5px;cursor: pointer;}
			.reply_ck:hover{color: red;}
			#reply_id{height: 50px;}
			.reviewLikeImg{cursor: pointer;	}
			.PhotoImg{cursor: pointer;}
			.review_photo_td{padding-top: 5px;}
			.star-input>.input,
			.star-input>.input>label:hover,
			.star-input>.input>input:focus+label,
			.star-input>.input>input:checked+label{display: inline-block;vertical-align:middle;background:url('resources/img/star/grade_img.png')no-repeat;}
			.star-input{display:inline-block; white-space:nowrap;width:225px;height:40px;line-height:30px; padding-top: 5px;}
			.star-input>.input{display:inline-block;width:150px;height:28px;background-size:150px;white-space:nowrap;overflow:hidden;position: relative;}
			.star-input>.input>input{position:absolute;width:1px;height:1px;opacity:0;}
			star-input>.input.focus{outline:1px dotted #ddd;}
			.star-input>.input>label{width:30px;height:0;padding:28px 0 0 0;overflow: hidden;float:left;cursor: pointer;position: absolute;top: 0;left: 0;}
			.star-input>.input>label:hover,
			.star-input>.input>input:focus+label,
			.star-input>.input>input:checked+label{background-size: 150px;background-position: 0 bottom;}
			.star-input>.input>label:hover~label{background-image: none;}
			.star-input>.input>label[for="p0.5"]{width:15px;z-index:10;}
			.star-input>.input>label[for="p1.0"]{width:30px;z-index:9;}
			.star-input>.input>label[for="p1.5"]{width:45px;z-index:8;}
			.star-input>.input>label[for="p2.0"]{width:60px;z-index:7;}
			.star-input>.input>label[for="p2.5"]{width:75px;z-index:6;}
			.star-input>.input>label[for="p3.0"]{width:90px;z-index:5;}
			.star-input>.input>label[for="p3.5"]{width:105px;z-index:4;}
			
			.star-input>.input>label[for="p4.0"]{width:120px;z-index:3;}
			.star-input>.input>label[for="p4.5"]{width:135px;z-index:2;}
			.star-input>.input>label[for="p5.0"]{width:150px;z-index:1;}
			.star-input>output{display:inline-block;width:60px; font-size:18px;text-align:right;vertical-align:middle;}
			#div_table{height:auto;overflow:hidden;}
			#container{text-align: center;}
			.replyContainer{text-align: center;}
		</style>
	</head>
	<body>
		<div id="profile">
		<img id="profileim" src="resources/img/member/noprofile.jpg">		
		<h1 id="timelineuserId">${id}</h1>
			<div id="fallow">팔로우 신청</div>
			<div id="dm">메세지 보내기</div>
			<c:if test="${sessionScope.loginId != '관리자' }">
				<div class="userdetail">
					<div id="myreview"></div>
					<div id="likereview"></div>
					<div id="likestore"></div>
					<div id="friend" onclick="fallowlist()"></div>
				</div>
			</c:if>
			<div id="fallowlist"></div>
		</div>		
		<br/>
		<hr/>
		<br/>
		<div class="userdetail" id="userdetai">
			<c:if test="${sessionScope.loginId == '관리자' }">
				<div id="dm_write">쪽지보내기</div>
				<div id="message">쪽지함</div>
				<div id="store_regist_list">가게 등록 관리</div>
				<div id="complain_list">신고 리스트</div>
			</c:if>
			
			<c:if test="${sessionScope.loginId != '관리자' }">
				<div id="update">회원정보수정</div>
				<div id="timeline_reply">작성한댓글리뷰</div>
				<div id="message">쪽지함</div>
				<div id="coupon">구매한 쿠폰</div>
				<div id="point">포인트내역</div>
				<div id="totalt">통계</div>
			</c:if>
		</div>
		
		<div id="content">
		</div>
	</body>
	<script>
		$("#dm_write").click(function () {
			var url = "./dm_writePage";
			var name = "쪽지보내기";
			var option = "width=400, height=300, resizeable=no";
					
			var myWin= window.open(url, name, option);
		});
	 
	console.log("${cate}");
	var replyClick = 1;
	var userid = "${sessionScope.loginId}";
	var page = "";
	var str = "";
	var phone=[];
	var fallowbtn=1;
	var aTag = "";
	var idx = "";
	var showPage = 1;
	//리뷰 로그인체크 후 수정 삭제 신고 a 태그 띄워줌
	function atagCreate(list){
		aTag = "";
		idx = "";
		list.forEach(function(item){
			aTag = "";
			idx=item.review_idx;
			if(userid != ""){
			 if(userid == item.id){	
					aTag += "<span class='span' id='review_update' href='#' onclick='review_update(this,"+idx+")'>수정</span>&nbsp;";
					aTag += "<span class='span' id='review_delete' href='#' onclick='review_delete(this,"+idx+")'>삭제</span>&nbsp;";
				}
			}			
			 $(".listTop_R"+idx).append(aTag);
		});		
	}
	//리뷰 수정폼으로 이동
	function review_update(elem,idx){
		location.href="./review_updateForm?review_idx="+idx;
	}
	//리뷰 별점
	function starSelect(elem){
		$.ajax({
			url:"./review_star",
			type:"post",
			dataType:"json",
			data:{"review_idx":elem},
			success:function(d){
				//console.log(d.reviewStar)
				//console.log(d.reviewStar);
				star_create(d.reviewStar,elem);		
			},
			error:function(e){console.log(e);}
		});	 
	}
	//리뷰 삭제
	function review_delete(elem, idx){
		$.ajax({
			url:"./review_delete",
			type:"post",
			dataType:"json",
			data:{"review_idx":idx},
			success:function(d){
				if(d.success != 0){
					$(elem).parents().parents().parents()[1].remove();
				}
			},
			error:function(e){console.log(e);}
		});
	}
	$(document).ready(function(){
		if("${cate}"=="팔로우"){
			fallowlist();
		}else if("${cate}"=="메세지"){
			console.log("ddd");
			page = "resources/timelinehtml/messagebox.html";
			$("#message").css("background-color","#2637a4");
			$("#message").css("color","white");
			$("#update").css("background-color","lightgray");
			$("#update").css("color","black");
	    	$("#coupon").css("background-color","lightgray");
	    	$("#coupon").css("color","black");
	    	$("#point").css("background-color","lightgray");
	    	$("#point").css("color","black");
	    	$("#totalt").css("background-color","lightgray");
	    	$("#totalt").css("color","black");
	    	$("#myreview").css("background-color","lightgray");
	    	$("#myreview").css("color","black");
	    	$("#likereview").css("background-color","lightgray");
	    	$("#likereview").css("color","black");
	    	$("#likestore").css("background-color","lightgray");	    	
	    	$("#likestore").css("color","black");
	    	$("#timeline_reply").css("background-color","lightgray");
	    	$("#timeline_reply").css("color","black");
	    	$("#store_regist_list").css("background-color","lightgray");	    	
	    	$("#store_regist_list").css("color","black");
	    	$("#complain_list").css("background-color","lightgray");
	    	$("#complain_list").css("color","black");
			$("#content").load(page,function(res, stat) {});
			console.log($("#content"));
	    	ajaxCall(page);	
		}else if("${cate}"=="가게"){
			page = "resources/timelinehtml/store_regist_list.html";
			$("#dm_write").css("background-color","lightgray");
			$("#dm_write").css("color","black");
			$("#message").css("background-color","lightgray");
			$("#message").css("color","black");
			$("#store_regist_list").css("background-color","#2637a4");
			$("#store_regist_list").css("color","white");
			$("#complain_list").css("background-color","lightgray");
			$("#complain_list").css("color","black");
			$("#content").load(page,function(res, stat) {});
			ajaxCall(page);
		}else if("${cate}"=="신고"){
			page = "resources/timelinehtml/complainList.html";
			$("#dm_write").css("background-color","lightgray");
			$("#dm_write").css("color","black");
			$("#message").css("background-color","lightgray");
			$("#message").css("color","black");
			$("#store_regist_list").css("background-color","lightgray");
			$("#store_regist_list").css("color","whblackite");
			$("#complain_list").css("background-color","#2637a4");
			$("#complain_list").css("color","white");
			$("#content").load(page,function(res, stat) {});
			ajaxCall(page);
		}
	});
	
	if(userid==""){
		$("#fallow").css("display","none");
		$("#dm").css("display","none");
		$("#userdetai").css("display","none");
	}
	if(userid=="${id}"){
		$("#fallow").css("display","none");
		$("#dm").css("display","none");
		
	}else{
		$("#userdetai").css("display","none");
		$.ajax({
			url:"./followcheck",
			type:"post",
			data:{
				userid : userid,
				id : "${id}"
			},
			dataType:"json",
			success:function(d){
				if(d.id==true){
					$("#fallow").html("팔로우 취소");
				}else{
					$("#fallow").html("팔로우 신청");
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	$(document).ready(function(){
		$.ajax({
			url:"./maintimeline",
			type:"post",
			data:{
				id : "${id}"
			},
			dataType:"json",
			success:function(d){
				$("#myreview").html("리뷰 "+d.review);
				$("#likereview").html("좋아요 "+d.reviewlike);
				$("#likestore").html("찜한가게 "+d.storelike);
				$("#friend").html("팔로우 목록 "+d.follow);
				if("${cate}"=="" || "${cate}"=="팔로우"){
				timelinereview(showPage);
				}
			},
			error:function(e){
				console.log(e);
			}
		});
		$.ajax({
			url:"./timelinprofile",
			type:"post",
			data:{
				id : "${id}"
			},
			dataType:"json",
			success:function(d){
				//console.log(d.profile);
				if(d.profile==0){
					$("#profileim").attr("src",'resources/img/member/noprofile.jpg');
				}else{
					$("#profileim").attr("src",'resources/upload/'+d.profile);
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	});
	function fallowlist(){
		if(fallowbtn==1){
			console.log(fallowbtn);
			$.ajax({
				url:"./timelinefallowlist",
				type:"post",
				data:{
					id : "${id}",
					page : showPage
				},
				dataType:"json",
				success:function(d){
					//console.log(d.followlist.length);
					$("#friend").css("background-color","#2637a4");
					$("#friend").css("color","white");
					var content = "<div id='userfallow'>";
					content += "<div class='followbtn' id='follower' onclick='follower("+showPage+")'>팔로워</div><div class='followbtn' id='following' onclick='following("+showPage+")'>팔로잉</div>";				
						content += "<div id='followlistdiv'>팔로워 목록이 없습니다</div></div>";
						$("#fallowlist").append(content);
						$("#fallowlist").css('display','block');
					if(d.followlist.length!=0){
						followlist(d.followlist);
						timelinefallowlist(d);
						$("#container").zer0boxPaging({
				            viewRange : 5,
				            currPage : d.currPage1,
				            maxPage : d.range1,
				            clickAction : function(e){
				            	follower($(this).attr('page'));
				            }
				        });
					}
				},
				error:function(e){
					console.log(e);
				}
			});
			fallowbtn=0;
		}else{
			fallowbtn=1;
			$("#fallowlist").empty();
			$("#friend").css("background-color","lightgray");
			$("#friend").css("color","black");
			$("#fallowlist").css('display','none');
		}
	}
	function usertimeline(e){
		console.log(e);
		var gotime=[];
		gotime = e.split("_");
		//console.log(gotime[1]);
		location.href="./timeline?id="+gotime[1];
	}
	function timelinefallowlist(d){		
		d.followlist.forEach(function(i){
			  i.forEach(function(item){
					$("#"+item.id).html("팔로우 취소");
				 })
			})
	}
	//팔로우 리스트
	function follower(page){
		$.ajax({
			url:"./timelinefallowlist",
			type:"post",
			data:{
				id : "${id}",
				page:page
			},
			dataType:"json",
			success:function(d){
				$("#following").css("background-color","lightgray");
				$("#following").css("color","black");
				$("#follower").css("background-color","#2637a4");
				$("#follower").css("color","white");
				console.log(d.followlist.length);
				if(d.followlist.length==0){
					var content = "";
					content += "<div id='followlistdiv'>팔로워 목록이 없습니다</div></div>";
					$("#followlistdiv").empty();
					$("#followlistdiv").append(content);
				}else{
					followlist(d.followlist);
					timelinefallowlist(d);
					$("#container").zer0boxPaging({
			            viewRange : 5,
			            currPage : d.currPage1,
			            maxPage : d.range1,
			            clickAction : function(e){
			            	follower($(this).attr('page'));
			            }
			        });
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	//팔로우 리스트 뿌리기
	function followlist(d){
		//console.log(d);
		var cont="";
		cont+="<div style='height:auto;overflow:hidden'>";
		d.forEach(function(i){
			  i.forEach(function(item){
				  cont += "<div id='followdiv"+item.id+"' class='followdiv'>";
					 if(item.profile==0){
						 cont += "<img class='friendprofile' id='img_"+item.id+"' src='resources/img/member/noprofile.jpg' onclick='usertimeline(id)'/>";
					 }else{
						 cont += "<img class='friendprofile' id='img_"+item.id+"' src='resources/upload/"+item.profile+"' onclick='usertimeline(id)'/>";
					 }
					cont += "<p>"+item.id+"</p>";
					if("${id}"==userid){
						cont += "<button class='fbtn' id='"+item.id+"' onclick='followck(id)'>팔로우 추가</button>"
						}
					cont += "</div>";
			  })
		})
		cont+="</div>";
		  $("#followlistdiv").empty();
		  $("#followlistdiv").append(cont);
		  $("#followlistdiv").append("<div id='container'></div>");
	}
	function followinglist(d){
		 var cont="";
		 cont+="<div style='height:auto;overflow:hidden'>";
		  d.forEach(function(i){
			  i.forEach(function(item){
						 console.log(item.profile);
						 cont += "<div id='followdiv"+item.id+"' class='followdiv'>";
						 if(item.profile==0){
							 cont += "<img class='friendprofile' id='img_"+item.id+"' src='resources/img/member/noprofile.jpg' onclick='usertimeline(id)'/>";
						 }else{
							 cont += "<img class='friendprofile' id='img_"+item.id+"' src='resources/upload/"+item.profile+"' onclick='usertimeline(id)'/>";
						 }
						cont += "<p>"+item.id+"</p>";
						if("${id}"==userid){
							cont += "<button class='fbtn' id='"+item.id+"' onclick='followck(id)'>팔로우 취소</button>"
						}
						cont += "</div>";	
					})
			  })
			  cont+="</div>";
		  $("#followlistdiv").empty();
		  $("#followlistdiv").append(cont);
		  $("#followlistdiv").append("<div id='container'></div>");
	}
	//팔로잉 리스트
	function following(page){
		console.log(page);
		$.ajax({
			url:"./timelinefallowlist",
			type:"post",
			data:{
				id : "${id}",
				page : page
			},
			dataType:"json",
			success:function(d){
				//console.log(d.following.length);
				$("#follower").css("background-color","lightgray");
				$("#follower").css("color","black");
				$("#following").css("background-color","#2637a4");
				$("#following").css("color","white");
				if(d.following.length==0){
					var content = "";
					content += "<div id='followlistdiv'>팔로잉 목록이 없습니다</div></div>";
					$("#followlistdiv").empty();
					$("#followlistdiv").append(content);
				}else{
					followinglist(d.following);	
					$("#container").zer0boxPaging({
			            viewRange : 5,
			            currPage : d.currPage2,
			            maxPage : d.range2,
			            clickAction : function(e){
			            	following($(this).attr('page'));
			            }
			        });
				}				
			},
			error:function(e){
				console.log(e);
			}
		});
	};
	//팔로우리스트에서 팔로우 추가 제거
	function followck(id){
		console.log($("#"+id).html());
		if($("#"+id).html()=="팔로우 추가"){
			$.ajax({
				url:"./followinsert",
				type:"post",
				data:{
					userid : userid,
					id : id
				},
				dataType:"json",
				success:function(d){
					if(d.success>0){
						$("#"+id).html("팔로우 취소");	
					}else{
						alert("팔로우가 안되었습니다.");
					}									
				},
				error:function(e){
					console.log(e);
				}
			});
		}else if($("#"+id).html()=="팔로우 취소"){
			$.ajax({
				url:"./followdelete",
				type:"post",
				data:{
					userid : userid,
					id : id
				},
				dataType:"json",
				success:function(d){
					console.log(d);
					if(d.success>0){
						$("#followdiv"+id).remove();
					}else{
						alert("팔로우 취소가 안되었습니다.");
					}									
				},
				error:function(e){
					console.log(e);
				}
			});
		}
	}
	//리뷰 리스트
	function timelinereview(page){
		if(page==null){
			page=1;
		}
		$.ajax({
			url:"./timelinereviewlist",
			type:"post",
			data:{
				id : "${id}",
				page : page
			},
			dataType:"json",
			success:function(d){
				console.log(d.list.length);
				if(d.list.length!=0){
					printList(d.list);
					atagCreate(d.list);
					$("#container").zer0boxPaging({
			            viewRange : 5,
			            currPage : d.currPage,
			            maxPage : d.range,
			            clickAction : function(e){
			            	timelinereview($(this).attr('page'));
			            }
			        });
				}else{
					$("#content").empty();
					$("#content").append("<div id='container'>작성한 리뷰가 없습니다.</div>");
				}				
			},
			error:function(e){
				console.log(e);
			}
		});
	};
	//리뷰 리스트 출력
	function printList(list){
		var content = "";
		list.forEach(function(item){
			content += "<div id='abc'>"
				content += "<div id='review'>"
				//console.log(item.review_profile);
				if(item.review_profile=="resources/upload/0"){
				content += "<img id='review_profile' src='resources/img/member/noprofile.jpg'/>";
				}else{
				content += "<img id='review_profile' src='"+item.review_profile+"'/>";
				}
				content += "<input type='hidden' id='review_idx"+item.review_idx+"' value='"+item.review_idx+"'/>";
				content += "<div id='listTop'><span onclick='tiemlines(\""+item.id+"\")'>"+item.id+"</span><div id='listTop_R' class='listTop_R"+item.review_idx+"'>";
				if(item.id != loginid || loginid == ""){
					content += "<img id='reviewLike"+item.review_idx+"' width='30px' height='30px' src='resources/img/reviewLike/reviewLike.png' onclick='likeClick(this,"+item.review_idx+")' />";
				}
				content += "<br/></div></div>";
				content += "<table id='review_table'><tr id='tableTop'><td id='storeName_td'>"+item.review_storeName+"</td>";
				content += "<td id='starTd"+item.review_idx+"' class='starTd'></td></tr>";
				content += "<tr><td colspan='2'><textarea id='review_content' readonly>"+item.review_content+"</textarea></td></tr>";
				content += "<tr><td colspan='2' id='reviewList_hash"+item.review_idx+"'></td></tr>";
				content += "<tr><td colspan='2' id='reviewList_photo"+item.review_idx+"'></td></tr><tr id='likeCntTr'><td colspan='2'>"+item.review_likeCnt+"명이 좋아합니다.</td></tr></table>";
				content += "<span id='replySpan' onclick='replySelect("+item.review_idx+","+showPage+")'>댓글"+item.review_replyCnt+"개</span></div>";
				content += "<div class='reviewReply' id='reviewReply"+item.review_idx+"'></div>";	
				content += "<div class='bigPhoto' id='bigPhoto"+item.review_idx+"'></div><br/></div>";		
				idx=item.review_idx;
				starSelect(idx);//리뷰 별점
				hashtag(idx);
				if(loginid != ""){
					likeSelect(idx);//리뷰 좋아요
					}
		})
		$("#content").empty();
		$("#content").append(content);
		$("#content").append("<div id='container'></div>");
	}
	//좋아요 리뷰 리스트
	function revreplyList(list){		 
		var content = "";
		console.log(list);
		list.forEach(function(i){
			i.forEach(function(item){
				//console.log(item.id);
				content += "<div id='abc'>"
					content += "<div id='review'>"
					//console.log(item.review_profile);
					if(item.review_profile=="resources/upload/0"){
					content += "<img id='review_profile' src='resources/img/member/noprofile.jpg'/>";
					}else{
					content += "<img id='review_profile' src='"+item.review_profile+"'/>";
					}
					content += "<input type='hidden' id='review_idx"+item.review_idx+"' value='"+item.review_idx+"'/>";
					content += "<div id='listTop'><span onclick='tiemlines(\""+item.id+"\")'>"+item.id+"</span><div id='listTop_R' class='listTop_R"+item.review_idx+"'>";
					if(item.id != loginid || loginid == ""){
						content += "<img id='reviewLike"+item.review_idx+"' width='30px' height='30px' src='resources/img/reviewLike/reviewLike.png' onclick='likeClick(this,"+item.review_idx+")' />";
					}
					content += "<br/></div></div>";
					content += "<table id='review_table'><tr id='tableTop'><td id='storeName_td'>"+item.review_storeName+"</td>";
					content += "<td id='starTd"+item.review_idx+"' class='starTd'></td></tr>";
					content += "<tr><td colspan='2'><textarea id='review_content' readonly>"+item.review_content+"</textarea></td></tr>";
					content += "<tr><td colspan='2' id='reviewList_hash"+item.review_idx+"'></td></tr>";
					content += "<tr><td colspan='2' id='reviewList_photo"+item.review_idx+"'></td></tr><tr id='likeCntTr'><td colspan='2'>"+item.review_likeCnt+"명이 좋아합니다.</td></tr></table>";
					content += "<span id='replySpan' onclick='replySelect("+item.review_idx+","+showPage+")'>댓글"+item.review_replyCnt+"개</span></div>";
					content += "<div class='reviewReply' id='reviewReply"+item.review_idx+"'></div>";	
					content += "<div class='bigPhoto' id='bigPhoto"+item.review_idx+"'></div><br/></div>";		
					idx=item.review_idx;
					hashtag(idx);
					starSelect(idx);//리뷰 별점
					if(loginid != ""){
						likeSelect(idx);//리뷰 좋아요
						}
			})
		})
		$("#content").empty();
		$("#content").append(content);
		$("#content").append("<div id='container'></div>");
	}
	function tiemlines(id){
		console.log(id);
		location.href="./timeline?id="+id;
	}
	//리뷰 별점 리스트
	function star_create(star,elem){
		//console.log(star+"/"+elem);
		starCre = "";
		starCre +="<span id='star-input' class='star-input'><span id='input' class='input'>";		
		starCre +="<input id='"+elem+"0.5' type='radio' name='star-input"+elem+"' value='0.5' id='p0.5'><label  id='"+elem+"0.5' for='p0.5'>0.5</label>";
		starCre +="<input id='"+elem+"1' type='radio' name='star-input"+elem+"' value='1' id='p1.0'><label  id='"+elem+"1' for='p1.0'>1.0</label>";
		starCre +="<input id='"+elem+"1.5' type='radio' name='star-input"+elem+"' value='1.5' id='p1.5'><label id='"+elem+"1.5' for='p1.5'>1.5</label>";
		starCre +="<input id='"+elem+"2' type='radio' name='star-input"+elem+"' value='2' id='p2.0'><label id='"+elem+"2' for='p2.0'>2.0</label>";
		starCre +="<input id='"+elem+"2.5' type='radio' name='star-input"+elem+"' value='2.5' id='p2.5'><label id='"+elem+"2.5' for='p2.5'>2.5</label>";
		starCre +="<input id='"+elem+"3' type='radio' name='star-input"+elem+"' value='3' id='p3.0'><label id='"+elem+"3' for='p3.0'>3.0</label>";
		starCre +="<input id='"+elem+"3.5' type='radio' name='star-input"+elem+"' value='3.5' id='p3.5'><label id='"+elem+"3.5' for='p3.5'>3.5</label>";
		starCre +="<input id='"+elem+"4' type='radio' name='star-input"+elem+"' value='4' id='p4.0'><label id='"+elem+"4' for='p4.0'>4.0</label>";
		starCre +="<input id='"+elem+"4.5' type='radio' name='star-input"+elem+"' value='4.5' id='p4.5'><label id='"+elem+"4.5' for='p4.5'>4.5</label>";
		starCre +="<input id='"+elem+"5' type='radio' name='star-input"+elem+"' value='5' id='p5.0'><label id='"+elem+"5' for='p5.0'>5.0</label>";
		starCre +="</span></span>";		
  		$("#starTd"+elem).append(starCre);
  		var id = star+"";
  		var idArr=id.split(".").join('\\.');
  		$("#"+elem+idArr).attr('checked', true);
  		$("#starTd"+elem).css("pointer-events","none");
	} 
	function PhotoClick(elem, idx){
		$("#bigPhoto"+idx).empty();
		//console.log($(elem).children().attr("src"));
		var pho="";
		$("#bigPhoto"+idx).toggle(500,function(){			
			pho="<img id='BigPho' src='"+$(elem).children().attr("src")+"' width='250px' height='250px'/>";
			$("#bigPhoto"+idx).append(pho);	
		});
	}
	function replySelect(idx,page){
		$("#reviewReply"+idx).toggle(100,function(){
			console.log(page);
			replyAjax(idx,page);
		});
	}
	//댓글 아작스
	function replyAjax(idx,page){
			$.ajax({
				url:"./replySelect/5/"+page,
				type:"post",
				dataType:"json",
				data:{"review_idx":idx},
				success:function(d){
					//console.log(d.replySelect);
					//댓글 리스트 출력
					replylist(d.replySelect,idx);
					showPage = d.currPage;
					$("#reply_textarea"+idx).focus();
					
					$("#replyContainer"+idx).zer0boxPaging({
		                viewRange : 10,
		                currPage : d.currPage,
		                maxPage : d.range,
		                clickAction : function(e){
		                    console.log($(this).attr('page'));
		                    replyAjax(idx,$(this).attr('page'));
		                }
		            });
					
				},
				error:function(e){console.log(e);}
			});
	}
	/* function othertime(id){
		console.log(id);
		//location.href="./timeline?id="+id;
	} */
	var profileSession="${sessionScope.loginProfile }";
	//댓글 리스트 출력
	 function replylist(list,idx){
		 console.log("replylist");
			var reply = "";
			reply += "<div class='replyDiv' id='reply'><table  id='reply_table'>";
			if(loginid != ""){			
			reply += "<tr><td><img width='30px' height='30px' src='"+profileSession+"'/></td>";
			reply += "<td id='reply_loginId'>"+loginid+"</td><td><textarea id='reply_textarea"+idx+"' class='reply_textarea' maxlength='100'></textarea></td>";
			reply += "<td><input id='replyWrite' type='button' value='작성' onclick='replyWrite(this,"+idx+")'/></td></tr>"
			}
			list.forEach(function(item){
				var date = new Date(item.revreply_date);
				reply +="<tr class='reply_table' id='reply_table"+item.revreply_idx+"'>";
				reply +="<td rowspan='2'><input type='hidden' value='"+item.revreply_idx+"'/><img id='reply_img' src='"+item.revreply_profile+"' onclick='othertime("+item.id+")'/></td>";
				reply +="<td rowspan='2' id='reply_id'><div onclick='tiemlines(\""+item.id+"\")'>"+item.id+"</div></td>";
				reply +="<td rowspan='2' id='reply_content'><textarea class='reply_textarea' maxlength='100' id='reply_textarea"+item.revreply_idx+"' readonly>"+item.revreply_content+"</textarea></td>";
				reply +="<td id='reply_date'>"+date.toLocaleDateString("ko-KR")+"</td></tr><tr>";
				reply+="<td  class='reply_btn' >";
				if(item.id==loginid){										
					reply+="<span class='reply_ck' id='reply_delete"+item.revreply_idx+"' onclick='reply_delete(this,"+item.revreply_idx+","+idx+")' >삭제</span>";
					reply+="<span class='reply_ck' id='reply_update"+item.revreply_idx+"' onclick='reply_updateform(this,"+item.revreply_idx+","+idx+")' >수정</span>";
					//reply+="<span class='reply_ck' id='reply_save' onclick='reply_update(this,"+item.revreply_idx+")' >저장</span>";					
					
					//reply+="<td class='reply_btn' ><input type='button' class='reply_clk'  id='reply_cancel"+item.revreply_idx+"' name='"+item.revreply_content+"' onclick='reply_cancel("+item.revreply_idx+",name)'>취소</td>";
				}else{
					reply += "<span id='complain' class='span' href='#' onclick='replyComplain(this)'>신고</span>";
				}
				
				reply+="</td>";
				reply +="</tr>";			
			})
			reply+="</table></div>";
			$("#reviewReply"+idx).empty();
			$("#reviewReply"+idx).append(reply);
			$("#reviewReply"+idx).append("<div class='replyContainer' id='replyContainer"+idx+"'></div>");
		}
	//댓글 수정폼
		function reply_updateform(elem,reply_idx,review_idx){
			//console.log($(elem).parent().parent().parent());
			$(elem).parent().append("<span class='reply_ck' id='reply_save"+reply_idx+"' onclick='reply_update(this,"+reply_idx+","+review_idx+")' >저장</span>");
			$(elem).remove();
			$("#reply_textarea"+reply_idx).removeAttr("readonly");
			$("#reply_textarea"+reply_idx).focus();
				
		}
	//댓글 수정
		function reply_update(elem,reply_idx,review_idx){
			console.log(idx);
			$.ajax({
				url:"./Revreply_update",
				type:"post",
				dataType:"json",
				data:{"reply_content":$("#reply_textarea"+reply_idx).val(),"reply_idx":reply_idx,"review_idx":review_idx},
				success:function(d){
					console.log(d);	
					if(d > 0){
						$("#reply_textarea"+reply_idx).attr("readonly","true");
						$(elem).parent().append("<span class='reply_ck' id='reply_update"+reply_idx+"' onclick='reply_updateform(this,"+reply_idx+","+review_idx+")' >수정</span>");
						$(elem).remove();
						//$("#reply_save"+reply_idx).css("display","none");
						//$("#reply_update"+reply_idx).css("display","block");
					}
					
				},
				error:function(e){console.log(e);}
			});   
		}
	 
	//댓글 삭제
		function reply_delete(elem,reply_idx,review_idx){
			console.log($(elem).parent().parent()[0]);
			   $.ajax({
				url:"./Revreply_delete",
				type:"post",
				dataType:"json",
				data:{"reply_idx":reply_idx,"review_idx":review_idx},
				success:function(d){
					console.log(d);
					 if(d != 0){
						 $(elem).parent().parent().prev()[0].remove();
						 $(elem).parent().parent()[0].remove();
						 
					} 
				},
				error:function(e){console.log(e);}
			});   
		}
	 //해시태그 아작스
	function hashtag(elem){
		$.ajax({
			url:"./reviewHashPhoto",
			type:"post",
			dataType:"json",
			data:{"review_idx":elem},
			success:function(d){
				printHash(d.reviewHash,elem);		
				printPhoto(d.reviewPhoto,elem);
			},
			error:function(e){console.log(e);}
		});
	}
	//리뷰 해시태그 리스트
	var tag="";
	function printHash(hash,elem){
		tag="";
		hash.forEach(function(item){
			tag += "<div id='hashtag'>#"+item.hash_tag+"</div>";
		});
		$("#reviewList_hash"+elem).append(tag);
	}
	//리뷰 사진
	var img="";
	function printPhoto(photo,elem){
		var phoSrc ="";
  		var photoArr="";
		img="";
		photo.forEach(function(item){
			phoSrc=item.revPhoto_Photo;
			photoArr=phoSrc.split(".").join('\\.')
			img += "<div onclick='PhotoClick(this,"+elem+")' id='photo'><img id='PhotoImg"+item.revPhoto_Photo+"'  width='60px' height='50px' src='"+item.revPhoto_Photo+"'/></div>";
		})
		$("#reviewList_photo"+elem).append(img);
	}
	//좋아요
	function likeSelect(idx){
		$.ajax({
			url:"./reviewLikeSelect",
			type:"post",
			dataType:"json",
			data:{"loginId":loginid},
			success:function(d){
				//console.log(d);
				for(var i=0; i<d.length; i++){
					$("#reviewLike"+d[i].review_idx).attr("src","resources/img/reviewLike/reviewLike2.png");
				}
			},
			error:function(e){console.log(e);}
		});
	}
	//좋아요 클릭
	function likeClick(elem,idx){
		var name=$(elem).parents()[1].childNodes[0].data;
		console.log(name);
		flag=idx;
		console.log(idx+"/"+loginid);
		if(loginid == ""){
			alert("로그인이 필요한 서비스 입니다.");
		}else{		
		 $.ajax({
			url:"./reviewLike",
			type:"post",
			dataType:"text",
			data:{"review_idx":idx, "loginId":loginid,"name":name},
			success:function(d){
				//console.log(d);
				 if(d == "insert"){
					 $("#reviewLike"+idx).attr("src","resources/img/reviewLike/reviewLike2.png");
				}else if(d == "delete"){
					$("#reviewLike"+idx).attr("src","resources/img/reviewLike/reviewLike.png");
				} 
			},
			error:function(e){console.log(e);}
		});
		}
	}
	//댓글 작성
	 function replyWrite(elem,idx){
		 var name=$(elem).parents().parents().parents()[4].childNodes[0].childNodes[1].childNodes[0].data;
		 console.log(name);
		   $.ajax({
				url:"./replyWrite",
				type:"post",
				dataType:"json",
				data:{"review_idx":idx,"loginId":loginid,"reply_content":$("#reply_textarea"+idx).val(),"profile":"resources/upload/"+profileSession,"name":name},
				success:function(d){
					console.log(d);
					replySelect(idx);
				},
				error:function(e){console.log(e);}
			});		 
	 }
	//타임라인 버튼클릭후 페이지로드와 css설정
	$(".userdetail").click(function(e) {
		if(e.target.id == "message") {
			page = "resources/timelinehtml/messagebox.html";
			$("#message").css("background-color","#2637a4");
			$("#message").css("color","white");
			$("#update").css("background-color","lightgray");
			$("#update").css("color","black");
	    	$("#coupon").css("background-color","lightgray");
	    	$("#coupon").css("color","black");
	    	$("#point").css("background-color","lightgray");
	    	$("#point").css("color","black");
	    	$("#totalt").css("background-color","lightgray");
	    	$("#totalt").css("color","black");
	    	$("#myreview").css("background-color","lightgray");
	    	$("#myreview").css("color","black");
	    	$("#likereview").css("background-color","lightgray");
	    	$("#likereview").css("color","black");
	    	$("#likestore").css("background-color","lightgray");	    	
	    	$("#likestore").css("color","black");
	    	$("#timeline_reply").css("background-color","lightgray");
	    	$("#timeline_reply").css("color","black");
	    	$("#store_regist_list").css("background-color","lightgray");	    	
	    	$("#store_regist_list").css("color","black");
	    	$("#complain_list").css("background-color","lightgray");
	    	$("#complain_list").css("color","black");
	    	$("#content").load(page,function(res, stat) {});
	    	console.log($("#content"));
			ajaxCall(page);
		} else if(e.target.id == "coupon") {
			page = "resources/timelinehtml/couponbox.html";
			$("#coupon").css("background-color","#2637a4");
			$("#coupon").css("color","white");
			$("#update").css("background-color","lightgray");
			$("#update").css("color","black");
	    	$("#message").css("background-color","lightgray");
	    	$("#message").css("color","black");
	    	$("#point").css("background-color","lightgray");
	    	$("#point").css("color","black");
	    	$("#totalt").css("background-color","lightgray");
	    	$("#totalt").css("color","black");
	    	$("#myreview").css("background-color","lightgray");
	    	$("#myreview").css("color","black");
	    	$("#likereview").css("background-color","lightgray");
	    	$("#likereview").css("color","black");
	    	$("#likestore").css("background-color","lightgray");
	    	$("#likestore").css("color","black");
	    	$("#timeline_reply").css("background-color","lightgray");
	    	$("#timeline_reply").css("color","black");
	    	$("#content").load(page,function(res, stat) {});
			ajaxCall(page);
		} else if(e.target.id == "point"){
			page = "resources/timelinehtml/pointbox.html";
			$("#point").css("background-color","#2637a4");
			$("#point").css("color","white");
			$("#update").css("background-color","lightgray");
			$("#update").css("color","black");
	    	$("#message").css("background-color","lightgray");
	    	$("#message").css("color","black");
	    	$("#coupon").css("background-color","lightgray");
	    	$("#coupon").css("color","black");
	    	$("#totalt").css("background-color","lightgray");
	    	$("#totalt").css("color","black");
	    	$("#myreview").css("background-color","lightgray");
	    	$("#myreview").css("color","black");
	    	$("#likereview").css("background-color","lightgray");
	    	$("#likereview").css("color","black");
	    	$("#likestore").css("background-color","lightgray");
	    	$("#likestore").css("color","black");
	    	$("#timeline_reply").css("background-color","lightgray");
	    	$("#timeline_reply").css("color","black");
	    	$("#content").load(page,function(res, stat) {});
			ajaxCall(page);
		}else if(e.target.id == "update") {
			page = "resources/timelinehtml/userupdate.html";
			$("#update").css("background-color","#2637a4");
			$("#update").css("color","white");
			$("#coupon").css("background-color","lightgray");
			$("#coupon").css("color","black");
	    	$("#message").css("background-color","lightgray");
	    	$("#message").css("color","black");
	    	$("#point").css("background-color","lightgray");
	    	$("#point").css("color","black");
	    	$("#totalt").css("background-color","lightgray");
	    	$("#totalt").css("color","black");
	    	$("#myreview").css("background-color","lightgray");
	    	$("#myreview").css("color","black");
	    	$("#likereview").css("background-color","lightgray");
	    	$("#likereview").css("color","black");
	    	$("#likestore").css("background-color","lightgray");
	    	$("#likestore").css("color","black");
	    	$("#timeline_reply").css("background-color","lightgray");
	    	$("#timeline_reply").css("color","black");
	    	$("#content").load(page,function(res, stat) {});
			ajaxCall(page);
		}else if(e.target.id == "myreview") {
			page = "reviewlist";
			$("#myreview").css("background-color","#2637a4");
			$("#myreview").css("color","white");
			$("#coupon").css("background-color","lightgray");
			$("#coupon").css("color","black");
	    	$("#message").css("background-color","lightgray");
	    	$("#message").css("color","black");
	    	$("#point").css("background-color","lightgray");
	    	$("#point").css("color","black");
	    	$("#totalt").css("background-color","lightgray");
	    	$("#totalt").css("color","black");
	    	$("#update").css("background-color","lightgray");
	    	$("#update").css("color","black");
	    	$("#likereview").css("background-color","lightgray");
	    	$("#likereview").css("color","black");
	    	$("#likestore").css("background-color","lightgray");
	    	$("#likestore").css("color","black");
	    	$("#timeline_reply").css("background-color","lightgray");
	    	$("#timeline_reply").css("color","black");
	    	ajaxCall(page);
		}else if(e.target.id == "likereview") {
			page = "likereview";
				$("#likereview").css("background-color","#2637a4");
				$("#likereview").css("color","white");
				$("#coupon").css("background-color","lightgray");
				$("#coupon").css("color","black");
		    	$("#message").css("background-color","lightgray");
		    	$("#message").css("color","black");
		    	$("#point").css("background-color","lightgray");
		    	$("#point").css("color","black");
		    	$("#totalt").css("background-color","lightgray");
		    	$("#totalt").css("color","black");
		    	$("#update").css("background-color","lightgray");
		    	$("#update").css("color","black");
		    	$("#myreview").css("background-color","lightgray");
		    	$("#myreview").css("color","black");
		    	$("#likestore").css("background-color","lightgray");
		    	$("#likestore").css("color","black");
		    	$("#timeline_reply").css("background-color","lightgray");
		    	$("#timeline_reply").css("color","black");
		    	ajaxCall(page);
			}else if(e.target.id == "timeline_reply"){
				page = "timeline_reply";
					$("#timeline_reply").css("background-color","#2637a4");
					$("#timeline_reply").css("color","white");
					$("#coupon").css("background-color","lightgray");
					$("#coupon").css("color","black");
			    	$("#message").css("background-color","lightgray");
			    	$("#message").css("color","black");
			    	$("#point").css("background-color","lightgray");
			    	$("#point").css("color","black");
			    	$("#totalt").css("background-color","lightgray");
			    	$("#totalt").css("color","black");
			    	$("#update").css("background-color","lightgray");
			    	$("#update").css("color","black");
			    	$("#myreview").css("background-color","lightgray");
			    	$("#myreview").css("color","black");
			    	$("#likestore").css("background-color","lightgray");
			    	$("#likestore").css("color","black");
			    	$("#likereview").css("background-color","lightgray");
			    	$("#likereview").css("color","black");
			    	ajaxCall(page);
			}else if(e.target.id == "complain_list"){
				page = "resources/timelinehtml/complainList.html";
				$("#dm_write").css("background-color","lightgray");
				$("#dm_write").css("color","black");
				$("#message").css("background-color","lightgray");
				$("#message").css("color","black");
				$("#store_regist_list").css("background-color","lightgray");
				$("#store_regist_list").css("color","black");
				$("#complain_list").css("background-color","#2637a4");
				$("#complain_list").css("color","white");
				$("#content").load(page,function(res, stat) {});
				ajaxCall(page);
			}else if(e.target.id == "store_regist_list"){
				page = "resources/timelinehtml/store_regist_list.html";
					$("#dm_write").css("background-color","lightgray");
					$("#dm_write").css("color","black");
					$("#message").css("background-color","lightgray");
					$("#message").css("color","black");
					$("#store_regist_list").css("background-color","#2637a4");
					$("#store_regist_list").css("color","white");
					$("#complain_list").css("background-color","lightgray");
					$("#complain_list").css("color","black");
					$("#content").load(page,function(res, stat) {});
					ajaxCall(page);
				}else if(e.target.id == "likestore"){
					page = "likestore";
						$("#likestore").css("background-color","#2637a4");
						$("#likestore").css("color","white");
						$("#coupon").css("background-color","lightgray");
						$("#coupon").css("color","black");
				    	$("#message").css("background-color","lightgray");
				    	$("#message").css("color","black");
				    	$("#point").css("background-color","lightgray");
				    	$("#point").css("color","black");
				    	$("#totalt").css("background-color","lightgray");
				    	$("#totalt").css("color","black");
				    	$("#update").css("background-color","lightgray");
				    	$("#update").css("color","black");
				    	$("#myreview").css("background-color","lightgray");
				    	$("#myreview").css("color","black");
				    	$("#timeline_reply").css("background-color","lightgray");
				    	$("#timeline_reply").css("color","black");
				    	$("#likereview").css("background-color","lightgray");
				    	$("#likereview").css("color","black");
				    	ajaxCall(page);
				}else if(e.target.id == "totalt"){
					page = "resources/timelinehtml/statList.html";
					$("#totalt").css("background-color","#2637a4");
					$("#totalt").css("color","white");
					$("#coupon").css("background-color","lightgray");
					$("#coupon").css("color","black");
			    	$("#message").css("background-color","lightgray");
			    	$("#message").css("color","black");
			    	$("#point").css("background-color","lightgray");
			    	$("#point").css("color","black");
			    	$("#update").css("background-color","lightgray");
			    	$("#update").css("color","black");
			    	$("#myreview").css("background-color","lightgray");
			    	$("#myreview").css("color","black");
			    	$("#likereview").css("background-color","lightgray");
			    	$("#likereview").css("color","black");
			    	$("#likestore").css("background-color","lightgray");
			    	$("#likestore").css("color","black");
			    	$("#timeline_reply").css("background-color","lightgray");
			    	$("#timeline_reply").css("color","black");
			    	$("#content").load(page,function(res, stat) {});
			    	ajaxCall(page)
				}
	});		
	//타임라인 버튼들 클릭하여 나오는 리스트들의 아작스
	function ajaxCall(page){
		if(page=="resources/timelinehtml/messagebox.html"){
			receivelistajax(showPage);
		}else if(page=="resources/timelinehtml/pointbox.html"){
			pointlistajax(showPage);
		}else if(page=="resources/timelinehtml/couponbox.html"){
			couponajax(showPage);
		}else if(page == "resources/timelinehtml/complainList.html"){
			complainListPaging(showPage);	
		}else if(page == "resources/timelinehtml/store_regist_list.html"){
			storeRegistListPaging(showPage);	
		}else if(page=="reviewlist"){
			timelinereview(showPage);
		}else if(page=="likereview"){
			timelinelikereview(showPage);
		}else if(page=="timeline_reply"){
			timeline_replyajax(showPage);
		}else if(page == "likestore"){
			likestoreajax(showPage);
		}else if(page == "resources/timelinehtml/userupdate.html"){
			$.ajax({
				url:"./timelineuserupdate",
				type:"post",
				data:{
					id : userid
				},
				dataType:"json",
				success:function(d){
					if(d.update.profile!=0){
						$("#updateprofile").empty();
						$("#updateprofile").append("<img id='updateprofilephoto' src='resources/upload/"+d.update.profile+"' height=150px width=150px/>");
						$("#updateprofile").append("<input id='profilename' type='hidden' value='resources/upload/"+d.update.profile+"'/>")
					}
					console.log(d);
					$("#userId").val(userid);
					$("#userName").val(d.update.name);
					$("#userEmail").val(d.update.email);
					phone=d.update.phone.split("-");
					$("#hp1").val(phone[0]);
					$("#hp2").val(phone[1]);
					$("#hp3").val(phone[2]);
				},
				error:function(e){
					console.log(e);
				}
			});
		}else if(page == "resources/timelinehtml/statList.html"){
			$.ajax({
				url:"./statList",
				type:"get",
				data:{
					id : userid
				},
				dataType:"json",
				success:function(data){
					print_statList(data.storeList);
				},
				error:function(error){
					console.log(error);
				}
			});
		}
	}
	function likestoreajax(page){
		$.ajax({
			url:"./timelinelikestore",
			type:"post",
			data:{
				id : "${id}",
				page:page
			},
			dataType:"json",
			success:function(d){
				console.log(d.list.length);
				if(d.list.length!=0){
					likestorelist(d.list,d.list_hash);
					$("#container").zer0boxPaging({
			            viewRange : 5,
			            currPage : d.currPage,
			            maxPage : d.range,
			            clickAction : function(e){
			            	likestoreajax($(this).attr('page'));
			            }
			        });
				}else{
					$("#content").empty();
					$("#content").append("<div id='container'>좋야요한 가게가 없습니다</div>");
				}
				
			},
			error:function(e){
				console.log(e);
			}
		});
	}

	//가게 등록 리스트 페이징
	function storeRegistListPaging(page) {
		$.ajax({
			url:"./storeRegistList",
			type:"post",
			data : {page : page},
			dataType:"json",
			success:function(data){
				store_regist_list(data.list);
				$("#storeRegist_container").zer0boxPaging({
		            viewRange : 5,
		            currPage : data.currPage,
		            maxPage : data.range,
		            clickAction : function(e){
		            	storeRegistListPaging($(this).attr('page'));
		            }
		        });
			},
			error:function(error){
				console.log(error);
			}
		});
	}
	
	//신고내역리스트 페이징
	function complainListPaging(page) {
		$.ajax({
			url:"./complainList",
			type:"post",
			data : {page : page},
			dataType:"json",
			success:function(data){
				complain_list(data.list);
				$("#complain_container").zer0boxPaging({
		            viewRange : 5,
		            currPage : data.currPage,
		            maxPage : data.range,
		            clickAction : function(e){
		            	complainListPaging($(this).attr('page'));
		            }
		        });
			},
			error:function(error){
				console.log(error);
			}
		});
	}
	function timeline_replyajax(page){
		$.ajax({
			url:"./timeline_reply",
			type:"post",
			data:{
				id : userid,
				page : page
			},
			dataType:"json",
			success:function(d){
				console.log(d);
				if(d.list.length!=0){
					revreplyList(d.list);
					$("#container").zer0boxPaging({
			            viewRange : 5,
			            currPage : d.currPage,
			            maxPage : d.range,
			            clickAction : function(e){
			            	timeline_replyajax($(this).attr('page'));
			            }
			        });
				}else{
					$("#content").empty();
					$("#content").append("<div id='container'>작성한 댓글이 없습니다</div>");
				}
				
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	function timelinelikereview(page){
		$.ajax({
			url:"./timelinelikereview",
			type:"post",
			data:{
				id : "${id}",
				page : page
			},
			dataType:"json",
			success:function(d){
				console.log(d.list);
				if(d.list.length!=0){
					revreplyList(d.list);
					$("#container").zer0boxPaging({
			            viewRange : 5,
			            currPage : d.currPage,
			            maxPage : d.range,
			            clickAction : function(e){
			            	timelinelikereview($(this).attr('page'));
			            }
			        });
				}else{
					$("#content").empty();
					$("#content").append("<div id='container'>좋아요한 리뷰가 없습니다</div>");					
				}				
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	//포인트 아작스
	function pointlistajax(page){
		$.ajax({
			url:"./pointlist",
			type:"get",
			data:{
				id : userid,
				page : page
			},
			dataType:"json",
			success:function(d){
				console.log(d);
				pointlist(d);
				$("#container").zer0boxPaging({
		            viewRange : 5,
		            currPage : d.currPage,
		            maxPage : d.range,
		            clickAction : function(e){
		            	pointlistajax($(this).attr('page'));
		            }
		        });
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	//쿠폰 아작스
	function couponajax(page){		
		$.ajax({
			url:"./couponlist",
			type:"get",
			data:{
				id : userid,
				page : page
			},
			dataType:"json",
			success:function(d){
				couponlist(d.list);
				$("#container").zer0boxPaging({
		            viewRange : 5,
		            currPage : d.currPage,
		            maxPage : d.range,
		            clickAction : function(e){
		            	couponajax($(this).attr('page'));
		            }
		        });
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	//받은 메세지 아작스
	function receivelistajax(page){
		$.ajax({
			url:"./receivelist",
			type:"get",
			data:{
				id : userid,
				page : page
			},
			dataType:"json",
			success:function(d){
				receivelist(d.list);
				$("#container").zer0boxPaging({
	                viewRange : 5,
	                currPage : d.currPage,
	                maxPage : d.range,
	                clickAction : function(e){
	                	receivelistajax($(this).attr('page'));
	                }
	            });
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	//좋아하는 가게 리스트
	function likestorelist(list,hash){
		$("#content").empty();
		var content ="";
		content+="<div id='div_table'></div>";
		$("#content").append(content);
		content="";
		
		list.forEach(function(i, idx){
			i.forEach(function(item,idx){
				content += "<div>";
				content += "<table id='store"+item.store_idx+"' class='storeTable'>";
				content += "<tr><td colspan='2'><img class='storeImg' src='resources/upload/store/"+item.store_photo+"' /></td></tr>";
				content += "<tr>";
				content += "<th><a href='./storeDetail?store_idx="+item.store_idx+"'>"+item.store_name+"</a></th>";
				content += "<td rowspan='2'><img class='storeLikeImg' id='storeLike"+item.store_idx+"' width='30px' height='30px' src='resources/img/storeLike/heart.png' onclick='storeLike("+item.store_idx+")'/></td></tr>";
				content += "<tr>";
				content += "<th>"+item.store_addr+"</th></tr>";
				content += "<tr><td id='"+item.store_idx+"' colspan='2'>";
				hash.forEach(function(ihash,idx){
					ihash.forEach(function(hash,idx){
						if(item.store_idx==hash.store_idx){
							content += "<div id='hashtag'>#"+hash.hash_tag+"</div>";
						}
					})
				})
				content += "</td></tr></table>";
				content += "</div>";
				storeLikeChk(item.store_idx);
			})
		})
		$("#div_table").empty();
		$("#div_table").append(content);
		$("#div_table").after("<div id='container' ></div>");
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
						if(userid=="${id}"){
							$("#store"+idx).remove();
						}						
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
	//쿠폰 리스트
	function couponlist(list){
		var content = "";
		list.forEach(function(item, idx){
			content += "<tr>"
			content +="<td>"+item.couponBox_name+"</td>"
			content +="<td>"+item.couponBox_code+"</td>"
			var coupon_use="";
			if(item.couponBox_use==0){
				coupon_use="사용하지 않은 쿠폰"
			}else{
				coupon_use="사용한 쿠폰"
			}
			content +="<td>"+coupon_use+"</td>"
			content += "</tr>"			
		});
		$("#list").empty();
		$("#list").append(content);//내용 붙이기
		$("#paging").append("<div id='container'></div>");
	}
	//포인트 리스트
	function pointlist(d){
		$("#pointcnt").val(d.memberpoint);
		var content = "";
		d.list.forEach(function(item, idx){
			if(item.pointList_type == "증가"){			
				var plusorminus = '+';
			}else if(item.pointList_type == "감소"){
				var plusorminus = '-';
			}
			content += "<tr>"
			var date = new Date(item.pointList_date);
			content +="<td>"+date.toLocaleDateString("ko-KR")+"</td>"
			content +="<td>"+item.pointList_cate+"</td>"
			content +="<td>"+plusorminus+item.pointList_point+"</td>"
			content += "</tr>"			
		});		
		$("#list").empty();
		$("#list").append(content);//내용 붙이기
		$("#paging").append("<div id='container'></div>");
	}
	//보낸 리스트 아작스
	function send(page){
		if(page==null){
			page=1;
		}
		$("#send").css("background-color","#2637a4");
		$("#send").css("color","white");
		$("#receive").css("background-color","lightgray");
		$("#receive").css("color","black");
		$("#sendorreceive").html("받는사람");
		$.ajax({
			url:"./sendlist",
			type:"get",
			data:{
				id : userid,
				page : page
			},
			dataType:"json",
			success:function(d){
				sendlist(d.list);
				$("#container").zer0boxPaging({
	                viewRange : 5,
	                currPage : d.currPage,
	                maxPage : d.range,
	                clickAction : function(e){
	                	send($(this).attr('page'));
	                }
	            });
			},
			error:function(e){
				console.log(e);
			}
		});
	};
	//받은 리스트 아작스
	function receive(page){
		if(page==null){
			page=1;
		}
		$("#receive").css("background-color","#2637a4");
		$("#receive").css("color","white");
		$("#send").css("background-color","lightgray");
		$("#send").css("color","black");
		$("#sendorreceive").html("보낸사람");
		$.ajax({
			url:"./receivelist",
			type:"get",
			data:{
				id : userid,
				page:page
			},
			dataType:"json",
			success:function(d){
				receivelist(d.list);
				$("#container").zer0boxPaging({
	                viewRange : 5,
	                currPage : d.currPage,
	                maxPage : d.range,
	                clickAction : function(e){
	                	receive($(this).attr('page'));
	                }
	            });
			},
			error:function(e){
				console.log(e);
			}
		});
	};
	//받은 리스트 불러오기
	function receivelist(list){
		var content = "";
		list.forEach(function(item, idx){
			var dm_content=item.dm_content.substring(0,20);
			content += "<tr>"
			content +="<td>"+item.id+"</td>"
			content +="<td id='"+item.dm_idx+"' onclick='receivedetail(id)'>"+dm_content+"</td>"
			var date = new Date(item.dm_date);			
			content +="<td>"+date.toLocaleDateString("ko-KR")+"</td>"
			content += "</tr>"			
		});		
		$("#list").empty();
		$("#list").append(content);//내용 붙이기
		$("#paging").append("<div id='container'></div>");
	}
	//보낸 메세지 리스트 불러오기
	function sendlist(list){
		var content = "";
		list.forEach(function(item, idx){
			var dm_content=item.dm_content.substring(0,20);
			content += "<tr>"
			content +="<td>"+item.dm_id+"</td>"
			content +="<td id='"+item.dm_idx+"' onclick='senddetail(id)'>"+dm_content+"</td>"
			var date = new Date(item.dm_date);	
			content +="<td>"+date.toLocaleDateString("ko-KR")+"</td>"
			content += "</tr>"			
		});
		$("#list").empty();
		$("#list").append(content);//내용 붙이기
		$("#paging").append("<div id='container'></div>");
	}
	//메세지 작성하기
	$("#dm").click(function(e){
		var myWin= window.open("./sendMessage?id="+"${id}","메세지보내기","width=500,height=500");
	});
	//받은 메세지 상세보기
	function receivedetail(e){
		console.log(e);
		var myWin= window.open("./receivedetail?idx="+e,"메세지상세보기","width=500,height=500");
	};
	//보낸 메세지 상세보기
	function senddetail(e){
		console.log(e);
		var myWin= window.open("./senddetail?idx="+e,"메세지상세보기","width=500,height=500");
	};
	//팔로우 신청 버튼 클릭
	$("#fallow").click(function(e){
		//console.log(e.target.innerHTML);
		if(e.target.innerHTML=="팔로우 신청"){
			$.ajax({
				url:"./followinsert",
				type:"post",
				data:{
					userid : userid,
					id : "${id}"
				},
				dataType:"json",
				success:function(d){
					if(d.success>0){
						e.target.innerHTML="팔로우 취소";	
					}else{
						alert("팔로우가 안되었습니다.");
					}									
				},
				error:function(e){
					console.log(e);
				}
			});
		}else if(e.target.innerHTML=="팔로우 취소"){
			$.ajax({
				url:"./followdelete",
				type:"post",
				data:{
					userid : userid,
					id : "${id}"
				},
				dataType:"json",
				success:function(d){
					console.log(d);
					if(d.success>0){
						e.target.innerHTML="팔로우 신청";	
					}else{
						alert("팔로우 취소가 안되었습니다.");
					}									
				},
				error:function(e){
					console.log(e);
				}
			});
		}		
	});
	
		//신고리스트
		var flag = false;
		function complain_list(list) {
			var content = "";		
			list.forEach(function(item, idx){
				if(item.complain_black != 1){
					content +="<tr>";
					content +="<td class='comp_detail1'>"+item.id+"</td>";
					content +="<td class='comp_detail1'>"+item.complain_type+"</td>";
					content +="<td class='comp_detail1'>"+item.complain_id+"</td>";
					content +="<td class='comp_detail1'>"+item.complain_cate+"</td>";
					var date = new Date(item.complain_date);			
					content +="<td class='comp_detail1'>"+date.toLocaleDateString("ko-KR")+"</td>";
					content +="<td id='comp_btn'><button id='complain_move' onclick='complain_move("+item.complain_idx+", "+item.review_idx+", "+item.revReply_idx+", \""+item.id+"\", \""+item.complain_id+"\")'>보 기</button></td>";
					content += "</tr>";
					content += "<tr>";
					content +="<td style='display: none;'>신고 내용 : </td>";
					content +="<td id='comp_content' style='display: none;' colspan='5'>"+item.complain_content+"</td>";
					content += "</tr>";
				}
			});		
			$("#complail_tbody").empty();
			$("#complail_tbody").append(content);//내용 붙이기

			$(".comp_detail1").click(function () {
				console.log("클릭");
				
				if(flag == false){
					$(this).parent().next().children('td').css("display", "");
					flag = true;
				}else{
					$(this).parent().next().children('td').css("display", "none");
					flag = false;
				}
			});
		}
		//신고내역 보기 버튼 클릭이벤트
		function complain_move(complain_idx, rev_idx, revReply_idx, id, complain_id) {
			console.log("클릭");   
			console.log(rev_idx, revReply_idx, id, complain_id);  
			var myWin= window.open("./comp_review_moveWin?complain_idx="+complain_idx+"&rev_idx="+rev_idx+"&revReply_idx="+revReply_idx+"&id="+id+"&complain_id="+complain_id, "신고 리뷰 페이지1","width=500,height=500");		
		}
		
		
		//가게 등록 리스트
		function store_regist_list(list) {
			var content = "";		
			list.forEach(function(item){
				if(item.store_regist == 0){
					var id = new String(item.id);
					content +="<tr>";
					content +="<td id='store_regist_name'>"+item.store_name+"</td>";
					content +="<td>"+item.store_ceo+"</td>";
					content +="<td>"+item.store_addr+"</td>";
					var date = new Date(item.store_revDate);			
					content +="<td>"+date.toLocaleDateString("ko-KR")+"</td>";
					content +="<td><button id='store_regist_move' onclick='regist_move("+item.store_idx+")'>보 기</button></td>";  
		            content +="<td><button id='store_regist_yes' onclick='registYes("+item.store_idx+", \""+item.id+"\")'>승인</button> / "+
		            	"<button id='store_regist_no' onclick='registNo("+item.store_idx+", \""+item.id+"\")'>취소</button></td>";
					content += "</tr>";		
				}	
			});		
			$("#store_tbody").empty();
			$("#store_tbody").append(content);//내용 붙이기

		}
		
		//가게 등록 보기  클릭이벤트
		function regist_move(store_idx) {
			location.href="./storeDetail?store_idx="+store_idx;
		}
		
		var cate = "가게";
		var alarmuserid="${sessionScope.loginId}";
		
		//가게 등록 승인  클릭이벤트
		function registYes(store_idx, id) {
			console.log(store_idx, id);
			var storeConfirm = confirm("승인하시겠습니까?");
			if(storeConfirm){
				$.ajax({
					url:"./registYes",
					type:"post",
					data:{
						store_idx : store_idx,
						id : id
					},
					dataType:"json",
					success:function(data){
						console.log(data);			
						//alert(data.msg);
						//location.href="./storeRegistList";
						location.href="./alarmtimeline?id="+alarmuserid+"&cate="+cate;
					},
					error:function(error){
						console.log(error);
					}
				});
			}else{
				return;
			}
			
		}
		
		//가게 등록 거절  클릭이벤트
		function registNo(store_idx, id) {
			console.log(store_idx, id);
			var myWin= window.open("./registNoWin?store_idx="+store_idx+
					"&id="+id,"가게 등록 거절","width=500,height=300");	
		}
		//회원정보 사진 클릭
		var profileck=0;
		function selPicture(){
			if(profileck==0){
				var myWin= window.open("./profileupload","파일업로드","width=400,height=100");
				selPicturedelete();
				$("#updateprofile").empty();
				profileck=1;
			}else{
				var myWin= window.open("./profileupload","파일업로드","width=400,height=100");
				selPicturedelete();
			}
		}
		//회원정보사진 삭제
		function selPicturedelete(){
			var profilena=$("#profilename").val();
			console.log(profilena);
			if(profilena!=null){
				var photoname=profilena.split("/")[2];
				 $.ajax({
					url:"./profileDel",
					type:"get",
					data:{"fileName":photoname},
					success:function(data){
						console.log(data);
						 if(data.success==1){
							$("#updateprofile").empty();
						} 
					},
					error:function(e){
					console.log(e);
					}
				});
			}			
		}
		
		var regNumber = /^[0-9]*$/;
		
		//회원정보 수정 저장
		function updatesave(){
			if($("#CurrentUserPw").val()==""){//비밀번호
	        	alert("현재 비밀번호를 입력해주세요!!");
	        	$("#CurrentUserPw").focus();
			//}else if($("input[name='userPw']").val()==""){//비밀번호
			}else if($("#userPw").val()==""){//비밀번호
	        	alert("비밀번호를 입력해주세요!!");
	        	$("#userPw").focus();
	        }else if($("#userPwChk").val()==""){//비밀번호확인
	        	alert("비밀번호확인을 입력해주세요!!");
	        	$("#userPwChk").focus();
	        }else if($("#userName").val()==""){//이름
	        	alert("이름을 입력해주세요!!");
	        	$("#userName").focus();
	        }else if($("#userEmail").val()==""){//이메일
	        	alert("이메일을 입력해주세요!!");
	        	$("#userEmail").focus();
	        }else if($("#hp1").val()==""){//핸드폰번호
	        	alert("핸드폰번호를 입력해주세요!!");
	        	$("#hp1").focus();
	        }else if($("#hp2").val()==""){//핸드폰번호
	        	alert("핸드폰번호를 입력해주세요!!");
	        	$("#hp2").focus(); 
	        }else if($("#hp3").val()==""){//핸드폰번호
	        	alert("핸드폰번호를 입력해주세요!!");
	        	$("#hp3").focus();
	        }else if(!regNumber.test($("input[name='hp1']").val())){
	        	alert("휴대폰 번호 앞자리는 숫자만 가능합니다.");
				$("input[name='hp1']").val("");
				$("input[name='hp1']").focus();
	        }else if(!regNumber.test($("input[name='hp2']").val())){
	        	alert("휴대폰 번호 중간자리는 숫자만 가능합니다.");
				$("input[name='hp2']").val("");
				$("input[name='hp2']").focus();
	        }else if(!regNumber.test($("input[name='hp3']").val())){
	        	alert("휴대폰 번호 마지막자리는 숫자만 가능합니다.");
				$("input[name='hp3']").val("");
				$("input[name='hp3']").focus();
	        }else if($("input[name='hp1']").val().length<3){
	        	alert("휴대폰 번호 앞자리는 3자리 이상만 가능합니다.");
	        	$("input[name='hp1']").val("");
				$("input[name='hp1']").focus();
	        }else if($("input[name='hp2']").val().length<3){
	        	alert("휴대폰 번호 중간자리는 3자리 이상만 가능합니다.");
	        	$("input[name='hp2']").val("");
				$("input[name='hp2']").focus();
	        }else if($("input[name='hp3']").val().length<4){
	        	alert("휴대폰 번호 마지막자리는 4자리만 가능합니다.");
	        	$("input[name='hp3']").val("");
				$("input[name='hp3']").focus();
	        }else{
	        	if($("#userPw").val()!=""||$("#userPw").val()!=""){
	        		if($("#userPw").val().length<8 || $("#userPw").val().length>16){	//비밀번호 유효성
			           	alert("비밀번호는 8~16자를 입력해주세요.");
			        }else{
			        	userajax();
			        }
	        	}else{
	        		userajax()
	        	}	        	
	        }			 
		}
		//회원정보 저장 실행 ajax
		function userajax(){
			var profilena=$("#profilename").val();
			var photoname="";
			if($("#profilename").val()==null){
				photoname =0;
			}else{
				photoname=profilena.split("/")[2];
			}			
			console.log(photoname);
			console.log($("#userPw").val());
        	$.ajax({
				url:"./userupdate",
				type:"post",
				data:{
					fileName : photoname,
					id:$("#userId").val(),
					nowpw:$("#CurrentUserPw").val(),
					newpw:$("#userPw").val(),
					username:$("#userName").val(),
					useremail:$("#userEmail").val(),
					hp1:$("#hp1").val(),
					hp2:$("#hp2").val(),
					hp3:$("#hp3").val()
				},
				success:function(d){
					console.log(d.success);
					if(d.success>0){
						location.href="./timeline?id="+$("#userId").val();
					}
					alert(d.msg);
				},
				error:function(e){
				console.log(e);
				}
			});
		}

		//회원정보 수정 새로운 비밀번호 체크
		function chgPw(){
	    	console.log("비교실행");
	        //두 인풋의 일치여부 확인	 
	   	var userPw =$("#userPw").val();
		var userPwChk =$("#userPwChk").val();
	        
	        if(userPw==userPwChk){
	            $("#confirmPw").html("비밀번호가 일치합니다");
	            $("#confirmPw").css("color","green");
	        }else{
	        	$("#confirmPw").html("비밀번호가 일치하지않습니다");
	            $("#confirmPw").css("color","red");
	        }
	    }
		function print_statList(list) {
			var content = "";
			list.forEach(function(item){
				content += "<tr><td>"+item.store_name+"</td>";
				content += "<td><input id='starBtn' type='button' value='보기' onclick='moveStat("+item.store_idx+",\""+item.store_name+"\")'></td></tr>";
				
			})
			$("#storeList").append(content);
		}
		function moveStat(idx, name) {
			var myWin = window.open("./showStat?store_idx="+idx+"&store_name="+name,"통계")
		}
		function chgMail(){
			$("#overlayMail").css("display","inline");
		}
		
		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/; //이메일 정규식
		
		//Email 중복 확인
	    function emailcheck(){
	        data ={};
	        data.email = $("#userEmail").val();
	        ajaxCallMail("./rest/overlayMail",data);	        
	    };
	    
		function ajaxCallMail(reqUrl, reqData){
			$.ajax({
	            url:reqUrl,
	            type:'get',
	            dataType:'json',
	            data: reqData,
	            success:function(d){
	                console.log(d);
	                if(exptext.test($("#userEmail").val())==false){//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우
		        		alert("이메일 형식이 올바르지 않습니다.");
		        		$("#userEmail").val("");
		        		$("#userEmail").focus();
	        			return false;
	            	}
	                if(reqUrl=="./rest/overlayMail"){
	                    if(d.use == "Y"){
	                        alert("사용 가능한 이메일 입니다.");
	                    }else if(d.use == "O"){
	                        alert("사용 가능한 이메일 입니다.");
	                    }else{
	                        alert("누군가가 사용 하고 있는 이메일 입니다.");
	                        $("#userEmail").val("");
	                    }
	                }else{
	                    if(d.success == 1){
	                        alert("가입에 성공 하였습니다.");
	                        location.href="./";
	                    }else{
	                        alert("가입에 실패 하였습니다. 다시 입력 해 주세요!");
	                    }
	                }
	            },
	            error:function(e){
	                console.log(e);
	            }                
	        });
		}
	</script>
</html>