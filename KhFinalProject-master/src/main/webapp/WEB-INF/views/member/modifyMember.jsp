<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>회원정보 수정</title>
		<style>		
			#div1 {
				height : 180px;
				width : 180px;
				float : left;              
			}
			#profile {
				height : 150px;
				width : 150px;
				border : 1px solid black;
				text-align: center;       
			}
            button {
                margin-top: 5px;
                background-color:#088A85;
                color: aliceblue;
            }
            #bottom{
                text-align: center;
            }
		</style>
	</head>
	<body>
	<table>
		<h2>회원정보 수정</h2>
		<div id="div1">
			<div id="profile" style='display:table-cell;vertical-align:middle'/>
				프로필 사진
			</div>
            <div id="pic">
			 <button id="selPicture">사진선택</button>
            </div>
		</div>
        <tr>
            <th>아이디 : </th>
            <td><input type="text" id="userId" placeholder="아이디"></td>
         </tr>
         <tr>
            <th>현재비밀번호 : </th>
            <td><input type="password" id="CurrentUserPw" placeholder="현재비밀번호"></td>            
         </tr>
         <tr>
            <th>비밀번호 : </th>
            <td><input type="password" id="userPw" placeholder="비밀번호"></td>
         </tr>
         <tr>
            <th>비밀번호확인 : </th>
            <td><input type="password" id="userPwChk" placeholder="비밀번호확인"></td>            
         </tr>
         <th>이름 : </th>
            <td><input type="text" id="userId" placeholder="이름"></td>
         <tr>
            <th>이메일 : </th>
            <td><input type="email" id="userEmail" placeholder="이메일"></td>
         </tr>
         <th>핸드폰번호</th>
        <td>
            <input name="hp1" type="text" class="frm_input tel" size="3" maxlength="3" placeholder="01X"/>-
            <input name="hp2" type="text" class="frm_input tel" size="3" maxlength="4" placeholder="XXXX"/>-
            <input name="hp3" type="text" class="frm_input tel" size="3" maxlength="4" placeholder="XXXX"/>
        </td>       
	</table>
        <div id="bottom">
            <button id="confirm">확인</button>
            <button id="leave">탈퇴하기</button>
		</div>
	</body>
	<script>

	</script>
</html>