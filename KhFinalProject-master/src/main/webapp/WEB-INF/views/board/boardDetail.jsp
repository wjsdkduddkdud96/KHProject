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
            table#board_table{position: absolute; top: 30px; left: 10px; width: 700px; height: 500px;}             
       		/* 게시판 작성 테이블 */
            th#th_cate{width: 50px; height: 50px; background-color: lightskyblue;}               
    		td#td_cate{width: 130px; height: 50px; text-align: center;}     
    		th#th_user_name{width: 100px; height: 50px; background-color: lightskyblue;}
    		td#td_user_name{width: 130px; height: 50px; text-align: center;}
    		th#th_date{width: 100px; height: 50px; background-color: lightskyblue;}
    		td#td_date{width: 130px; height: 50px; text-align: center;}
    		th#th_subject{width: 50px; height: 50px; background-color: lightskyblue;}  
            
            input#board_category{width: 100%; height: 100%;}
            input#board_subject{width: 100%; height: 100%;}
            textarea#board_content{resize: none; width: 100%; height: 100%; border: none;}
            /* 목록,수정,삭제 버튼 */
            button#list_btn{position: absolute; border: none; background-color: lightskyblue; color:black; border-radius: 2px; font-size: 15px; top: 545px; left: 565px;}
            button#delete{position: absolute; border: none; background-color: lightskyblue; color:black; border-radius: 2px; font-size: 15px; top: 545px; left: 665px;} 
            button#update{position: absolute; border: none; background-color: lightskyblue; color:black; border-radius: 2px; font-size: 15px; top: 545px; left: 615px;}
    	
    	
    		/* 댓글 CSS */
    		table#boardReplyWrite_table{
    			position: absolute; top: 200px; left: 10px; width: 700px; height: 50px;}  
    		div#boardReply_write{position: absolute; top: 600px; left: 408px;}  
    		/* 댓글 작성 테이블 */
    		td#replyTd_user_name{width: 100px; height: 50px; text-align: center;}   
    		td#replyTd_content{width: 500px; height: 50px;}
    		textarea#boardReply_content{width: 100%; height: 100%; border: none; overflow: hidden; resize: none;}
     		td#replyTd_write{width: 100px; height: 50px; text-align: center;}   
    		button#replyWrite{/* width: 100%; height: 100%;  */border: none; outline: none; border-radius: 2px; background-color: lightskyblue; }
    		/* 댓글 리스트 테이블 */
    		div#boardReply_list{position: absolute; top: 625px; left: 408px;}
    		table#boardReply_table{
    			position: absolute; top: 255px; left: 10px; width: 700px; height: 100px;  
    		}          
    		td#replyListTd_user_name{width: 100px; height: 100px;}
    		td#replyListTd_content{width: 500px; height: 100px;}/* white-space: pre; */
    		textarea#reply_content1{width: 100%; height: 100%; resize: none; border: none; overflow: hidden;} 
    		textarea#reply_content2{width: 100%; height: 100%; border: none; overflow: hidden;  resize: none; }
    		td#replyListTd_btn{width: 100px; height: 100px;}
    		       
        	/* 댓글 수정,삭제,저장,취소 버튼 */
        	button#replyUpdate{background-color: lightskyblue; border: 1px solid black; border-radius: 2px;}
        	button#replyDelete{background-color: lightskyblue; border: 1px solid black; border-radius: 2px;}
        	button#replySave{background-color: lightskyblue; border: 1px solid black; border-radius: 2px;}
        	button#replyExit{background-color: lightskyblue; border: 1px solid black; border-radius: 2px;}
		</style>
	</head>
	<body>
		<c:import url="/WEB-INF/views/include/main/nav.jsp"/>
		<div id="board">
			<table id="board_table">
				<tr>
					<th id="th_cate">분 류</th>
					<td id="td_cate">
                        ${dto.board_cate }
                    </td>
					<th id="th_user_name">작성자</th>
					<td id="td_user_name">
						<!-- <span id="user_name"> -->${dto.id }<!-- </span> -->
					</td>
					<th id="th_date">작성날짜</th>
					<td id="td_date">
						<!-- <span id="board_date"> -->${dto.board_date }<!-- </span> -->
					</td>
				</tr>
                <tr>
                    <th id="th_subject">제 목</th>
                    <td id="td_subject" colspan="5">${dto.board_subject }</td>
                </tr>
                <tr>
                    <td colspan="6"><textarea rows="15" id="board_content" readonly="readonly">${dto.board_content }</textarea></td>
                </tr>
			</table>
			<button id="list_btn">목록</button>
			<c:if test="${sessionScope.loginId == dto.id || sessionScope.loginId == '관리자'}">
	            <button id="delete">삭제</button>
	            <button id="update" onclick="update()">수정</button>   
            </c:if>
		</div>
		<c:if test="${dto.board_cate == '문의사항'}">                   
			<div id="boardReply_write">    
				<table id="boardReplyWrite_table"> 
					<tr>
						<td id="replyTd_user_name">
							<input type="hidden" id="board_idx" value="${dto.board_idx }"/>
							<input type="hidden" id="board_id" value="${sessionScope.loginId }"/>
							${sessionScope.loginId }
						</td>
						  
						<td id="replyTd_content"><textarea id="boardReply_content" rows="4" cols="70" maxlength="300"></textarea></td>
						
						<td id="replyTd_write"><button id="replyWrite">댓글등록</button></td>
					</tr>
				</table>
			</div>
		</c:if>

		<div id="boardReply_list">
			<table id="boardReply_table">   
				<thead id="reply">
					
				</thead>
			</table>
		</div>
	</body>
	<script>
		var loginId = "${sessionScope.loginId}";//댓글 리스트 메소드에서 사용
		if(loginId != "관리자"){
			$("#boardReply_write").css("display","none");
		}
		
		/* $("#boardReply_content").on("keyup", function () {
			  $(this).height(50).height( $(this).prop("scrollHeight")+12 );	
		}); */
		
		

	
		function update() {
			location.href="updateForm?idx="+${dto.board_idx};
		}
		
		$("#list_btn").click(function () {
			location.href="./boardListPage";
		});
			
		var cate = "${dto.board_cate}";
		//댓글 리스트
		$(document).ready(function () {
			if(cate == '문의사항'){
				$.ajax({
					type : "post",
					url : "./boardReplyList",
					data : { idx : $("#board_idx").val() },
					dataType : "json",
					success : function (data) {
						if(data.replyCnt == 1){
							$("#boardReply_content").attr("readonly", "readonly");
							$("#replyWrite").attr("disabled","true");
						}
						reply(data.list);
						$("#reply_content1").height($("#boardReply_content").height()).height($("#reply_content1").prop("scrollHeight")+12 );
					},
					error : function (error) { console.log(error); }
				});
			}
		});
		
		//댓글 리스트 메소드
		function reply(list) {
			var content = "";
			list.forEach(function(item, idx) {
				var date = new Date(item.boardReply_date);
				content += "<tr>";  
				content += "<td id='replyListTd_user_name'>"+item.id+"<br/>"+"<span style='font-size: 12px;'>"+date.toLocaleDateString("ko-KR")+"</span>"+"</td>";
				content += "<td id='replyListTd_content'><textarea id='reply_content1' readonly='readonly'>"+item.boardReply_content+"</textarea>"+
					"<textarea id='reply_content2' style='display:none;'>"+
					item.boardReply_content+"</textarea></td>";   
				if(loginId != "관리자"){                               
					content += "</tr>";                
				}else{             
					content += "<td align='center' id='replyListTd_btn'><button id='replyUpdate'>수정</button>"+  
						"<button id='replyDelete'>삭제</button>"+
						"<button id='replySave' style='display:none;'>저장</button>"+
						"<button id='replyExit' style='display:none;'>취소</button></td>";
					content += "</tr>";   
				}    
			});      
			
			
			
			
			$("#reply").empty();
			$("#reply").append(content); 
			
			//댓글 수정
			$("#replyUpdate").click(function () {
				$("#replyUpdate").css("display","none");
				$("#replySave").css("display","");
				$("#reply_content1").css("display","none");
				$("#reply_content2").css("display","");
				$("#replyDelete").css("display","none");
				$("#replyExit").css("display","");
				
				$("#reply_content2").height($("#boardReply_content").height()).height($("#reply_content2").prop("scrollHeight")+12 );
				//댓글 작성할 때마다 textarea 늘리기
				$("#reply_content2").on("keyup", function () {
					$("#reply_content2").height($("#boardReply_content").height()).height($("#reply_content2").prop("scrollHeight")+12 );
				});
				
			});
			
			//댓글 수정 취소
			$("#replyExit").click(function () {
				$("#replyUpdate").css("display","");
				$("#replySave").css("display","none");
				$("#reply_content1").css("display","");
				$("#reply_content2").css("display","none");
				$("#replyDelete").css("display","");
				$("#replyExit").css("display","none");
			});
			
			//댓글 수정
			$("#replySave").click(function () {
				console.log($("#reply_content2").val());
				$.ajax({ 
					type : "post",
					url : "./boardReplyUpdate",
					data : {
						board_idx : list[0].board_idx,
						boardReply_idx : list[0].boardReply_idx,
						boardReply_content : $("#reply_content2").val()
					},  
					dataType : "json",
					success : function (data) {
						if(data.success > 0){
							$("#replyUpdate").css("display","");
							$("#replySave").css("display","none");
							$("#reply_content1").css("display","");
							$("#reply_content2").css("display","none");
						}
					location.href="boardDetail?idx="+$("#board_idx").val();
					},
					error : function (error) {
						console.log(error); 
					}
				});
			});
			
			//댓글 삭제
			$("#replyDelete").click(function () {
				$.ajax({
					type : "post",
					url : "./boardReplyDelete",
					data : {
						board_idx : list[0].boardReply_idx,
						boardReply_idx : list[0].board_idx
					},
					dataType : "json",
					success : function (data) {
						if(data.success > 0){
							alert("삭제 성공");
						}else{
							alert("삭제 실패"); 
						}
						location.href="boardDetail?idx="+$("#board_idx").val();
					},
					error : function (error) { console.log(error); }
				});
			}); 
		}     
		  
		//댓글 작성
		$("#replyWrite").click(function () {
			if($("#boardReply_content").val()==""){
				alert("내용을 입력해주세요.");
				$("#boardReply_content").focus();
			}else{
				$.ajax({
					type : "post",
					url : "./boardReplyWrite",
					data : {
						idx : $("#board_idx").val(),
						id : $("#board_id").val(),
						boardReply_content : $("#boardReply_content").val()
					},
					dataType : "json",
					success : function (data) {
						if(data.replyCnt > 0){
							alert("댓글은 1개만 등록할 수 있습니다.");
							$("#boardReply_content").val("");
						}else{
							if(data.success > 0){
								alert("댓글이 작성 되었습니다.");
								location.href="boardDetail?idx="+$("#board_idx").val();
							}
						}
						
					},
					error : function (error) {
						console.log(error);
					}
				});
			}
		});
		
		//게시판삭제
		var idx = ${dto.board_idx};
		
		$("#delete").click(function () {
			var delConfirm = confirm("삭제 하시겠습니까?");
			if(delConfirm){
				$.ajax({
					type : "post",
					url : "./boardDelete",
					data : {
						idx : idx
					},
					dataType : "json",
					success : function (data) {
						if(data.success>0){
							console.log(data.success);
							location.href="./boardListPage";
						}else{
							alert("삭제 실패");
						}
					},
					error : function (error) {
						console.log(error);
					}
				});
			}else{
				return;
			}
			
			
		});
		
	</script>
</html>