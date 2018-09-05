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
			button#dm_exit{cursor: pointer;}
			button#dm_write{cursor: pointer;}
		</style>
	</head>
	<body>                                 
		<div id="dm_div">
			&nbsp;받는 사람 : <input type="text" id="user1"/><br/>
			<input type="hidden" readonly="readonly" value="${sessionScope.loginId }" id="user2"/><br/>
			<div id="dm_div_content"><textarea rows="10" cols="34" id="dm_content" onkeyup="contentCnt()" maxlength="300"></textarea></div>
			<span id="chk"></span>
			<span id="contentCnt">0/300</span>
			<div id="div_btn">
				<button id="dm_exit">닫기</button>
				<button id="dm_write">보내기</button>
			</div>
		</div>
	</body>
	<script>
		var overlay = false;
		//onkeyup 이벤트(#dm_content)
		function contentCnt() {
			var cnt = $("#dm_content").val();
			console.log(cnt.length);
			$("#contentCnt").html(cnt.length+"/300");
		}
		
		//받는 사람 아이디 있는지 체크
		$("#user1").keyup(function () {
			$.ajax({
				url : "./rest/overlay",
				type : "get",
				data : {
					id : $("#user1").val()
				},
				dataType : "json",
				success : function (data) {
					console.log(data);
					if(data.use != "N"){
						$("#chk").html("아이디가 존재하지 않습니다.");
						overlay = false;
					}else{
						overlay = true;
						$("#chk").html("");
					}
				},
				error : function (error) {
					console.log(error);
				}
			});
		});
		
		//쪽지 보내기
		$("#dm_write").click(function () {
			var user1 = $("#user1").val();
			var dm_content = $("#dm_content").val();
			if(user1 == ""){
				$("#chk").html("받는사람의 아이디를 입력해주세요.");
			}else if(dm_content == ""){
				$("#chk").html("메세지를 입력해주세요.");
				$("#dm.content").focus();
			}else if(overlay == false){
				$("#chk").html("아이디가 존재하지 않습니다.");
			}else{
				$.ajax({
					url : "./dm_write",
					type : "get",
					data : {
						user1 : user1,
						user2 : $("#user2").val(),
						dm_content : dm_content
					},
					dataType : "json",
					success : function (data) {
						console.log(data);
						if(data.result > 0){
							alert(data.msg);
							self.close();
						}
					},
					error : function (error) {
						console.log(error);
					}
				});
			}
		});
		//쪽지창 닫기
		$("#dm_exit").click(function () {
			self.close();
		});
	</script>
</html>