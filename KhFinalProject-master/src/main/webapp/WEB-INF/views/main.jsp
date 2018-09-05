<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<c:import url="/WEB-INF/views/include/main/nav.jsp"/>
	<head>
	<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script> -->
	<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
	<title>CAT :: 맛집 SNS</title>
	<style>

	</style>
	</head>
	<body>
		<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
		<br/><br/>
		<div style="margin-left:250px;">
			<c:import url="/WEB-INF/views/include/common/mainStore.jsp">
				<c:param name="mainStore" value="3"/>
			</c:import>
		</div>
		
		<c:import url="/WEB-INF/views/review/reviewList.jsp">
			<c:param name="idx" value="0"/>
		</c:import>
	
		<c:import url="/WEB-INF/views/include/main/footer.jsp"/>
	</body>
	<script>
	$(document).ready(function(){
		<%
		session.removeAttribute("store_Name");		
		session.removeAttribute("store_Idx");
		%>
	});
	
		var message= "${message}";
			
			if(message!=""){
				alert(message);
				
			}
	</script>
</html>