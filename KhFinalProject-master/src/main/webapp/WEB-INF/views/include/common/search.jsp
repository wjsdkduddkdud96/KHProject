<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>검색</title>
		<style></style>
	</head>
	<body>
		<c:import url="/WEB-INF/views/include/main/nav.jsp"/>
		
		<div style="margin-left:250px; margin-bottom:150px; height: auto; overflow: auto;">
			<c:import url="/WEB-INF/views/include/common/searchContent.jsp"/>
		</div>

		<div>
		<c:import url="/WEB-INF/views/review/reviewList.jsp">
			<c:param name="idx" value="-1"/>
			<c:param name="reviewSearch" value="<%=request.getParameter(\"search_content\") %>"/>
		</c:import>
		</div>
	</body>
	<script>
	<%
	session.removeAttribute("store_Name");		
	session.removeAttribute("store_Idx");
%>
	</script>
</html>