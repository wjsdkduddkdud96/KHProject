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
            table[name="boardWrite_table"]{position: absolute; top: 30px; left: 10px; width: 700px; height: 500px;}     
			th[name="th_boardWrite_cate"]{width: 100px; height: 30px; background-color: lightskyblue;}  
            td[name="td_boardWrite_cate"]{width: 100px; height: 30px;}
            th[name="th_boardWrite_user_name"]{width: 100px; height: 30px; background-color: lightskyblue;}
            td[name="td_boardWrite_user_name"]{width: 100px; height: 30px; text-align: center;}
            th[name="th_boardWrite_subject"]{width: 100px; height: 30px; background-color: lightskyblue;}       
            td[name="td_boardWrite_subject"]{width: 100px; height: 30px;}
            
            select#category{width: 100%; height: 100%;}
            span#user_id{text-align: center;}
            input#board_subject{width: 100%; height: 100%;}
            textarea#board_content{resize: none; width: 100%; height: 100%;}
            
            button#exit{position: absolute; border: none; background-color: lightskyblue; color:black; border-radius: 2px; font-size: 15px; top: 540px; left: 595px;} 
            button#write{position: absolute; border: none; background-color: lightskyblue; color:black; border-radius: 2px; font-size: 15px; top: 540px; left: 650px;}
    
		</style>
	</head>
	<body>
		<c:import url="/WEB-INF/views/include/main/nav.jsp"/>
		<div id="board">
			<table name="boardWrite_table">
				<tr>
					<th name="th_boardWrite_cate">분류</th>
					<td name="td_boardWrite_cate">
                        <select id="category">
                            <option value="선택하세요" selected>선택하세요</option>
                            <c:if test="${sessionScope.loginId != '관리자' }">
                            	<option>문의사항</option>
                            </c:if>
                        
                            <c:if test="${sessionScope.loginId == '관리자' }">
                            	<option>공지사항</option>
                            	<option>문의사항</option>
                            </c:if>
                        </select>
                    </td>
					<th name="th_boardWrite_user_name">작성자</th>
					<td name="td_boardWrite_user_name"><span id="user_name">${sessionScope.loginId }</span></td>
				</tr>
                <tr>
                    <th name="th_boardWrite_subject">제목</th>
                    <td name="td_boardWrite_subject" colspan="3"><input type="text" id="board_subject"/></td>
                </tr>
                <tr>
                    <td name="td_boardWrite_content" colspan="4"><textarea rows="15" id="board_content" maxlength="1000"></textarea></td>
                </tr>
			</table>
            <button id="exit">취소</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button id="write">글쓰기</button>
		</div>
	</body>
	<script>
		$("#exit").click(function () {
			history.back();   
		})	;
	
		$("#write").click(function () {
			if($("#category").val()=="선택하세요"){
				alert("카테고리를 선택해주세요.");
			}else if($("#board_subject").val()==""){
				alert("제목을 입력해주세요.");
			}else if($("#board_content").val()==""){
				alert("내용을 입력해주세요.");
			}else{
				$.ajax({
					type : "post",
					url : "./boardWrite",
					data : {
						cate : $("#category").val(),
						id : $("#user_name").html(),
						subject : $("#board_subject").val(),
						content : $("#board_content").val()
					},
					dataType : "json",
					success : function (data) {
						console.log(data);
						if(data.success>0){
							console.log(data.success);
							alert("글쓰기 성공");
							location.href="./boardDetail?idx="+data.success
						}else{
							alert("글쓰기 실패");
						}
					},
					error : function (error) {
						console.log(error);
					}
				});
			}
		});
	</script>
</html>