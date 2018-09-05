<%@page import="com.kh.cat.store.service.StoreService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<c:import url="/WEB-INF/views/include/main/nav.jsp"/>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
		<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c7f29813d0150c2927c1529f7d432392&libraries=services"></script>
		
		<title>가게 등록</title>
		<style>
		#regist table{
			font-size: 15px;
			width: 700px;
		}
		#regist th, td{
			border-top: solid 2px #2637a4;
			border-bottom: solid 30px white;
			padding: 10px;
		}
		#regist th{
			background-color: #2637a4;
			font-weight: normal;
			color: white;
			width: 150px;
		}
		#regist .nof td{
			border-top: solid 2px white;
		}

		#regist input[type="text"]{
			margin: 3px 0px 3px 6px;
			font-size: 15px;
		}
		#regist input[type="button"]{
			cursor: pointer;
			vertical-align: middle;
            background-color: #33aaaaff;
            color: white;
            outline: 0px;
            border: 0px;
            padding: 5px 5px;
            font-size: 15px;
		}
		#regist input[type="file"]{
			background-color:#F2F2F2;
		}
		
		#regist{
			position: relative;
			width:100%;
			top: 50px;
			left: 25%;
		}
		.hashTag{
            border: 2px solid #33aaaaff;
            font-size: 15px;
            width: auto;          
            text-align: center; 
            float: left;
            margin-left: 20px;
            margin-bottom: 5px;
            padding-left: 10px;
        }
        .menuP{
        	 float: left;
        }
		</style>
	</head>
	<body>
	<input type="hidden" id="fileCnt" value="0">
		<div id="regist">
			<table>
				<tr>
					<th>대표사진</th>
					<td>
						<form id="registForm" action="./photoUpload" method="post" enctype="multipart/form-data" style="margin:0px">
							<input type="file" id="sPhoto" name="store_photo" accept=".jpg,.jpeg,.png,.gif,.bmp"/>
							<input type="button" onclick="storeD()" value="초기화">
						</form>
					</td>
				</tr>
				<tr class="nof">
					<td></td>
					<td>
						<div id="sPhotoShow"></div>
					</td>
				</tr>
				<tr>
					<th>상호명</th>
					<td><input type="text" name="store_name" maxlength="20" size="40" /></td>
				</tr>
				<tr>
					<th>대표자</th>
					<td><input type="text" name="store_ceo" maxlength="10" onkeyup="testChk(this)" /></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text" name="store_phone_H" maxlength="4" size="1" onkeyup="numChk(this)"/>
						-<input type="text" name="store_phone_B" maxlength="4" size="1" onkeyup="numChk(this)"/>
						-<input type="text" name="store_phone_T" maxlength="4" size="1" onkeyup="numChk(this)"/>
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						<input type="button" onclick="searchAddr()" value="주소 검색">
						<input type="text" name="store_addr" id="address" placeholder="주소" readonly="readonly" size="45"><br>
						<input type="text" name="store_addr_D" placeholder="상세 주소" maxlength="30" size="55"/>
						<br>
						<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
					</td>
				</tr>
				<tr>
					<th>음식 종류</th>
					<td><input type="text" name="store_food" placeholder="ex) 한식, 퓨전, 고기집" size="40" maxlength="20"/></td>
				</tr>
				<tr>
					<th>예상 예산(2인기준)</th>
					<td><input type="text" name="store_price" placeholder="ex) 45000"  size="5" maxlength="6" onkeyup="numChk(this)"/>원</td>
				</tr>
				<tr>
					<th>영업 시간</th>
					<td><input type="text" name="store_time" placeholder="ex) 평일, 토요일: 11:00~20:00/일요일, 공휴일:09:00~18:00" size="55" maxlength="30"/></td>
				</tr>
				<tr>
					<th>휴무일</th>
					<td><input type="text" name="store_rest" placeholder="ex) 매달 셋째주 일요일" size="55" maxlength="30"/></td>
				</tr>
				<tr>
					<th>해시 태그</th>
					<td>
						<input type="text" id="tag" name="store_tag" placeholder="ex) 줄서는맛집" maxlength="10" onkeyup="testChk(this)" />
						<input type="button" onclick="tagAdd()" value="추가">
					</td>
				</tr>
				<tr  class="nof">
					<td></td>
					<td>
						<div id="tags">
						</div>
					</td>
				</tr>
				<tr>
					<th>메뉴판 사진</th>
					<td>
						<input type="button" onclick="menuPhotoUp()" value="사진 추가">
					</td>
				</tr>
				<tr  class="nof">
					<td></td>
					<td>
						<div id="editable"></div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" onclick="storeRegist()" value="등록 요청">
					</td>
				</tr>
			</table>
		</div>
	</body>
	<script>
	var fileCnt = document.getElementById('fileCnt');

	var upload = document.getElementById('sPhoto');
	var holder = document.getElementById('sPhotoShow');
	
	var storePhoto="";
	storeD();
	
	//대표사진 변화시 func
	upload.onchange = function (e) {
		e.preventDefault();
		console.log("사진 변화");
		var file = upload.files[0],
		reader = new FileReader();
		
		reader.onload = function (event) {
			var img = new Image();
			img.src = event.target.result;

			// note: no onload required since we've got the dataurl...I think! :)
			img.width = 400;
			img.height = 270;
			
			holder.innerHTML = '';
			holder.appendChild(img);
		};
		try{
			reader.readAsDataURL(file);
		}catch (e) {
			storeD();
		}finally{
			//대표 사진 업로드
			var formData = new FormData($("#registForm")[0]);
	        $.ajax({
	            type : 'post',
	            url : 'photoUpload',
	            data : formData,
	            processData : false,
	            contentType : false,
	            success : function(data) {
	            	storePhoto = data.storePhoto;
	            },
	            error : function(error) {
	                console.log(error);
	                console.log(error.status);
	            }
	        });
		}
	return false;
	};
	
	//대표사진 디폴트
	function storeD() {
		$("#sPhoto").val("");
		holder.innerHTML = '<img alt="기본사진"'
		+'src="resources/img/store/storeD.png" width="400" height="270">';
		
		$.ajax({
			url:"./photoDel",
			type:"get",
			data:{"storePhoto":storePhoto},
			success:function(data){
				console.log(data);
				storePhoto = data.storePhoto;
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	//메뉴사진 업로드 창
	function menuPhotoUp() {
		if(fileCnt.value<10){
			var myWin = window.open("./menuPhotoForm","메뉴판 사진 추가","width=400, height=100");
		}else{
			alert("메뉴사진은 최대 10개까지 등록 가능합니다.")
		}
	}
	
	//메뉴 사진 삭제
	function menuDel(elem) {
		var fileName = elem.id.split("/")[3];
		console.log(fileName);
		$.ajax({
			url:"./menuDel",
			type:"get",
			data:{"fileName":fileName},
			success:function(data){
				console.log(data);
				if(data.success>0){
					$(elem).parent().remove();
					fileCnt.value=data.fileCnt;
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });

	//주소찾기
    function searchAddr() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수
             
                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }
                if(fullAddr.substring(0, 2)!="서울"){
            		console.log(fullAddr);
            		alert("서울 지역만 입력해주세요.");
            	}else{
	                // 주소 정보를 해당 필드에 넣는다.
	                document.getElementById("address").value = fullAddr;
	                // 주소로 상세 정보를 검색
	                geocoder.addressSearch(data.address, function(results, status) {
	                	
	                    // 정상적으로 검색이 완료됐으면
	                    if (status === daum.maps.services.Status.OK) {
	
	                        var result = results[0]; //첫번째 결과의 값을 활용
	
	                        // 해당 주소에 대한 좌표를 받아서
	                        var coords = new daum.maps.LatLng(result.y, result.x);
	                        // 지도를 보여준다.
	                        mapContainer.style.display = "block";
	                        map.relayout();
	                        // 지도 중심을 변경한다.
	                        map.setCenter(coords);
	                        // 마커를 결과값으로 받은 위치로 옮긴다.
	                        marker.setPosition(coords)
	                    }
	                });
	            }
            }
        }).open();
    }
	
    var hTag;
	var tagList = [];
	//해쉬 태그 추가
	function tagAdd() {
		hTag = $("#tag").val();
		if(hTag==""||hTag.replace(/\s/g,"") == ""){
			$("#tag").val("");
			alert("태그 내용을 입력해주세요.");
		}else{
			tagList.push("#"+hTag);
			var cnt =0;
			for (var i = 0; i < tagList.length; i++) {
		        if (tagList[i] == "#"+hTag) {
		        	cnt++;
		        }
			}
			
			if(tagList.length>8){
				tagList.pop();
				alert("태그는 최대 8개입니다.");
			}else if(cnt>=2){
				tagList.pop();
				alert("중복되는 태그가 있습니다");
			}
			else{		
				$("#tags").append("<div class='hashTag'>#"
						+hTag+" "
						+"<input type='hidden' class='tag' readonly='readonly' value='#"+hTag+"'>"
						+"<input type='button' class='tagDel' value=' - ' onclick='tagDel(this)'>"
						+"</div>");
				console.log(tagList);
			}
		}
		$("#tag").val("");
	}
	
	//해쉬태그 지우기
	function tagDel(e){
		hTag=$(e).prev().val();
		$(e).parent().remove();
		tagList.splice(tagList.indexOf(hTag),1);
	}
	
	var regNumber = /^[0-9]*$/;
	var tChk = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
	
	function numChk(e) {
		if(!regNumber.test($(e).val())){
			alert("숫자만 입력하세요");
			$(e).val("");
		}
	}
	
	function testChk(e) {
		if(tChk.test($(e).val())){
			alert("특수문자 입력 불가.");
			$(e).val("");
		}
	}

	//등록요청
    function storeRegist() {
		var store_name =  $("input[name='store_name']");
		var store_ceo =  $("input[name='store_ceo']");
		var store_phone_H =  $("input[name='store_phone_H']");
		var store_phone_B =  $("input[name='store_phone_B']");
		var store_phone_T =  $("input[name='store_phone_T']");
		var store_addr_F =  $("input[name='store_addr']");
		var store_addr_D =  $("input[name='store_addr_D']");
		var store_food =  $("input[name='store_food']");
		var store_price =  $("input[name='store_price']");
		var store_time =  $("input[name='store_time']");
		var store_rest =  $("input[name='store_rest']");
		var store_tag =  $("input[name='store_tag']");
		
		var store_phone="";
		var store_addr="";
		store_phone = $("input[name='store_phone_H']").val()+"-"
		+$("input[name='store_phone_B']").val()+"-"+$("input[name='store_phone_T']").val();
		store_addr = $("input[name='store_addr']").val()+" "+$("input[name='store_addr_D']").val()
		if(store_name.val()=="" || store_name.val().replace(/\s/g,"") == ""){
			alert("상호명을 입력하세요.");
			store_name.val("");
			store_name.focus();
		}else if(store_ceo.val()=="" || store_ceo.val().replace(/\s/g,"") == ""){
			alert("대표자를 입력하세요.");
			store_ceo.val("");
			store_ceo.focus();
		}else if(store_phone_H.val()=="" || store_phone_H.val().replace(/\s/g,"") == ""){
			alert("전화번호를 입력하세요.");
			store_phone_H.val("");
			store_phone_H.focus();
		}else if(store_phone_B.val()=="" || store_phone_B.val().replace(/\s/g,"") == ""){
			alert("전화번호를 입력하세요.");
			store_phone_B.val("");
			store_phone_B.focus();
		}else if(store_phone_T.val()=="" || store_phone_T.val().replace(/\s/g,"") == ""){
			alert("전화번호를 입력하세요.");
			store_phone_T.val("");
			store_phone_T.focus();
		}else if(store_addr_F.val()=="" || store_addr_F.val().replace(/\s/g,"") == ""){
			alert("주소를 선택하세요.");
			store_addr_F.val("");
			store_addr_F.focus();
		}else if(store_addr_D.val()=="" || store_addr_D.val().replace(/\s/g,"") == ""){
			alert("상세주소를 입력하세요.");
			store_addr_D.val("");
			store_addr_D.focus();
		}else if(store_food.val()=="" || store_food.val().replace(/\s/g,"") == ""){
			alert("음식 종류를 입력하세요.");
			store_food.val("");
			store_food.focus();
		}else if(store_price.val()=="" || store_price.val().replace(/\s/g,"") == ""){
			alert("예상 예산을 입력하세요.");
			store_price.val("");
			store_price.focus();
		}else if(store_time.val()=="" || store_time.val().replace(/\s/g,"") == ""){
			alert("영업 시간을 입력하세요.");
			store_time.val("");
			store_time.focus();
		}else if(store_rest.val()=="" || store_rest.val().replace(/\s/g,"") == ""){
			alert("휴무일을 입력하세요.");
			store_rest.val("");
			store_rest.focus();
		}else if(tagList.length==0){
			alert("해시태그를 한개 이상 입력하세요.");
			store_tag.focus();
		}else{
			console.log(tagList);
			$.ajax({
				url:"./storeRegist",
				type:"get",
				data:{
					"tagList":tagList,
					"store_name":$("input[name='store_name']").val(),
					"store_ceo":$("input[name='store_ceo']").val(),
					"store_phone":store_phone,
					"store_addr":store_addr,
					"store_food":$("input[name='store_food']").val(),
					"store_price":$("input[name='store_price']").val(),
					"store_time":$("input[name='store_time']").val(),
					"store_rest":$("input[name='store_rest']").val(),
					"store_photo":storePhoto
					},
				success:function(data){
					console.log(data);
					alert("등록에 성공했습니다.\n승인까지는 1~2일 소요됩니다.");
					location.href="./";
				},
				error:function(e){
					alert("오류 발생.");
					console.log(e);
				}
			});
		}
	}
	
    </script>
</html>