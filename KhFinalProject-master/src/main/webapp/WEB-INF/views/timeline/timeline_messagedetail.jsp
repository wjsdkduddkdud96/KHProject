<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>Insert title here</title>
		<style>		
			table, th{border: 1px solid black;border-top: 1px solid black;border-collapse: collapse;padding: 5px 10px;}
			td{border: 1px solid black;width: 100px;border-collapse: collapse;padding: 5px 10px;}
			#messageid{width: 200px;}
			#messagecontent{width: 400px;height: 200px;}
			#close{position: absolute;left: 300px;}
			#reply{position: absolute;left: 250px;}
		</style>
	</head>
	<body>
		<table>
 	<tr>
 		<td id="messagetype">${name}</td>
 		<td id="messageid">${detail.id}</td>
 	</tr>
 	<tr>
 		<td colspan="2"><textarea id="messagecontent" readonly>${detail.dm_content}</textarea></td>
 	</tr>
 </table>
 <button id="reply">답장</button>
 <button id="close">닫기</button>
	</body>
	<script>	
	if("${name}"=="받는사람"){
		console.log("${name}");
		$("#messageid").html("${detail.dm_id}");
		$("#reply").css("display","none");
	}
	$("#close").click(function(){
		self.close();
	})
	var myWin;
	$("#reply").click(function(e){	
		//self.close();
		pid=$("#messageid").html();
		console.log(pid);
		myWin= window.open("./sendMessage?id="+pid,"메세지보내기","width=500,height=500");
		myWin.document.getElementById("sendId").value=document.getElementById("messageid").html;
	})
	</script>
</html>