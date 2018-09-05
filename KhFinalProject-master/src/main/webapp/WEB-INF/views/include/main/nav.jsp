<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- <script src="https://code.jquery.com/jquery-3.1.0.min.js"></script> -->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="resources/js/zer0boxPaging.js" type="text/javascript"></script>
<style>
	#nav ul li{list-style: none;  display: inline;	padding: 0px 10px;}
	#nav a{text-decoration: none; color: white; }    
	#mainFrame{position: relative;background-color: white; width:100%; height: 120px;;
		min-width: 1400px;}
	#logoBox{position:absolute;top:10px;left: 10%;}
	#searchBox{position:absolute;top:20px;left: 35%;}
	#menuFrame{position: relative;background-color: #2637a4;width:100%; height: 50px;
		min-width: 1400px;top:20%;}
	#menuBox{position:absolute;top:0px;left: 70%;}	  
	input:-ms-input-placeholder{color:#a8a8a8;}
	input:-webkit-input-placeholder{color:#a8a8a8;}
	input:-moz-input-placeholder{color:#a8a8a8;}            
	#searchBox{ width: 430px; height: 45px; border: 1px solid #2637a4; background-color: #ffffff; float:left;}    
	/* #menu{position: absolute; top: 17px; left: 500px;} */
	#nav select{font-size: 15px; width: 110px; padding: 10px; border:0px; border-right:1px solid #2637a4; outline: none; height: 45px; text-align: center;cursor: pointer;}
	#nav #search_content{font-size: 15px; width: 235px; padding: 10px; border: 0px; outline: none; }
	#nav button{font-size: 15px; width: 50px; height: 100%; border: 0px; background-color: #2637a4; outline: none; float: right; color:#ffffff;cursor: pointer;}
	#profileimg{width: 80px;height : 80px;position:absolute;left:85%;top:1px;cursor: pointer;}
	.btn{background-color:#2637a4; color:white;width:80px;border: 2px solid white;cursor: pointer;}
	#proimg{width: 50px;height : 50px;}
	#profileck{background-color:white;border: 1px solid #2637a4;position:absolute;left:86%;width:175px;top:80px;z-index:3;}
	#profileuserid{margin-left:70px;top:5px;position:absolute;}
	#alarm{background-color:#2637a4;width:50px;height:25px;position:absolute;left:80%;top:40px;text-align: center;color:white;font-size: 20px;cursor:pointer;}
	#alarmlist{text-align: center;display:none;width:300px;position:absolute;left:63%;top:65px;background-color:white;border:1px solid #2637a4;z-index:1;}
	.alarmlistdiv{border:1px solid #2637a4;cursor:pointer;width:300px;z-index:2;}
	#contain{text-align: center;}
	#alarmcnt{background-color:red;width:25px;height:25px;position:absolute;left:78.5%;top:40px;text-align: center;color:white;}
</style>

<nav id="nav">
	<div id="mainFrame">
		<div id="logoBox">
			<a  id="Logo" href="./">
				<img alt="logo" src="resources/img/logo/logo_cat.png">
			</a>
		</div>
        <div id="searchBox">
        	<select id="search_map">
				<option value="" selected="selected" >전체</option>
				<option value="강남구">강남구</option>
				<option value="강동구">강동구</option>
				<option value="강북구">강북구</option>
				<option value="강서구">강서구</option>
				<option value="관악구">관악구</option>
				<option value="광진구">광진구</option>
				<option value="구로구">구로구</option>
				<option value="금천구">금천구</option>
				<option value="노원구">노원구</option>
				<option value="도봉구">도봉구</option>
				<option value="동대문구">동대문구</option>
				<option value="동작구">동작구</option>
				<option value="마포구">마포구</option>
				<option value="서대문구">서대문구</option>
				<option value="서초구">서초구</option>
				<option value="성동구">성동구</option>
				<option value="성북구">성북구</option>
				<option value="송파구">송파구</option>
				<option value="양천구">양천구</option>
				<option value="영등포구">영등포구</option>
				<option value="용산구">용산구</option>
				<option value="은평구">은평구</option>
				<option value="종로구">종로구</option>
				<option value="중구">중구</option>
				<option value="중랑구">중랑구</option>
			</select>
            <input type="text" id="search_content" onkeyup="enterkey()" />
            <button id='searchBtn' type="button" onclick="search()">검색</button>
       	</div>
       	<c:if test="${sessionScope.loginId != null}">
       		<div id="alarmcnt"></div>
			<div id="alarm" onclick="alarmclick()">알람</div>
			<div id="alarmlist">알람이 없습니다</div>
       		<div> 					
				<img id="profileimg" src="" onclick="profileclick()">
			</div>
			<div id="profi"></div>
       	</c:if>
	</div>
       	
	<div id="menuFrame">
        <div id="menuBox">
	        <ul>
			<li><a href="./boardListPage">게시판</a></li>			
			<c:if test="${sessionScope.loginId == null}">
				<li><a href="loginForm">로그인</a></li>            
				<li><a href="joinForm">회원가입</a></li>
			</c:if>
			<c:if test="${sessionScope.loginId != null}">
				<li><a href="./couponShopPage">쿠폰샵</a></li>
			</c:if>	
			</ul>
		</div>
	</div>
	
</nav>

<script>
var profilecli=1;
var alarmck=1;
//console.log(profilecli);
var loginid="${sessionScope.loginId}";
//console.log(loginid);
var showPage=1;
	
	function search(){
		location.href = "./search?search_content=" + $("#search_content").val()+"&search_map=" + $("#search_map").val();
	};	
	function enterkey() {
        if (window.event.keyCode == 13) {
			search();
        }
	}
	
	$( document ).ready(function() {		
	    if(loginid != ""){	    	
	    	$.ajax({
				url:"./profileimg",
				type:"post",
				data:{
					id : loginid
				},
				dataType:"json",
				success:function(d){
					//console.log(d.profileimg.profile);
					if(d.profileimg.profile==0){
						$("#profileimg").attr("src",'resources/img/member/noprofile.jpg');
					}else{
						$("#profileimg").attr("src",d.profileimg.profile);
					}
				},
				error:function(e){
					console.log(e);
				}
			});
	    	
	    	$.ajax({
				url:"./alarmcnt",
				type:"post",
				data:{
					id : loginid
				},
				dataType:"json",
				success:function(d){
					//console.log(d);
					if(d.cnt != 0){
						$("#alarmcnt").html(d.cnt);
					}else{
						$("#alarmcnt").remove();
					}
					
				},
				error:function(e){
					console.log(e);
				}
			});
	    }
	});
	function profileclick(){
		if(profilecli==1){
			console.log(profilecli);
			$.ajax({
				url:"./profileunder",
				type:"post",
				data:{
					id : loginid
				},
				dataType:"json",
				success:function(d){
					console.log(d);
					profileunder(d.profile)
				},
				error:function(e){
					console.log(e);
				}
			});
			profilecli=0;
		}else{
			profilecli=1;
			$("#profi").empty();
		}
		
	}
	function profileunder(data){
		console.log(data);
		var content="<div id='profileck'>";
		if(data.profile==0){
			content +="<img id='proimg' src='resources/img/member/noprofile.jpg'>";
		}else{
		content +="<img id='proimg' src='"+data.profile+"'>";
		}
		content += "<h3 id='profileuserid'>"+data.id+"</h3>";
		content += "<h4>보유 포인트 : "+data.pointCnt+"point</h4>";
		content += "<div class='btn' id='"+data.id+"' onclick='gotimeline(id)'>타임라인</div>";
		content += "<div class='btn' id='"+data.id+"' onclick='logout()'>로그아웃</div>";
		content += "</div>";
		$("#profi").append(content);
	}
	function gotimeline(e){
		console.log(e);
		location.href="./timeline?id="+e;
	}
	
	function logout(){
		console.log("로그아웃 실행");
		location.href="./logout"
	}
	function alarmclick(){
		if(alarmck==1){
			alarmajax(showPage);
			alarmck=0;
		}else{
			alarmck=1;
			$("#alarmlist").css("display","none");
		}
	}
	function alarmajax(page){
		$.ajax({
			url:"./alarmlist",
			type:"post",
			data:{
				id : loginid,
				page:page
			},
			dataType:"json",
			success:function(d){
				$("#alarmlist").css("display","inline");
				if(d.list.length>0){
					alarmlist(d.list);
					$("#contain").zer0boxPaging({
			            viewRange : 5,
			            currPage : d.currPage,
			            maxPage : d.range,
			            clickAction : function(e){
			            	alarmajax($(this).attr('page'));
			            }
			        });
				}			
			},
			error:function(e){
				console.log(e);
			}
		});
	};
	function alarmlist(list){
		var content="";
		list.forEach(function(item){
			content+="<div class='alarmlistdiv' id='"+item.alarm_cate+"' onclick='alarmtime(id)'>";
			content+="<input id='alarmid' type='hidden' value='"+item.alarm_id+"'/>";
			content+="<input id='alarmread' type='hidden' value='"+item.alarm_read+"'/>";
			content+="<input id='alarmidx' type='hidden' value='"+item.alarm_idx+"'/>";
			if(item.alarm_cate=="팔로우"){
				content+="팔로우한 사람이 있습니다";
			}else if(item.alarm_cate=="메세지"){
				content+="새로운 메세지가 있습니다";
			}else if(item.alarm_cate=="좋아요"){
				content+="좋아요수가 증가했습니다";
			}else if(item.alarm_cate=="댓글"){
				content+="새로운 댓글이 있습니다"
			}
			content+="</div>";
		})
		$("#alarmlist").empty();
		$("#alarmlist").append(content);
		$("#alarmlist").append("<div id='contain'></div>");
	}
	function alarmtime(id){
		var alarmuserid=$("#alarmid").val();
		var idx = $("#alarmidx").val();
		if(id=="메세지"||id=="팔로우"){
			$.ajax({
				url:"./alarmread",
				type:"post",
				data:{
					idx : idx
				},
				dataType:"json",
				success:function(d){
					console.log(d);
					if(d.success==true){
						location.href="./alarmtimeline?id="+alarmuserid+"&cate="+id;
					}else{
						alert("페이지 이동에 실패 하였습니다.");
					}				
				},
				error:function(e){
					console.log(e);
				}
			});
		}else{
			$.ajax({
				url:"./alarmread",
				type:"post",
				data:{
					idx : idx
				},
				dataType:"json",
				success:function(d){
					console.log(d);
					if(d.success==true){
						location.href="./timeline?id="+alarmuserid;
					}else{
						alert("페이지 이동에 실패 하였습니다.");
					}				
				},
				error:function(e){
					console.log(e);
				}
			});
		}		
	}
</script>
