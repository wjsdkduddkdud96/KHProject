<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>신고</title>
		<style>
		 #comp{
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

			body{
			background-color: #142e5b;
				color: white;
				width: 100%;
				height: 100%;
				padding: 0px;
				text-align: center;
				overflow-x:hidden; overflow-y:hidden;
			}
			#complain_content{
				width: 400px;
				height: 230px;
				 resize: none;
				 border-radius: 5px;
			}
			#complain_type{
				width: 80px;
				height: 25px;
				border-radius: 5px;
				font-size: 15px;
				text-align-last: center;
			}
			#compID{
				border-radius: 5px;
			}
			
		</style>
	</head>
	<body>
	
	
	<br/><br/><br/>
		신고할 ID : <input name="compId" id="compID" type="text" value="${complain_Id }" readonly/>
		<input type="hidden" id="Id" name="Id" value="${sessionScope.loginId}"/>
		<input type="hidden" id="complain_cate" name="complain_cate" value="${complain_cate }"/> 
		<input type="hidden" id="idx" name="idx" value="${idx }"/>
		<br/><br/>
		사유 : &nbsp;&nbsp;
		<select id="complain_type" name="complain_type">
		  <option value="욕설" selected="selected">욕설</option>
		  <option value="광고">광고</option>
		  <option value="음란성">음란성</option>
		</select><br/><br/>
		<textarea name="complain_content" id="complain_content" placeholder="신고 내용을 입력해 주세요." maxlength="300"></textarea><br/><br/>
		<input type="button" id="comp" value="신고하기"/>

	</body>
	<script>
	
	$(document).ready(function(){
		if("${sessionScope.loginId}" == ""){
			alert("로그인이 필요한 서비스 입니다.");
			self.close();			
		}
	});
	
	 $("#comp").click(function(){
		 if($("#complain_content").val()!=""){			 
		$.ajax({
			url:"./complain",
			type:"post",
			dataType:"json",
			data:{
				"compId":$("#compID").val(),
				"Id":$("#Id").val(),
				"complain_cate":$("#complain_cate").val(),
				"idx":$("#idx").val(),
				"complain_type":$("#complain_type").val(),
				"complain_content":$("#complain_content").val(),
			},
			success:function(d){
				console.log(d.success);
				 if(d.success == 1){
					self.close();
				} 
			},
			error:function(e){console.log(e);}
		});
		 }
		 else{
			 alert("내용을 입력해 주세요");
			 $("#complain_content").focus();
		 }
	}); 

	
	
	
	</script>
</html>