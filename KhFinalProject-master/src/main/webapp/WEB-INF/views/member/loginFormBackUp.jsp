<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>로그인 폼</title>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<style>
    div{
        border: solid 2px navy;
        width: 380px;
        padding: 5%;
        margin-top: 7%;
        position: absolute;
    
        margin: -150px 0 0 -75px;
        top: 50%;
        left: 40%;      
    }
    table,th,td{
		border-collapse: collapse;
        padding: 5px;     
	}
    #loginBtn{
        /* background-color: #088A85; */
        /* color: aliceblue; */
        background-color: #33aaaaff;
        color: white;
        padding-top: 21px;
        padding-bottom: 21px;
        padding-left: 10px;
        padding-right: 10px;
    }
    input[type=button] { 
        border:solid 1px blue;
    }    
	</style>
</head>
<body>
	
<form id="login" action="login" method="post">
<div>
    <table>
   	     <tr>
            <td>아 이 디 &nbsp : </td>
            <td><input type="text" tabindex="1" name="id" id="userId" placeholder="아이디"></td>
            <td rowspan="2"> <input id="loginBtn" type="button" value="로그인"></td>
         </tr>
         <tr>
            <td>비밀번호&nbsp&nbsp: </td>
            <td><input type="password" tabindex="2" name="pw" id="userPw" placeholder="비밀번호"></td>            
         </tr>
         <tr>
           <td colspan="3">
           &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <input onclick ="join()" type="button" value="회원가입">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
           <input type="button" onclick ="popupOpen()" value="ID 찾기">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
            <input type="button" onclick="pwFind()" value="PW 찾기">
           </td>
         </tr>
   </table>
</div>
</form>
</body>
<script>

	var idReg = /^[A-za-z0-9]{5,20}/g;

	printMsg();
	function printMsg(){
		var msg="${msg}";
		if(msg!=""){
			alert(msg);
		}	
	}	

	$("#userId").keyup(function(e){
		if(e.keyCode == 13)  
			$("#login").submit(); 
		}
	);
	
	$("#userPw").keyup(function(e){
		if(e.keyCode == 13)  
			$("#login").submit(); 
		}
	);
	

	function join() {
		location.href="./joinForm";
	};
	
	function pwFind() {
		var myWin= window.open("./pwFindWin", "PW 찾기","width=500,height=500");	
	}
	
	function popupOpen(){

		var popUrl = "./findIdForm";	//팝업창에 출력될 페이지 URL

		var popOption = "top=0, left=0, width=500, height=500, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
			window.open(popUrl,"",popOption);
		}


	$("#loginBtn").click(function(){
		
		if($("input[name='id']").val()==""){//아이디
	        alert("아이디를 입력해주세요!!");
	        $("input[name='id']").focus();
	        return false;
	   }else if($("input[name='pw']").val()==""){//비밀번호
		   	alert("비밀번호를 입력해주세요!!");
		   	$("input[name='pw']").focus();
		   	return false;   
	   }else if($("input[name='pw']").val().length<8 || $("input[name='pw']").val().length>16){	//비밀번호 유효성
	   		alert("비밀번호는 8~16자를 입력해주세요.");
	   		return false;
	   }else{
	   		$("#login").submit();//submit
	   }
	});		





</script>
</html>