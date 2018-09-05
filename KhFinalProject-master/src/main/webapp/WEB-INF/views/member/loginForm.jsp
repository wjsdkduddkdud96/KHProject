<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- <!DOCTYPE html> -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
  <head>
  <c:import url="/WEB-INF/views/include/main/nav.jsp"/>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <title>로그인 폼</title>

  </head>
  <style>
  	@import url("http://fonts.googleapis.com/earlyaccess/nanumgothic.css");
	
	html {
		height: 100%;
	}
	
	body {
	    width:100%;
	    height:100%;
	    margin: 0;
  		padding-top: 80px;
  		padding-bottom: 40px;
  		font-family: "Nanum Gothic", arial, helvetica, sans-serif;
  		background-repeat: no-repeat;
  		/* background:linear-gradient(to bottom right, #0098FF, #6BA8D1); */
	}
	
    .card {
        margin: 0 auto; /* Added */
        float: none; /* Added */
        margin-bottom: 10px; /* Added */
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}
	
	.form-signin .form-control {
  		position: relative;
  		height: auto;
  		-webkit-box-sizing: border-box;
     	-moz-box-sizing: border-box;
        	 box-sizing: border-box;
  		padding: 10px;
  		font-size: 16px;
	}
	#mainFrame{
		top:-80px;
	}
	#menuFrame{
		top:-80px;
	}
	#menuFrame ul{
	position:relative;
		top:15px;
	}
	#search_content{
		height:15px;
	}
	#nav select{
		height:43px;
	}
  </style>

  <body cellpadding="0" cellspacing="0" marginleft="0" margintop="0" width="100%" height="100%" align="center">

	<div class="card align-middle" style="width:20rem; border-radius:20px;">
		<div class="card-title" style="margin-top:30px;">
			<h2 class="card-title text-center" style="color:#113366;">CAT :: 맛집 SNS</h2>
		</div>
		<div class="card-body">
      <form class="form-signin" method="POST" id="login" action="login"> <!-- onSubmit="logincall();return false" -->
        <h5 class="form-signin-heading">로그인 정보를 입력하세요</h5>
        <label for="inputEmail" class="sr-only">Your ID</label>
        <input type="text" tabindex="1" name="id" id="userId" class="form-control" placeholder="Your ID"><BR>  <!-- required autofocus -->
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" tabindex="2" name="pw" id="userPw" class="form-control" placeholder="Password"><br> <!-- required -->
        <div class="checkbox">
          <label>
            <!-- <input type="checkbox" value="remember-me"> 기억하기 -->
            <!-- <input onclick ="join()" type="button" value="회원가입">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
        	<input type="button" onclick ="popupOpen()" value="ID 찾기">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
        	<input type="button" onclick="pwFind()" value="PW 찾기"> -->
        	<a href="./joinForm"> 회원가입 </a> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
    		<a href="#" onclick="javascript:popupOpen();"> ID 찾기 </a> &nbsp&nbsp&nbsp&nbsp
    		<a href="#" onclick="javascript:pwFind();"> PW 찾기 </a>
          </label>
        </div>
        <!-- <button id="btn-Yes" tabindex="3" class="btn btn-lg btn-primary btn-block" type="submit">로 그 인</button> -->
        <input tabindex="3" class="btn btn-lg btn-primary btn-block" id="loginBtn" type="button" value="로그인">
      </form>
      
		</div>
	</div>

	<div class="modal">
	</div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script> 
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
		var myWin= window.open("./pwFindWin", "PW 찾기","width=500,height=550");	
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