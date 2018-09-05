<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>Insert title here</title>
		<style></style>
	</head>
	<body>
	<form id="fileUpload" action="./fileupload" method="post" enctype="multipart/form-data">
		<input type="file" name="file" onchange="fileUpload()"/>
	</form>
	업로드 한 파일 경로 : <span></span>
</body>
<script>
	function fileUpload(){
		$("#fileUpload").submit();
	}
	var filePath="${path}";
	$("span").text(filePath);
	
	if(filePath != ""){
		var content="";//img 태그
		var elem = window.opener.document.getElementById("editable");
		content += "<div id='imgDiv'><img width='100' height='100' src='${path}'/></br>";
		content += "<input id='${path}' type='button' value='삭제' onclick='del(this)' />"
		content += "</div><input type='hidden' name='review_photo' value='${path}'/>";
		elem.innerHTML += content; 
		self.close();
	}
</script>
</html>