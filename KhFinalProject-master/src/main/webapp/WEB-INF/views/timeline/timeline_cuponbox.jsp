<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>Insert title here</title>
		<style>		
			#cupon{position: absolute;top: 60px;}
			table, th{border-bottom: 1px solid black;border-top: 1px solid black;border-collapse: collapse;padding: 5px 10px;text-align: center;}
			th{width: 200px;}
			td{border-bottom: 1px solid lightgray;width: 200px;border-collapse: collapse;padding: 5px 10px;text-align: center;}
			#name{width: 660px;text-align: center;}
		</style>
	</head>
	<body>
		<div>
			<div id="name">
				구매한 쿠폰
			</div>
			<div id="cupon">
				<table>
					<tr>
						<th>쿠폰이름</th>
						<th>쿠폰 코드</th>
						<th>쿠폰사용여부</th>
					</tr>
				</table>
			</div>
		</div>
	</body>
	<script>

	</script>
</html>