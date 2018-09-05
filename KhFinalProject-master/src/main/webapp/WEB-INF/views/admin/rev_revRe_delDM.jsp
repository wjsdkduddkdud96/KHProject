<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>리뷰/댓글 쪽지</title>
		<style>
			
			div#dm_div{position: relative; top:35px; left:80px; width: 265px; height: 230px;}
			div#dm_div_content{position: absolute; top: 30px; left: 7px;}
			div#div_btn{position: absolute; top: 215px; left: 152px;}  
			span#contentCnt{position: absolute; top: 190px; left: 225px; color: gray; font-size: 10px;}
			textarea#dm_content{resize: none;}
			span#chk{position: absolute; top: 195px; left: 5px; font-size: 12px; color: red;}
		</style>
	</head>
	<body>
		<input type="hidden" id="review_idx" value="${rev_idx }"/>
		<input type="hidden" id="reviewReply_idx" value="${revReply_idx }"/>
		<input type="hidden" id="id" value="${id }"/>
		
		<div id="dm_div">
			&nbsp;받는 사람 : <input type="text" id="dm_complain_id" readonly="readonly" value="${complain_id }"/><br/>
			<div id="dm_div_content"><textarea rows="10" cols="34" id="dm_content" onkeyup="contentCnt()" maxlength="300"></textarea></div>
			<span id="chk"></span>
			<span id="contentCnt">0/300</span>
			<div id="div_btn">
				<button id="win_exit">닫기</button>
				<button id="dm_write">보내기</button>
			</div>
		</div>
		
	</body>
	<script>
		$(document).ready(function () {
			window.resizeTo(420, 350);
		});
		
		var cate = "신고";
		var alarmuserid="${sessionScope.loginId}";
		var windowOpener = window.opener;
		//location.href="./alarmtimeline?id="+alarmuserid+"&cate="+cate;
	
		function contentCnt() {
			var cnt = $("#dm_content").val();
			$("#contentCnt").html(cnt.length+"/300");
		}
		
	
		$("#win_exit").click(function () {
			self.close();
		});
		
		
		$("#dm_content").focusout(function () {
			if($("#dm_content").val()==""){
				$("#chk").html("메세지를 입력해주세요.");
				$("#dm_content").focus();
			}else{
				$("#chk").html("");
			}
		});
		//쪽지 보내기
		$("#dm_write").click(function () {
			if($("#dm_content").val()==""){
				$("#chk").html("메세지를 입력해주세요.");
				$("#dm_content").focus();
			}else{
				$.ajax({
					url:"./dm_write_rev_revRe_del",
					type:"post",
					data:{
						review_idx : $("#review_idx").val(),
						reviewReply_idx : $("#reviewReply_idx").val(),
						id : $("#id").val(),
						complain_id : $("#dm_complain_id").val(),
						dm_content : $("#dm_content").val()
					},
					dataType:"json",
					success:function(data){
						console.log(data.result);
						console.log(data.msg);
						if(data.result > 0){
							alert(data.msg);
							opener.window.close();
							opener.opener.window.location.href="./alarmtimeline?id="+alarmuserid+"&cate="+cate;
							self.close();
						}
					},
					error:function(error){
						console.log(error);
					}
				});
			}
		});
	</script>
</html>