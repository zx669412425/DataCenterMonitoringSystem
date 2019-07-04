<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="js/json2.js"></script>
</head>
<body>

<div id="main"style="height:400px",width="400px"></div>
    <!-- ECharts单文件引入 -->
    <script src="http://echarts.baidu.com/build/dist/echarts.js"></script>  
    <script type="text/javascript">
    window.onload=function(){
    //	testResponseBody();
    	
    	}
    
    var data1=new Array();
    

    var obj=new Array();
    
    
    function testResponseBody(){
    	$.post("${pageContext.request.contextPath}/json/testRequestBody",null,
    			function(data){ 
    		  obj = eval(data);
            for(var i=0;i<24;i++){
        	 data1[i]=parseFloat(obj[i]);  
           } 
    	},"json");
    } 
    
    testResponseBody();
    
  console.log(data1);
        // 路径配置
        require.config({
            paths: {
                echarts: 'http://echarts.baidu.com/build/dist'
            }
        });
        
        // 使用
        require(
            [
                'echarts',
                'echarts/chart/line' //使用折线图就加载bar模块，按需加载
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('main')); 
 //---------------------------------------------------------------------------------------------------------
                
          option = {
					    title : {
					        text: 'CPU利用率'
					    },
					    tooltip : {
					        trigger: 'axis'
					    },
					    legend: {
					        data:['CPU利用率']
					    },
					    toolbox: {
					        show : true,
					        feature : {
					            mark : {show: true},
					            dataView : {show: true, readOnly: false},
					            magicType : {show: true, type: ['line', 'bar']},
					            restore : {show: true},
					            saveAsImage : {show: true}
					        }
					    },
					    calculable : true,
					    xAxis : [
								        {
								            type : 'category',
								            boundaryGap : true,
								            data : ['0时','1时','2时','3时','4时','5时','6时','7时','8时','9时','10时','11时','12时','13时','14时','15时','16时','17时','18时','19时','20时','21时','22时','23时',]
								        }
								    ],
					    yAxis : [
								        {
								            type : 'value',
								           // min:1.35,
								            //max:1.60,
								            axisLabel : {
								                formatter: '{value} %'
								            }
								        }
								    ],
					    series : [
								        {
								            name:'平均利用率',
								            type:'line',
								            data:[],
								            markPoint : {
								                data : [
								                    {type : 'max', name: '最大值'},
								                    {type : 'min', name: '最小值'}
								                ]
								            },
								            data:data1
								        },
								        
								    ]
					}; //option
                    
        
//-----------------------------------------------------------------------------------------------------------           
                 // 为echarts对象加载数据 
                myChart.setOption(option);
                

                
                
              
     }  //ec
            
        );  //require
     </script>       
</body>
</html>