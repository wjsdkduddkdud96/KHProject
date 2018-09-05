<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>Insert title here</title>
		<style>
			#point{position: absolute;top: 60px;}
			table, th{border-bottom: 1px solid black;border-top: 1px solid black;border-collapse: collapse;padding: 5px 10px;text-align: center;}
			th{width: 200px;}
			td{border-bottom: 1px solid lightgray;width: 200px;border-collapse: collapse;padding: 5px 10px;text-align: center;}
			#name{width: 660px;text-align: center;}
		</style>
	</head>
	<body>
		<div>
			<div id="name">
				포인트 내역
			</div>
			<div id="totalpoint">
				포인트 총액 :
			</div>
			<div id="point">
				<table>
					<tr>
						<th>날짜</th>
						<th>포인트 내역</th>
						<th>금액</th>
					</tr>
				</table>
			</div>
		</div>
	</body>
	<script>

	</script>
</html>