<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>Insert title here</title>
		<style>
            div#board{position: relative; top: 50px; left: 400px; border: none; width: 720px; height: 1000px;}
            table, th, td{border: 1px solid black; border-collapse: collapse;}
            table{position: absolute; top: 30px; left: 10px; width: 700px; height: 500px;}
            /* th{width: 117px; height: 50px; background-color: lightskyblue;}
            td{width: 116px; height: 50px; text-align: center;} */
            
            th#th_cate{width: 50px; height: 50px; background-color: lightskyblue;}               
    		td#td_cate{width: 130px; height: 50px; text-align: center;}     
    		th#th_user_name{width: 100px; height: 50px; background-color: lightskyblue;}
    		td#td_user_name{width: 130px; height: 50px; text-align: center;}
    		th#th_date{width: 100px; height: 50px; background-color: lightskyblue;}
    		td#td_date{width: 130px; height: 50px; text-align: center;}
    		th#th_subject{width: 50px; height: 50px; background-color: lightskyblue;} 
            
            input#board_category{width: 100%; height: 100%;}
            span#user_id{text-align: center;}
            input#board_subject{width: 100%; height: 100%;  border: none;}
            textarea#board_content{resize: none; width: 100%; height: 100%; border: none;}
            
            button#exit{position: absolute; border: none; background-color: lightskyblue; color:black; border-radius: 2px; font-size: 15px; top: 545px; left: 615px;} 
            button#update{position: absolute; border: none; background-color: lightskyblue; color:black; border-radius: 2px; font-size: 15px; top: 545px; left: 665px;}
    
		</style>
	</head>
	<body>
		<c:import url="/WEB-INF/views/include/main/nav.jsp"/>
		<div id="board">
			<table>
				<tr>
					<th id="th_cate">분 류</th>
					<td id="td_cate">
                        ${dto.board_cate }
                    </td>
					<th id="th_user_name">작성자</th>
					<td id="td_user_name">
						<input type="hidden" id="board_idx" value="${dto.board_idx }"/> 
						<span id="user_name">${dto.id }</span>
					</td>
					<th id="th_date">작성날짜</th>
					<td id="td_date">
						<span id="board_date">${dto.board_date }</span>
					</td>
				</tr>
                <tr>
                    <th id="th_subject">제 목</th>
                    <td colspan="5" id="td_subject"><input type="text" id="board_subject" value="${dto.board_subject }"/></td>
                </tr>
                <tr>
                    <td colspan="6" id="td_content"><textarea rows="15" id="board_content">${dto.board_content }</textarea></td>
                </tr>
			</table>
            <button id="exit">취소</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button id="update">수정</button>
		</div>
	</body>
	<script>
		$("#update").click(function () {
			$.ajax({
				type : "post",
				url : "./boardUpdate",
				data : {
					idx : $("#board_idx").val(),
					/* cate : $("#category").val(), */
					/* id : $("#user_name").html(), */
					subject : $("#board_subject").val(),
					content : $("#board_content").val()
				},
				dataType : "json",
				success : function (data) {
					if(data.success>0){
						console.log(data.success);
						alert("수정 성공");
						location.href="./boardDetail?idx="+data.success;
					}else{
						alert("실패 실패");
					}
				},
				error : function (error) {
					console.log(error);
				}
			});
		});
		
		$("#exit").click(function () {
			history.back();
		});
	</script>
</html>