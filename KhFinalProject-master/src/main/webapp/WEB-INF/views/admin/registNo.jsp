<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>Insert title here</title>
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
		<input type="hidden" id="store_idx" value="${store_idx }"/>
		<div id="dm_div">
			&nbsp;받는 사람 : <input type="text" id="dm_id" readonly="readonly" value="${id }"/><br/>
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
	
		var cate = "가게";
		var alarmuserid="${sessionScope.loginId}";
		var windowOpener = window.opener;
	
		$("#win_exit").click(function () {
			self.close();
		});
	
		function contentCnt() {
			var cnt = $("#dm_content").val();
			$("#contentCnt").html(cnt.length+"/300");
		}
		
		$("#dm_content").focusout(function () {
			if($("#dm_content").val()==""){
				$("#chk").html("메세지를 입력해주세요.");
				$("#dm_content").focus();
			}else{
				$("#chk").html("");
			}
		});
		
		$("#dm_write").click(function () {
			if($("#dm_content").val()==""){
				$("#chk").html("메세지를 입력해주세요.");
				$("#dm_content").focus();
			}else{
				$.ajax({
					url:"./dm_write_regNo",
					type:"post",
					data:{
						store_idx : $("#store_idx").val(),
						id : $("#dm_id").val(),
						dm_content : $("#dm_content").val()
					},
					dataType:"json",
					success:function(data){	
						alert(data.msg);
						windowOpener.location.href="./alarmtimeline?id="+alarmuserid+"&cate="+cate;
						self.close();
					},
					error:function(error){
						console.log(error);
					}
				});
			}
		});
	</script>
</html>