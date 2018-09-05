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
		<form id="fileUpload" action="./newfileUpload" method="post" enctype="multipart/form-data">
			<input type="file" name="file" onchange="fileUpload()"/>
		</form>
	</body>
	<script>
	function fileUpload(){
		$("#fileUpload").submit();
	}
	var filePath="${path}"
		
		if(filePath !=""){
			var content = "";//img태그
			var elem = window.opener.document.getElementById("updateprofile");
			content +="<img width='150' height='150' src='${path}'/>";
			content+="<input id='profilename' value=${path} type='hidden'>"
			content +="<br/>"
			elem.innerHTML += content;
			self.close();
		}
	</script>
</html>