<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		
		<title>별점</title>
<style>
.star-input>.input,
.star-input>.input>label:hover,
.star-input>.input>input:focus+label,
.star-input>.input>input:checked+label{
    display: inline-block;
    vertical-align:middle;
    background:url('resources/img/star/grade_img.png')no-repeat;
}
.star-input{
    display:inline-block; 
    white-space:nowrap;
    width:225px;height:40px;
    padding:8px;line-height:30px;
}
.star-input>.input{
    display:inline-block;
    width:150px;height:28px;
    background-size:150px;
    white-space:nowrap;
    overflow:hidden;
    position: relative;
}
.star-input>.input>input{
    position:absolute;
    width:1px;height:1px;
    opacity:0;
}
star-input>.input.focus{
    outline:1px dotted #ddd;
}
.star-input>.input>label{
    width:30px;height:0;
    padding:28px 0 0 0;
    overflow: hidden;
    float:left;
    cursor: pointer;
    position: absolute;
    top: 0;left: 0;
}
.star-input>.input>label:hover,
.star-input>.input>input:focus+label,
.star-input>.input>input:checked+label{
    background-size: 150px;
    background-position: 0 bottom;
}
.star-input>.input>label:hover~label{
    background-image: none;
}
.star-input>.input>label[for="p0.5"]{width:15px;z-index:10;}
.star-input>.input>label[for="p1.0"]{width:30px;z-index:9;}
.star-input>.input>label[for="p1.5"]{width:45px;z-index:8;}
.star-input>.input>label[for="p2.0"]{width:60px;z-index:7;}
.star-input>.input>label[for="p2.5"]{width:75px;z-index:6;}
.star-input>.input>label[for="p3.0"]{width:90px;z-index:5;}
.star-input>.input>label[for="p3.5"]{width:105px;z-index:4;}
.star-input>.input>label[for="p4.0"]{width:120px;z-index:3;}
.star-input>.input>label[for="p4.5"]{width:135px;z-index:2;}
.star-input>.input>label[for="p5.0"]{width:150px;z-index:1;}
.star-input>output{
    display:inline-block;
    width:60px; font-size:18px;
    text-align:right; 
    vertical-align:middle;
}
</style>
	</head>
	<body>
	
<span id="star-input" class="star-input">
	<span class="input">		
    	<input type="radio" name="star-input" value="0.5" id="p0.5"><label for="p0.5">0.5</label>
    	<input type="radio" name="star-input" value="1" id="p1.0"><label for="p1.0">1.0</label>
        <input type="radio" name="star-input" value="1.5" id="p1.5"><label for="p1.5">1.5</label>
        <input type="radio" name="star-input" value="2" id="p2.0"><label for="p2.0">2.0</label>
        <input type="radio" name="star-input" value="2.5" id="p2.5"><label for="p2.5">2.5</label>
        <input type="radio" name="star-input" value="3" id="p3.0"><label for="p3.0">3.0</label>
        <input type="radio" name="star-input" value="3.5" id="p3.5"><label for="p3.5">3.5</label>
        <input type="radio" name="star-input" value="4" id="p4.0"><label for="p4.0">4.0</label>
        <input type="radio" name="star-input" value="4.5" id="p4.5"><label for="p4.5">4.5</label>
        <input type="radio" name="star-input" value="5" id="p5.0"><label for="p5.0">5.0</label>
  	</span>
  	<output for="star-input"><b name="review_star" id="starScore">0</b></output>						
</span>
<!-- <script src="resources/js/jquery-1.11.3.min.js"></script> -->
<script src="resources/js/star.js"></script>
</body>
<script>
//star();
//starChk(5);
function starChk(elem){
	$("input:radio[value='"+elem+"']").attr('checked', true);
	$("#starScore").text(elem);
}
</script>
</html>