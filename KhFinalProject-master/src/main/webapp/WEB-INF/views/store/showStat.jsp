<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<!-- google charts -->
       	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

		<title>가게 통계 페이지</title>
		<style>
		#Line_Controls_Chart{
			position: relative;
			top:70px;
		}
		#statCate{
			position: absolute;
			left: 50px;
			top:70px;
			z-index: 1;
		}
		#statCate input{
			display: block;
			margin: 50px 0px;
			cursor: pointer;
			vertical-align: middle;
            background-color: #33aaaaff;
            color: white;
            outline: 0px;
            border: 0px;
            padding: 5px 5px;
            font-size: 15px;
		}
		#title{font-size: 50px; position: absolute;border-bottom: solid 2px #2637a4;left: 200px;}
		</style>
	</head>
	<body>
		<span id="title">${store_name}</span>
		<div id="Line_Controls_Chart">
		<div id=statCate>
			<input type="button" value="ALL" onclick="reDrow('all')">
			<input type="button" value="조회수" onclick="reDrow('hit')">
			<input type="button" value="리뷰수" onclick="reDrow('rev')">
			<input type="button" value="별점" onclick="reDrow('star')">
		</div>
		<!-- 라인 차트 생성할 영역 -->
			<div id="lineChartArea" style="padding:0px 20px 0px 0px;"></div>
		<!-- 컨트롤바를 생성할 영역 -->
			<div id="controlsArea" style="padding:0px 20px 0px 0px;"></div>
		</div>
	</body>
	
	<script>
	var dataCnt =  ${statList.size()};
	var mRS = 0;
	 if(dataCnt<5){
     	mRS = 172800000
     	}
     else{
     	mRS = 432000000
     	}
	
	var cate = "";
	
	if(dataCnt<2){
		alert("데이터가 충분하지 않습니다.");
		self.close();
	}
	var chartDrowFun = {
			 
		    chartDrow : function(){
		        var chartData = '';
		       
		        //날짜형식 변경하고 싶으시면 이 부분 수정하세요.
		        var chartDateformat     = 'yy/MM/dd';
		        //라인차트의 라인 수
		        var chartLineCount    = dataCnt;
		        //컨트롤러 바 차트의 라인 수
		        var controlLineCount    = dataCnt;
		 
		 
		        function drawDashboard() {
		 
		          	var data = new google.visualization.DataTable();
		         	 //그래프에 표시할 컬럼 추가
					data.addColumn('datetime' , '날짜');
					console.log(cate);
					
					 data.addColumn('number'   , '조회수');
					 data.addColumn('number'   , '리뷰수');
					 data.addColumn('number'   , '별점');
				
		 
		          //그래프에 표시할 데이터
		          var dataRow = [];
		          var min=0;
		        
		        <c:forEach var="item" items="${statList}">
			        var date =	"${item.total_date}";
			        var dateN = date. split('-');
			
			        if(cate=="all"){
			        	var hitCnt = ${item.total_bhitCnt};
			        	var revCnt = ${item.total_revCnt};
			        	var starAvg =	${item.total_starAvg};
			        	dataRow = [new Date(dateN[0],dateN[1]-1,dateN[2]), hitCnt, revCnt , starAvg];
			        }else if(cate=="hit"){
			        	var hitCnt = ${item.total_bhitCnt};
			        	dataRow = [new Date(dateN[0],dateN[1]-1,dateN[2]), hitCnt, null, null];
			        	console.log(hitCnt+" / "+min);
			        	if(hitCnt>min){
			        		min=(hitCnt+9)/10*10;
			        		console.log(min);
			        	}
			        	
			        }else if(cate=="rev"){
			        	var revCnt = ${item.total_revCnt}
			        	dataRow = [new Date(dateN[0],dateN[1]-1,dateN[2]), null, revCnt, null];
			        	if(revCnt>min){
			        		min=(revCnt+9)/10*10;
			        		console.log(min);
			        	}
			        }else if(cate=="star"){
			        	var starAvg =	${item.total_starAvg}
			        	dataRow = [new Date(dateN[0],dateN[1]-1,dateN[2]), null, null, starAvg];
			        	min=5;
			        }
		            data.addRow(dataRow);
			    </c:forEach> 
			    
		            var chart = new google.visualization.ChartWrapper({
		              chartType   : 'LineChart',
		              containerId : 'lineChartArea', //라인 차트 생성할 영역
		              options     : {
		                              isStacked   : 'percent',
		                              focusTarget : 'category',
		                              height          : 500,
		                              width              : '100%',
		                              legend          : { position: "top", textStyle: {fontSize: 13}},
		                              pointSize        : 5,
		                              tooltip          : {textStyle : {fontSize:12}, showColorCode : true,trigger: 'both'},
		                              hAxis              : {format: chartDateformat,textStyle: {fontSize:12}},
		                vAxis              : {minValue: min,viewWindow:{min:0},gridlines:{count:-1},textStyle:{fontSize:12}},
		                animation        : {startup: true,duration: 1000,easing: 'in' },
		                annotations    : {pattern: chartDateformat,
		                                textStyle: {
		                                fontSize: 15,
		                                bold: true,
		                                italic: true,
		                                color: '#871b47',
		                                auraColor: '#d799ae',
		                                opacity: 0.8,
		                                pattern: chartDateformat
		                              }
		                            }
		              }
		            });
		 
		            var control = new google.visualization.ControlWrapper({//
		              controlType: 'ChartRangeFilter',
		              containerId: 'controlsArea',  //control bar를 생성할 영역
		              options: {
		                  ui:{
		                        chartType: 'LineChart',
		                        chartOptions: {
		                        chartArea: {'width': '60%','height' : 80},
		                          hAxis: {'baselineColor': 'none', format: chartDateformat, textStyle: {fontSize:12}}
		                        },
		                        minRangeSize: mRS
		                  },
		                    filterColumnIndex: 0
		                }
		            });
		 
		            var date_formatter = new google.visualization.DateFormat({ pattern: chartDateformat});
		            date_formatter.format(data, 0);
		 
		            var dashboard = new google.visualization.Dashboard(document.getElementById('Line_Controls_Chart'));
		            window.addEventListener('resize', function() { dashboard.draw(data); }, false); //화면 크기에 따라 그래프 크기 변경
		            dashboard.bind([control], [chart]);
		            dashboard.draw(data);
		 
		        }
		          google.charts.setOnLoadCallback(drawDashboard);
		 
		      }
		    }
		 
		$(document).ready(function(){
		  google.charts.load('current', {'packages':['line','controls']});
		  cate = "all";
		  chartDrowFun.chartDrow(); //chartDrow() 실행
		 /*  programmaticSlider.setState({'lowValue': 2, 'highValue': 5}); */
		});
	
	function reDrow(da) {
		cate = da;
		chartDrowFun.chartDrow();
	}

	</script>
</html>