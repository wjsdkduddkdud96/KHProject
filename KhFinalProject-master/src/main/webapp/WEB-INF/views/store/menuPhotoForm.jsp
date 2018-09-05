<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
	<title>파일 업로드</title>
	<style>
	</style>
	</head>
	<body>
		<form id="photoUpload" action="./menuUpload" method="post" enctype="multipart/form-data">
			<input type="file" name="file" onchange="photoUpload()" accept=".jpg,.jpeg,.png,.gif,.bmp"/>
		</form>
	</body>
	<script>
	function photoUpload(){
		$("#photoUpload").submit();
	}
	
	var filePath = "${path}";
	var fileCntD = "${fileCnt}";

	if(filePath != ""){
		var content = "";//img태그
		var elem = window.opener.document.getElementById("editable");
		var fileCnt = window.opener.document.getElementById("fileCnt");
		content +="<div class='menuP'>";
		content +="<img width='250' src='${path}'/>";
		content +="<input class='delBtn' id='${path}' type='button' value='삭제' onclick='menuDel(this)'/><br>";
		content +="</div>";
		elem.innerHTML += content;
		fileCnt.value=fileCntD;
		self.close();
	}
	</script>
</html>