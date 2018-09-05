<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>Insert title here</title>
		<style>
			#all{background-color: skyblue;width: 450px;height: 320px;}
			#content{width: 400px;height: 200px;margin-left: 25px;margin-top:5px;}
			#sendId{margin-left: 5px;}
			#idchk{position:absolute;font-size:15px;left:260px;top:1px;}
			#message{margin-left: 380px;margin-top:10px;}
		</style>
	</head>
	<body>
		<div id="all">
		받을사람:<input id="sendId" type="text" placeholder="쪽지 받을 사람 아이디" onkeyup="sendid()"/>
		<p id="idchk"></p>
			<br/>
			<div>
		내용:
			</div>
			<textarea id="content" maxlength="100" placeholder="내용은 100자까지입니다"></textarea>
			<button id="message">보내기</button>		
		</div>
	</body>
	<script>
	console.log("${id}");
	if("${id}"!=null){
		$("#sendId").val("${id}");
	}
	var id;
	var userid = "${sessionScope.loginId}";
	var contentmsg; 
	console.log(userid);
	function sendid(){
		id= $("#sendId").val();
		console.log(id);
		 $.ajax({
			url:"./messagesendidcheck",
			type:"get",
			data:{id : id},
			dataType:"json",
			success:function(d){
				console.log(d);
				if(d.id==false){
					$("#idchk").html("아이디가 없습니다");
					$("#idchk").css("color","red");
				}else{
					$("#idchk").html("아이디가 있습니다");
					$("#idchk").css("color","black");
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	};
	 $("#message").click(function(){
		 id= $("#sendId").val();
		 contentmsg= $("#content").val();
		 console.log(contentmsg);
		 if(contentmsg==""){
			 alert("메세지를 입력하세요");
		 }else{
			 if(id != userid){
			  $.ajax({
				url:"./sendmsg",
				type:"get",
				data:{
					userid : userid,
					id : id,				
					content: contentmsg
				},
				dataType:"json",
				success:function(d){
					if(d.success>0){
						alert("메세지를 보냈습니다.");
						self.close();
					}else{
						alert("메세지를 보내는데 실패 했습니다.");
					}
				},
				error:function(e){
					console.log(e);
				}
			 });
			 }else{
				 alert("본인에게는 메세지를 보낼 수 없습니다.")
			 }
		 }
	});
	</script>
</html>