<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>Insert title here</title>
		<style>		
			#receive{float: left;border:1px solid black;background-color: darkblue;color: white;}
			#send{float: left;width:71.63px;border:1px solid black;}
			#messagebox{position: absolute;top: 60px;}
			table, th{border-bottom: 1px solid black;border-top: 1px solid black;border-collapse: collapse;padding: 5px 10px;text-align: center;}
			th{width: 200px;}
			td{border-bottom: 1px solid lightgray;width: 200px;border-collapse: collapse;padding: 5px 10px;text-align: center;}
		</style>
	</head>
	<body>
		<div>
			<div id="receive">
			받은 쪽지
			</div>
			<div id="send">
			보낸 쪽지
			</div>
			<div id="messagebox">
				<table>
					<tr>
						<th>보낸사람</th>
						<th>쪽지내용</th>
						<th>날짜</th>
					</tr>
				</table>
			</div>
		</div>
	</body>
	<script>
	
	</script>
</html>