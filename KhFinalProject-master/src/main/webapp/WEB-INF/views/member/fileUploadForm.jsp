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
		<form id="fileUpload" action="./fileUpload" method="post" enctype="multipart/form-data">
			<input type="file" name="file" onchange="fileUpload(this)"/>
		</form>
	</body>
	<script>
		function fileUpload(photoEvt){
			var thumbext = photoEvt.value; //파일을 추가한 input 박스의 값
		    thumbext = thumbext.slice(thumbext.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로
		     if(thumbext != "jpg" && thumbext != "png" &&  thumbext != "bmp"){ //확장자를 확인
		         alert("확장자는 이미지 파일(jpg, png, bmp)만 등록 가능합니다.");
		         self.close();
		      }else{
					$("#fileUpload").submit();
		      }
		}
 		var filePath = "${path}";
		var imgId = filePath+"img";
		
 		if(filePath != ""){
			var content = "";//img 태그
			var elem = window.opener.document.getElementById("profile");
			content +="<input type='hidden' name='hiddenProfile' value='${path}'/><br/>";
			content +="<img name='memberProfile' width='150' height='150' src='${path}'/>";
			
/* 			content +="<input id='${path}' type='button' value='삭제' onclick='del(this)'>"; 
			content +="<br/>";*/
			elem.innerHTML = content;
			self.close();
		}else{
			var content = "";//img 태그
			var elem = window.opener.document.getElementById("profile");
			content ="<img width='150' height='150' src=resources/img/member/noprofile.jpg/>";
			elem.innerHTML = content;
		}
	</script>
</html>

