<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<!-- <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> 
		<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script> -->
		<title>신고된 리뷰/댓글</title>
		<style>
			/* #reviewListDiv{ margin-left: 0px; }
			#review{ border: 1px solid #142e5b; width: 500px; height: auto;}
	        #listTop{ border-bottom: 1px solid #142e5b; height: 50px; line-height: 50px; }
	        #listTop_R{float: right; height: 50px; width: 150px; line-height: 25px; 
	        	text-align: right; font-size: 13px;}
	       #review_table tr,#review_table td{ border-collapse: collapse; margin:0 auto;
					/* border:1px solid black; */
			}
	        #review_table{ height: 170px; border-bottom: 2px solid #142e5b; border-collapse: collapse;
				width: 500px; margin:0 auto;}
	        .starTd{ text-align: right; overflow: hidden; }
	        #hashtag{ border: 2px solid black;  width: 60px; height: 25px;
	            font-size: 12px; text-align: center; line-height: 25px; float: left; margin-left: 5px;}
	        #review_content{ border: 0px; width: 99%; height: 100%; resize: none; }
	        #photo{ width: 60px; height: 50px; float: left; margin-left: 5px; }
	        #reviewReply{ border-bottom: 1px solid black; border-left: 1px solid black; border-right: 1px solid black;
	            width: 500px; display: none; }
	        #starDiv{ width: 100%; height: 30px;}
	        #reviewList_hash,#reviewList_photo{ width: 600px; height: auto; overflow: hidden; }
	        #hashtag{ border: 2px solid #33aaaaff;  font-size: 14px; width: auto;            
	            text-align: center;  float: left; padding: 0px 5px; }
	        #storeName_td{ font-weight: bold; width: 300px; }
	        #tableTop{ height: 40px; }
	        .span{text-decoration: none; color: black; }
	        .span:hover{ color: red; }
	        .bigPhoto{ width: 505px; height: 250px; background-color: white; display: none; }

			.star-input>.input,
			.star-input>.input>label:hover,
			.star-input>.input>input:focus+label,
			.star-input>.input>input:checked+label{
			    display: inline-block; vertical-align:middle;
			    background:url('resources/img/star/grade_img.png')no-repeat;}
			.star-input{ display:inline-block;  white-space:nowrap;
			    width:225px;height:40px; 	line-height:30px; padding-top: 5px;}
			.star-input>.input{ display:inline-block; width:150px;height:28px;
			    background-size:150px; white-space:nowrap; overflow:hidden;
			    position: relative;}
			.star-input>.input>input{ position:absolute; width:1px;height:1px; opacity:0;}
			star-input>.input.focus{ outline:1px dotted #ddd;}
			.star-input>.input>label{ width:30px; height:0; padding:28px 0 0 0;
			    overflow: hidden; float:left; cursor: pointer; position: absolute; top: 0; left: 0;}
			.star-input>.input>label:hover,
			.star-input>.input>input:focus+label,
			.star-input>.input>input:checked+label{
			    background-size: 150px;
			    background-position: 0 bottom;
			}
			.star-input>.input>label:hover~label{
			    background-image: none;
			}
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
			.star-input>output{ display:inline-block; width:60px; font-size:18px;
			    text-align:right;  vertical-align:middle;}

			input[type=button]{ vertical-align: middle; padding: 0px 5px; background-color: #33aaaaff;
			            color: white; border-radius: 7px; width: 70px; height: 28px;
			            outline: 0px; border: 0px;}
	       #review_Write{ margin-left: 490px; }
       
	       #review_range{ width: 80px; height: 28px; border-radius: 5px; font-size: 15px; 
	       		text-align-last: center; margin-left: 350px; border: 2px solid #142e5b;} */
	       				#reviewListDiv{margin-left: 550px;}
		
		#review{
            border: 2px solid #142e5b;
            width: 500px;
            height: auto;            
        }
        #listTop{
            border-bottom: 2px solid #142e5b;
            height: 50px;
            line-height: 50px;
        }
        #listTop_R{
            float: right;
            height: 50px;
            width: 150px;
            line-height: 25px;
            text-align: right;
            font-size: 13
            px;
        }
       #review_table tr,#review_table td{
				/* border:1px solid black; */
				border-collapse: collapse;
				margin:0 auto;
        }
        #review_table{
            height: 170px;
    		border-bottom: 2px solid #142e5b;
            border-collapse: collapse;
			width: 500px;
			margin:0 auto;
        }
        .starTd{
            text-align: right;
            overflow: hidden;
        }
        #hashtag{
            border: 2px solid black;
            width: 60px;
            height: 25px;
            font-size: 12px;
            text-align: center;
            line-height: 25px;
            float: left;
            margin-left: 5px;
            margin-bottom: 2px;
        }
        #review_content{
            border: 0px;
            width: 99%;
            height: 100%;
            resize: none;
        }
        #photo{
           
            width: 60px;
            height: 50px;
            float: left;
            margin-left: 5px;
        }
        .reviewReply{
            border-bottom: 2px solid #142e5b;
            border-left: 2px solid #142e5b;
            border-right: 2px solid #142e5b;
            width: 500px;
            display: none;
        }
        #starDiv{
        	width: 100%;
        	height: 30px;
        }
        #reviewList_hash,#reviewList_photo{
        	width: 600px;
       		height: auto;
       		overflow: hidden;
        }
        #hashtag{
        	border: 2px solid #33aaaaff;
            font-size: 14px;
            width: auto;            
            text-align: center; 
            float: left;
            padding: 0px 5px;
        }
        #storeName_td{
        	font-weight: bold;
        	width: 300px;
        }
        #tableTop{height: 40px;}
        .span{
        	text-decoration: none;
        	color: black;
        	font-size: 13px;
        	cursor: pointer;
        }
        .span:hover{	color: red;}
        .bigPhoto{
        	width: 250px;
        	height: 250px;
        	background-color: white;
        	display: none;
        	border-radius: 10px;
        	overflow: hidden; 
        	margin-left: 5px;
        }
        
        
.star-input>.input,
.star-input>.input>label:hover,
.star-input>.input>input:focus+label,
.star-input>.input>input:checked+label{
    display: inline-block;
    vertical-align:middle;
    background:url('resources/img/star/grade_img.png')no-repeat;
}
.star-input{
    display:inline-block; 
    white-space:nowrap;
    width:225px;height:40px;
   line-height:30px; padding-top: 5px;
}
.star-input>.input{
    display:inline-block;
    width:150px;height:28px;
    background-size:150px;
    white-space:nowrap;
    overflow:hidden;
    position: relative;
}
.star-input>.input>input{
    position:absolute;
    width:1px;height:1px;
    opacity:0;
}
star-input>.input.focus{
    outline:1px dotted #ddd;
}
.star-input>.input>label{
    width:30px;height:0;
    padding:28px 0 0 0;
    overflow: hidden;
    float:left;
    cursor: pointer;
    position: absolute;
    top: 0;left: 0;
}
.star-input>.input>label:hover,
.star-input>.input>input:focus+label,
.star-input>.input>input:checked+label{
    background-size: 150px;
    background-position: 0 bottom;
}
.star-input>.input>label:hover~label{
    background-image: none;
}
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
.star-input>output{
    display:inline-block;
    width:60px; font-size:18px;
    text-align:right; 
    vertical-align:middle;
}

input[type=button]{
            vertical-align: middle;
            padding: 0px 5px;
            background-color: #33aaaaff;
            color: white;
            border-radius: 7px;
            /* width: 70px; */
            height: 28px;
            outline: 0px;
            border: 0px;
       }
       #review_Write{	margin-left: 550px;}
       
       #review_range{
				width: 80px;
				height: 28px;
				border-radius: 5px;
				font-size: 15px;
				text-align-last: center;
				margin-left: 350px;
				border: 1px solid black;
			}
			#reviewListPro{
				float: left;
				border-radius: 8px;
				overflow: hidden;
			}
			#likeCntTr{height: 30px;}
			#replySpan{
				display: table-cell;
				height: 30px;
				vertical-align: middle;
				cursor: pointer;
			}
			#reply_img{
				width: 30px;
				height: 30px;
			}
			#reply_table{
				font-size: 13px;
				border: none;
				width: 100%;
			}
			.reply_textarea{				
				 resize: none;
				 width: 330px;
				 border-radius: 5px;
			}
			#replyWrite{width: 50px; font-size: 13px; margin-left: 5px;}
			#replyWrite:hover{
				color: red;
			}
			.reply_ck{
				width: 50px;
				font-size: 12px;
				margin-right: 5px;
				cursor: pointer;
			}
			.reply_ck:hover{color: red;}
			#reply_id{height: 50px;}
			.replyDiv{
				width: 500px;
				
			}
			.reviewLikeImg{cursor: pointer;	}
			.PhotoImg{cursor: pointer;}
			#complain{cursor: pointer;}
			.review_photo_td{
				padding-top: 5px;
			}
			#container{
				margin-right: 530px;
				text-align: center;
			}
			.replyContainer{
				margin-right: 30px;
				text-align: center;
			}
			.replyWriteTr td{
				padding-top: 7px;
				padding-bottom: 10px;
				border-left: 0px;
				border-right: 0px;
				border-bottom: 1px dashed #142e5b;
			}
			.idSpan{
				cursor: pointer;
			}
			.idSpan:hover{
				color: navy;
			}
	       		     
	       	div#btnDiv{position: relative; width: 500px; height: 50px;  
	       		text-align: center; padding-top: 21px;}         	                 
	       	button#blackListBtn{background-color: #2637a4; color: white; border: none;
	       		width: auto; height: 30px; cursor: pointer;}                                   
	       	button#comp_rev_reply_del{background-color: #2637a4; color: white; border: none;
	       		width: auto; height: 30px; cursor: pointer;} 
	       	button#comp_cancel{background-color: #2637a4; color: white; border: none;
	       		width: auto; height: 30px; cursor: pointer;}               
	        button.btn{margin: 0px 30px; border-radius: 5px;'}
	       	
	       
	       	
		</style>
	</head>
	<body>
		<h1>신고된 리뷰&댓글</h1>
		<hr/>
		<div id="btnDiv">
			<button class="btn" id="blackListBtn">블랙리스트 추가</button>
			<button class="btn" id="comp_rev_reply_del">해당 게시물 삭제</button>
			<button class="btn" id="comp_cancel">신고 취하</button>
		</div>
		<br/>
		<div id="reviewListDiv"></div>
	</body>
	<script>
		var cate = "신고";
		var alarmuserid="${sessionScope.loginId}";
		var windowOpener = window.opener;	
	
		$(document).ready(function () {
			window.resizeTo(500, 500);
			var rev_idx = ${rev_idx};
			var revReply_idx = ${revReply_idx};
			
			$.ajax({
				url:"./complain_review_move",
				type:"post",
				data:{
					rev_idx : rev_idx,
					revReply_idx : revReply_idx
				}, 
				dataType:"json",
				success:function(data){
					if(data.list1 != null){
						comp_reviewList(data.list1);	
					}
					if(data.list2 != null){
						comp_revReplyList(data.list2);
					}
					
				},
				error:function(error){
					console.log(error);
				} 
			});
			
			//windowOpener.location.href="./alarmtimeline?id="+alarmuserid+"&cate="+cate;
		});
		//게시물 삭제
		$("#comp_rev_reply_del").click(function () {
			console.log("클릭");
			var rev_idx = ${rev_idx};
			var revReply_idx = ${revReply_idx};
			var id = "${id}";
			var complain_id = "${complain_id}";
			var option = "width=400, height=300";
			var myWin= window.open("./rev_revRe_delDM?rev_idx="+rev_idx+"&revReply_idx="+revReply_idx+"&id="+id+"&complain_id="+complain_id, "신고 리뷰 페이지2", option);	

				
		});

		//신고취하
		$("#comp_cancel").click(function () {
			console.log("클릭");
			var rev_idx = ${rev_idx};
			var revReply_idx = ${revReply_idx};
			var id = "${id}";
			var complain_id = "${complain_id}";
			$.ajax({
				url : "./comp_cancel",
				type : "get",
				dataType : "json",
				data : {
					rev_idx : rev_idx,
					revReply_idx : revReply_idx,
					id : id,
					complain_id : complain_id
				},
				success : function(data){
					console.log(data);
					if(data.result > 0){
						alert(data.msg);
						opener.window.location.href="./alarmtimeline?id="+alarmuserid+"&cate="+cate;
						self.close();
					}
				},
				error : function(error){
					console.log(error);
				}
			});
		});
		
		//블랙리스트 추가
		$("#blackListBtn").click(function () {
			console.log("클릭");  
			var rev_idx = ${rev_idx};
			var revReply_idx = ${revReply_idx};
			var id = "${id}";//신고한 사람의 아이디
			var complain_id = "${complain_id}";
			var complain_idx = ${complain_idx};
			$.ajax({
				url : "./blackListAdd",
				type : "get",
				dataType : "json",
				data : {
					rev_idx : rev_idx,
					revReply_idx : revReply_idx,
					id : id,
					complain_id : complain_id,
					complain_idx: complain_idx
				},
				success : function(data){
					console.log(data);
					if(data.result > 0){
						alert(data.msg);
						opener.window.location.href="./alarmtimeline?id="+alarmuserid+"&cate="+cate;
						self.close();
					}
				},
				error : function(error){
					console.log(error);
				}
			});
		});
		
		var loginId = "${sessionScope.loginId}";
		var idx = ""
		//신고된 리뷰 리스트
		function comp_reviewList(list){		 
			var content = "";
			list.forEach(function(item){
				content += "<div id='abc'>"
				content += "<div id='review'><img id='reviewListPro' width='50px' height='50px' src='"+item.review_profile+"'/><input type='hidden' id='review_idx"+item.review_idx+"' value='"+item.review_idx+"'/>";
				content += "<div id='listTop'>"+item.id+"<div id='listTop_R' class='listTop_R"+item.review_idx+"'><br/>";/* <img class='reviewLikeImg' id='reviewLike"+item.review_idx+"' width='30px' height='30px' src='resources/img/reviewLike/reviewLike.png' onclick='likeClick(this,"+item.review_idx+")' /> */
				/* if(item.id != loginId || loginId == ""){
					content += "<span id='complain' class='span' href='#' onclick='complain(this)'>신고</span>";
				} */
				content += "</div></div>";
				content += "<table id='review_table'><tr id='tableTop'><td id='storeName_td'>"+item.review_storeName+"</td>";
				content += "<td id='starTd"+item.review_idx+"' class='starTd'></td></tr>";
				content += "<tr><td colspan='2'><textarea id='review_content' readonly>"+item.review_content+"</textarea></td></tr>";
				content += "<tr><td colspan='2' id='reviewList_hash"+item.review_idx+"'></td></tr>";
				content += "<tr><td colspan='2' id='reviewList_photo"+item.review_idx+"'></td></tr><tr id='likeCntTr'><td colspan='2'>"+item.review_likeCnt+"명이 좋아합니다.</td></tr></table>";
				//content += "<span id='replySpan' onclick='replySelect("+item.review_idx+")'>댓글"+item.review_replyCnt+"개</span></div>";
				content += "<div class='reviewReply' id='reviewReply"+item.review_idx+"'></div>";	
				content += "<div class='bigPhoto' id='bigPhoto"+item.review_idx+"'></div><br/></div>";
				
				idx = item.review_idx;
				hashtag(item.review_idx);//해시태그
				starSelect(item.review_idx);//리뷰 별점

			});
			$("#reviewListDiv").empty();
			$("#reviewListDiv").append(content);		
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
		 var starCre = "";
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
		
		var profileSession="${sessionScope.loginProfile }";
		
		//신고된 댓글리스트
		function comp_revReplyList(list) {
			var content = "";
			list.forEach(function(item){
				var date = new Date(item.revreply_date);
				content += "<div class='replyDiv' id='reply_divz'  style='border: 1px solid black;'>";
				content +="<table id='revReply-table'>";
				content +="<tr class='reply_table' id='reply_table"+item.revreply_idx+"'>";
				if(item.revreply_profile == "resources/upload/0"){
					content += "<td rowspan='2'><img id='reply_img' src='"+item.revreply_profile+"'/></td>";
				}else{
					content += "<td rowspan='2'><img id='reply_img' src='resources/img/member/noprofile.jpg'/></td>";
				}
				//content +="<td rowspan='2'><img id='reply_img' width='30px' height='30px' src='resources/upload/"+item.revreply_profile+"'/></td>";
				content +="<td rowspan='2' id='reply_id'>"+item.id+"</td>";
				content +="<td rowspan='2' id='reply_content'><textarea cols='40' rows='auto' style='resize: none;'"+item.revreply_idx+"' readonly>"+item.revreply_content+"</textarea></td>";
				content +="<td id='reply_date'>"+date.toLocaleDateString("ko-KR")+"</td></tr>";
				content +="</table>";
				content +="</div>"
			});
			$("#reviewListDiv").empty();
			$("#reviewListDiv").append(content);		

		}
		
		
		//해시태그,사진
		function hashtag(rev_idx){
			 $.ajax({
				url:"./comp_rev_hash_photo",
				type:"post",
				dataType:"json",
				data:{
					rev_idx : rev_idx
				},
				success:function(data){
					console.log(data);
					hashList(data.hash, rev_idx);		
					photoList(data.photo, rev_idx);
				},
				error:function(error){
					console.log(error);
				}
			});	 
		}
		
		//해시태그 리스트
		function hashList(hash, rev_idx){
			var tag="";
			hash.forEach(function(item){
				tag += "<div id='hashtag'>#"+item.hash_tag+"</div>";
			});
			$("#reviewList_hash"+rev_idx).append(tag);
		}
		
		//사진 리스트
		function photoList(photo, rev_idx){
			var phoSrc ="";
	  		var photoArr;
			var img="";
			photo.forEach(function(item){
				phoSrc=item.revPhoto_Photo;
				photoArr=phoSrc.split(".").join('\\.')
				img += "<div onclick='PhotoClick(this,"+rev_idx+")' id='photo'><img id='PhotoImg"+item.revPhoto_Photo+"'  width='60px' height='50px' src='"+item.revPhoto_Photo+"'/></div>";
			})
			$("#reviewList_photo"+rev_idx).append(img);
		}
		//사진클릭시 커짐
		function PhotoClick(elem, idx){
			$("#bigPhoto"+idx).empty();
			//console.log($(elem).children().attr("src"));
			var photo = "";
			$("#bigPhoto"+idx).toggle(500,function(){			
				photo = "<img id='BigPho' src='"+$(elem).children().attr("src")+"' width='250px' height='250px'/>";
				$("#bigPhoto"+idx).append(photo);	
			});
		}
		
		
	</script>
</html>