<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8"/>
    <title>负载界面</title>
	<!--定义表格样式-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- Bootstrap Styles-->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FontAwesome Styles-->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- Morris Chart Styles-->
    <link href="assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" /> 
    <link href="assets/css/new.css" rel="stylesheet" /> 
    <!-- Custom Styles-->
    <link href="assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <script src="assets/js/jquery-3.3.1.min.js"></script>
</head>


<body>
<!-- ECharts单文件引入 -->
    <script src="http://echarts.baidu.com/build/dist/echarts.js"></script>  
    <script type="text/javascript"> 
    //获取ur的参数的函数---------------------------------------------------------------------   
    function GetRequest() {  
        var url = location.search; //获取url中"?"符后的字串  
        var theRequest = new Object();  
          if (url.indexOf("?") != -1) {  
          var str = url.substr(1);   
           strs = str.split("&");  
           for (var i = 0; i < strs.length; i++) {  
           theRequest[strs[i].split("=")[0]] = decodeURI(strs[i].split("=")[1]);//获取中文参数转码<span style="font-family: Arial, Helvetica, sans-serif;">decodeURI</span>，（unescape只针对数字，中文乱码)  
                }  
              }  
          return theRequest;  
              }   
    var request = new Object();  
    request = GetRequest();  
    var a = request['hostId'] ; 
    //获取ur的参数的函数---------------------------------------------------------------------
    var vmName1=new Array();
    var vmName2=new Array();
    var vmName3=new Array();
    var vmAverageCpu1=new Array();
    var vmAverageCpu2=new Array();
    var vmAverageCpu3=new Array();
    var hostHighName=new Array();
    var hostLowName=new Array();
    var vmHighName=new Array();
    var vmLowName=new Array();
    var vmHighLoad=new Array();
    var vmLowLoad=new Array();
    var vmHighLoadId=new Array();
    var vmLowLoadId=new Array();
    var vmHighStatus=new Array();
    var vmLowStatus=new Array();
    function getHostVmName1(){
    	$.ajax({
    		  type: 'get',
    		  url: "${pageContext.request.contextPath}/json/vmName",
    		  data: "id="+"1",
    		  async : false,
    		  success: function(data){
 //   			  console.log('id 1 '+data);
    			  vmName1=data;
    		  },
    		  dataType: "json"
    		});
    	return vmName1;
    } 
    function getHostVmName2(){
    	$.ajax({
  		  type: 'get',
  		  url: "${pageContext.request.contextPath}/json/vmName",
  		  data: "id="+"2",
  		  async : false,
  		  success: function(data){
//  			  console.log('id 2 '+data);
  			vmName2=data;
  		  },
  		  dataType: "json"
  		});
    	return vmName2;
    } 
    function getHostVmName3(){
    	$.ajax({
  		  type: 'get',
  		  url: "${pageContext.request.contextPath}/json/vmName",
  		  data: "id="+"3",
  		  async : false,
  		  success: function(data){
 // 			  console.log('id 3 '+data);
  			vmName3=data;
  		  },
  		  dataType: "json"
  		});
    	return vmName3;
    } 
    function getAllVmAverageCpu1(){
    	$.ajax({
  		  type: 'get',
  		  url: "${pageContext.request.contextPath}/json/getAllVmAverageCpu",
  		  data: "id="+"1",
  		  async : false,
  		  success: function(data){
//  			  console.log('id 1 '+data);
  			vmAverageCpu1=data;
  		  },
  		  dataType: "json"
  		  
  		});
    	return vmAverageCpu1;
    } 
    function getAllVmAverageCpu2(){
    	$.ajax({
    		  type: 'get',
    		  url: "${pageContext.request.contextPath}/json/getAllVmAverageCpu",
    		  data: "id="+"2",
    		  async : false,
    		  success: function(data){
//    			  console.log('id 2 '+data);
    			  vmAverageCpu2=data;
    			  
    		  },
    		  dataType: "json"
    		});
    	return vmAverageCpu2;
    }
    function getAllVmAverageCpu3(){
    	$.ajax({
    		  type: 'get',
    		  url: "${pageContext.request.contextPath}/json/getAllVmAverageCpu",
    		  data: "id="+"3",
    		  async : false,
    		  success: function(data){
//    			  console.log('id 3 '+data);
    			  vmAverageCpu3=data;
    			  
    		  },
    		  dataType: "json"
    		});
    	return vmAverageCpu3;
    } 
    function getHostHighName(){
    	$.ajax({
    		  type: 'get',
    		  url: "${pageContext.request.contextPath}/json/getVmHighCpuLoad",
 //   		  data: "id="+"1",
    		  async : false,
    		  success: function(data){
    			  console.log("data-----"+data);
    			  for (i=0;i<data.length;i++)
    			  {
    				  hostHighName[i]=data[i].hname;
    				  vmHighName[i]=data[i].vmname;
    				  vmHighLoad[i]=data[i].vmload/2016;
    				  vmHighLoad[i]=vmHighLoad[i].toFixed(4);
    				  vmHighLoadId[i]=data[i].vmId;
                      if(vmHighLoad[i]>0.5)vmHighStatus[i] = "长期高负载";else vmHighStatus[i] = "短期高负载";
                      vmHighLoad[i]=vmHighLoad[i]*100+"%"
    			  }
                  for(i=0;i<=5-data.length;i++)
                  {
                      hostHighName[5-i] = '-';
                      vmHighName[5-i] = '-';
                      vmHighLoad[5-i] = '-';
                      vmHighLoadId[5-i] = '-';
                      vmHighStatus[5-i]= '-';
                  }
    			 	console.log(hostHighName[0]+'fff'+vmHighName[0]);
    			  
    		  },
    		  dataType: "json"
    		});
    	return hostHighName;
    }
    function getHostLowName(){
    	$.ajax({
    		  type: 'get',
    		  url: "${pageContext.request.contextPath}/json/getVmLowCpuLoad",
//    		  data: "id="+"2",
    		  async : false,
    		  success: function(data){
//    			  console.log('id 2 '+data);
    			for (i=0;i<data.length;i++)
    			  {
    				  hostLowName[i]=data[i].hname;
    				  vmLowName[i]=data[i].vmname;
    				  vmLowLoad[i]=data[i].vmload/2016;
    				  vmLowLoad[i]=vmLowLoad[i].toFixed(2);
    				  vmLowLoadId[i]=data[i].vmId;
                      if(vmLowLoad[i]>0.5)vmLowStatus[i] = "长期低负载";else vmLowStatus[i] = "短期低负载";
                      vmLowLoad[i]=vmLowLoad[i]*100+"%";
    			  }
    			  for(i=0;i<=5-data.length;i++)
                  {
                      hostLowName[5-i] = '-';
                      vmLowName[5-i] = '-';
                      vmLowLoad[5-i] = '-';
                      vmLowLoadId[5-i] = '-';
                      vmLowStatus[5-i] = '-';
                  }
    		  },
    		  dataType: "json"
    		});
    	return hostLowName;
    }
    getHostHighName();
    getHostLowName();
 //   console.log("hostHighName"+hostHighName);
 //   console.log("vmHighName"+vmHighName);
 //   console.log("vmHighLoad"+vmHighLoad);    
    for( i=0;i<7;i++){
    //alert(vmAverageCpu1);
    }
  //var myChart;
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
                'echarts/chart/bar' //使用折线图就加载bar模块，按需加载
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('main'));
 //---------------------------------------------------------------------------------------------------------              
 option = {

		             title : {
 	                     text: '负载监控图',
 	                     subtext: '一天内的负载情况'
 	                         },
                    tooltip : {
                         trigger: 'axis'
                              },
                    legend: {
                        data:['一天的负载']
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
                 	        	min:0,
                                max:1,
                 	            type : 'value',
                 	           // boundaryGap : [0,0.01]
                 	        }
                 	    ],
                 	    yAxis : [
                 	        {
                 	            type : 'category',
                 	            data : vmName1=getHostVmName1()
                 	        }
                 	    ],
                 	   series : [
                     	        {
                     	            name:'一天的负载',
                     	            type:'bar',
                     	            
                     	            data:vmAverageCpu1=getAllVmAverageCpu1()
                     	            	//[13203, 25989, 275854, 125630]
                     	        },
                     	    ]
                };

            option1 = {
            	    title : {
            	        text: '负载监控图',
            	        subtext: '一天内的负载情况'
            	    },
            	    tooltip : {
            	        trigger: 'axis'
            	    },
            	    legend: {
            	        data:['一天的负载']
            	    },
            	    toolbox: {
            	        show : true,
            	        feature : {
            	            mark : {show: true},
            	            dataView : {show: true, readOnly: false},
            	            magicType: {show: true, type: ['line', 'bar']},
            	            restore : {show: true},
            	            saveAsImage : {show: true}
            	        }
            	    },
            	    calculable : true,
            	    xAxis : [
            	        {
            	        	min:0,
                            max:1,
            	            type : 'value',
            	           // boundaryGap : [0, 0.01]
            	        }
            	    ],
            	    yAxis : [
            	        {
            	            type : 'category',
            	            data : vmName2=getHostVmName2()
            	        }
            	    ],
            	    series : [
            	        {
            	            name:'一天的负载',
            	            type:'bar',
            	            data:vmAverageCpu2=getAllVmAverageCpu2()
            	            	//[13203, 25989, 275854, 125630]
            	        },
            	    ]
            	};
///
            option2 = {
            	    title : {
            	        text: '负载监控图',
            	        subtext: '一天内的负载情况'
            	    },
            	    tooltip : {
            	        trigger: 'axis'
            	    },
            	    legend: {
            	        data:['负载']
            	    },
            	    toolbox: {
            	        show : true,
            	        feature : {
            	            mark : {show: true},
            	            dataView : {show: true, readOnly: false},
            	            magicType: {show: true, type: ['line', 'bar']},
            	            restore : {show: true},
            	            saveAsImage : {show: true}
            	        }
            	    },
            	    calculable : true,
            	    xAxis : [
            	        {
            	        	min:0,
                            max:1,
            	            type : 'value',
            	           // boundaryGap : [0, 0.01]
            	        }
            	    ],
            	    yAxis : [
            	        {
            	            type : 'category',
            	            data : vmName3=getHostVmName3()
            	        }
            	    ],
            	    series : [
            	        {
            	            name:'一天的负载',
            	            type:'bar',
            	            data:vmAverageCpu3=getAllVmAverageCpu3()
            	            	//[13203, 25989, 275854, 125630]
            	        },
            	    ]
            	};  


//-----------------------------------------------------------------------------------------------------------           
                 // 为echarts对象加载数据 
              //    myChart = ec.init(document.getElementById('main'));
              //myChart.setOption(option2);
         	myChart.setOption(option,true);        	
              //setInterval(myChart.setOption(option), 30000);  
      //使用window.location函数来设置页面自动加载，1为下拉框添加监听事件，并为每一个option添加反应。2设置页面自动生成表格。
        window.onload=function(){
//         	 option.yAxis[0].data=vmName1;
//         	 option.series[0].data=vmAverageCpu1;        	 
//         	myChart.setOption(option,true);
            document.getElementById('select').addEventListener('change',function(){
                myChart = ec.init(document.getElementById('main'));                
                var netUsage="netUsage";
                var cpuUsage="cpuUsage";
                var memoryUsage="memoryUsage";
                if(this.value==netUsage){
                	myChart.clear();
                	 //var options = myChart.getoption();
                	 //option.yAxis[0].data=vmName1;
                	 //option.series[0].data=vmAverageCpu1;               	 
                	myChart.setOption(option,true);
                 } 
                 if(this.value==cpuUsage){
                	 myChart.clear();
                	 //option.yAxis[0].data=vmName2;
                	 //option.series[0].data=vmAverageCpu2;                	 
                	myChart.setOption(option1,true);	
                 } 
                 if(this.value==memoryUsage){
                	 myChart.clear();
                	 //option.yAxis[0].data=vmName2;
                	 //option.series[0].data=vmAverageCpu2;                	 
                	myChart.setOption(option2,true);	
                 } 
                 
                  },true);
         }//对应window.location函数
      //下两行分别对应function（ec）结尾的花括号和require结尾的小括号
		  }
        );

    function display(event){
        event.preventDefault();
        var host1 = document.getElementById("host1");
        var host2 = document.getElementById("host2");
        if(host1.style.display=="none"){
            host1.style.display = "block";
            host2.style.display = "block";
        }else{
            host1.style.display = "none";
            host2.style.display = "none"
        }

    }
     </script>         
<div id="wrapper">
        <nav class="navbar navbar-default top-navbar" role="navigation">
            <div class="navbar-header">
<!--                 <a class="navbar-brand" href="">数据中心监控系统</a> -->
            </div>  
        </nav>
        <!--/. NAV TOP  -->
        <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">
                     <li>
					    <a href="index.jsp"><i class="fa fa-sitemap"></i> 主界面</a>
					 </li>
                    <li>
                        <a href="" onclick="display(event)"><i class="fa fa-sitemap"></i> 物理机</a>
                        <a href="PhysicalMachine.jsp?hostId=1"  id="host1" style="display:none;margin-left:50px;"><i class="fa fa-sitemap" ></i> 服务器1</a>
                        <a href="PhysicalMachine.jsp?hostId=2"  id="host2" style="display:none;margin-left:50px;"><i class="fa fa-sitemap" ></i> 服务器2</a>
                        
                        <a href="VirtualMachine.jsp?vmId=1"><i class="fa fa-sitemap"></i> 虚拟机</a>
                        <a href="#"><i class="fa fa-sitemap"></i> 负载详情</a>
                        <a href="heatmap.jsp"><i class="fa fa-sitemap"></i> 负载热力图</a>
                        <a href="globalpowerbyhost.jsp"><i class="fa fa-sitemap"></i> 负载损耗分布</a>
                    </li>	
                </ul>

            </div>

        </nav>
        <!-- /. NAV SIDE  -->
        <div id="page-wrapper">
            <div id="page-inner">
            
                <div class="row">
                    <div class="col-md-3 col-sm-12 col-xs-12">
                        <div class="panel panel-primary text-center no-boder bg-color-green">
                           
                         </div>
                    </div>
                    <div class="col-md-3 col-sm-12 col-xs-12">
                        <div class="panel panel-primary text-center no-boder bg-color-green">
                            
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-12 col-xs-12">
                        <div class="panel panel-primary text-center no-boder bg-color-green">
                         
                        </div>
                    </div>
                   
                </div>


                <div class="row">


                    <div class="col-md-9 col-sm-12 col-xs-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                请选择数据
							<select id="select" >
                            <option id="netUsage" value ="netUsage">物理机1</option>
                            <option id="cpuUsage" value ="cpuUsage">物理机2</option>
                            <option id="memoryUsage" value ="memoryUsage">物理机3</option>
                            </select>
							
                            </div>
                            <div class="panel-body">
                            <!-- 在此处添加图表 -->
                            <!-- <div id="morris-bar-chart"></div> -->
                             <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main"style="height:400px",width="400px"></div>
    
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-12 col-xs-12">

                    </div>

                </div>
                <!-- /. ROW  -->
							    <div class="panel panel-default">
                                    <div class="panel-heading"> 查看近七天负载请点击虚拟机名字</div>
		           <table width="100%" border="2" cellspacing="1" cellpadding="4" bgcolor="#cccccc" class="tabtop13" align="center">

                       <tr>
                            <th class="btbg font-center titfont" background-color="#ff0000"  colspan="5">物理机上高负载虚拟机列表</th>
                      </tr>
                                <tr>
                       <td class="btbg font-center titfont"> 物理机名字 </td>		
                       <td class="btbg font-center titfont"> 虚拟机名字 </td>
                       <td class="btbg font-center titfont"> 高负载占比 </td>
                       <td class="btbg font-center titfont"> 状态 </td>
                                </tr>
                                <tr>
                       <td class="btbg font-center titfont"><script> document.write(hostHighName[0]);</script> </td>
                       <td class="btbg font-center titfont">
                       <a id="aaa0"><script> document.write(vmHighName[0]);</script></a>
                       <script type="text/javascript">
                       document.getElementById("aaa0").href='load7.jsp?vmId='+vmHighLoadId[0];
                       </script></td>
                       <td class="btbg font-center titfont"><script> document.write(vmHighLoad[0]);</script> </td>
                                    <td class="btbg font-center titfont"><script>document.write(vmHighStatus[0]);</script></td>
                                </tr>
                                <tr>
                       <td class="btbg font-center titfont"><script> document.write(hostHighName[1]);</script> </td>
                       <td class="btbg font-center titfont">
                       <a id="aaa1"><script> document.write(vmHighName[1]);</script></a>
                       <script type="text/javascript">
                       document.getElementById("aaa1").href='load7.jsp?vmId='+vmHighLoadId[1];
                       </script></td>	
                       <td class="btbg font-center titfont"><script> document.write(vmHighLoad[1]);</script> </td>
                       <td class="btbg font-center titfont"><script>document.write(vmHighStatus[1]);</script></td>
                               </tr>
                               <tr>
                       <td class="btbg font-center titfont"><script> document.write(hostHighName[2]);</script> </td>
                       <td class="btbg font-center titfont">
                       <a id="aaa2"><script> document.write(vmHighName[2]);</script></a>
                       <script type="text/javascript">
                       document.getElementById("aaa2").href='load7.jsp?vmId='+vmHighLoadId[2];
                       </script></td>
                       <td class="btbg font-center titfont"><script> document.write(vmHighLoad[2]);</script> </td>
                                   <td class="btbg font-center titfont"><script>document.write(vmHighStatus[2]);</script></td>
                               </tr>
                               <tr>
                       <td class="btbg font-center titfont"><script> document.write(hostHighName[3]);</script> </td>
                       <td class="btbg font-center titfont">
                       <a id="aaa3"><script> document.write(vmHighName[3]);</script></a>
                       <script type="text/javascript">
                       document.getElementById("aaa3").href='load7.jsp?vmId='+vmHighLoadId[3];
                       </script></td>
                       <td class="btbg font-center titfont"><script> document.write(vmHighLoad[3]);</script> </td>
                                   <td class="btbg font-center titfont"><script>document.write(vmHighStatus[3]);</script></td>
                               </tr>
                               <tr>
                       <td class="btbg font-center titfont"><script> document.write(hostHighName[4]);</script> </td>
                       <td class="btbg font-center titfont">
                       <a id="aaa4"><script> document.write(vmHighName[4]);</script></a>
                       <script type="text/javascript">
                       document.getElementById("aaa4").href='load7.jsp?vmId='+vmHighLoadId[4];
                       </script></td>
                       <td class="btbg font-center titfont"><script> document.write(vmHighLoad[4]);</script> </td>
                                   <td class="btbg font-center titfont"><script>document.write(vmHighStatus[4]);</script></td>
                               </tr>
               </table>
             </div>
							    <div class="panel panel-default">
                                    <div class="panel-heading"> 查看近七天负载请点击虚拟机名字</div>
		           <table width="100%" border="2" cellspacing="1" cellpadding="4" bgcolor="#cccccc" class="tabtop13" align="center">

                       <tr>
                            <th class="btbg font-center titfont" background-color="#ff0000"  colspan="5">物理机上低负载虚拟机列表</th>
                      </tr>
                                <tr>
                       <td class="btbg font-center titfont"> 物理机名字 </td>	
                       <td class="btbg font-center titfont"> 虚拟机名字 </td>
                       <td class="btbg font-center titfont"> 低负载占比 </td>
                       <td class="btbg font-center titfont"> 状态 </td>
                               </tr>
                                <tr>
                       <td class="btbg font-center titfont"><script> document.write(hostLowName[0]);</script> </td>
                       <td class="btbg font-center titfont">
                       <a id="bbb0"><script> document.write(vmLowName[0]);</script></a>
                       <script type="text/javascript">
                       document.getElementById("bbb0").href='loadLow7.jsp?vmId='+vmLowLoadId[0];
                       </script></td>
                       <td class="btbg font-center titfont"><script> document.write(vmLowLoad[0]);</script> </td>
                                    <td class="btbg font-center titfont"><script>document.write(vmLowStatus[0]);</script></td>
                                </tr>
                                <tr>
                       <td class="btbg font-center titfont"><script> document.write(hostLowName[1]);</script> </td>
                       <td class="btbg font-center titfont">
                       <a id="bbb1"><script> document.write(vmLowName[1]);</script></a>
                       <script type="text/javascript">
                       document.getElementById("bbb1").href='loadLow7.jsp?vmId='+vmLowLoadId[1];
                       </script></td>	
                       <td class="btbg font-center titfont"><script> document.write(vmLowLoad[1]);</script> </td>
                                    <td class="btbg font-center titfont"><script>document.write(vmLowStatus[1]);</script></td>
                               </tr>
                               <tr>
                       <td class="btbg font-center titfont"><script> document.write(hostLowName[2]);</script> </td>
                       <td class="btbg font-center titfont">
                       <a id="bbb2"><script> document.write(vmLowName[2]);</script></a>
                       <script type="text/javascript">
                       document.getElementById("bbb2").href='loadLow7.jsp?vmId='+vmLowLoadId[2];
                       </script></td>
                       <td class="btbg font-center titfont"><script> document.write(vmLowLoad[2]);</script> </td>
                                   <td class="btbg font-center titfont"><script>document.write(vmLowStatus[2]);</script></td>
                               </tr>
                               <tr>
                       <td class="btbg font-center titfont"><script> document.write(hostLowName[3]);</script> </td>
                       <td class="btbg font-center titfont">
                       <a id="bbb3"><script> document.write(vmLowName[3]);</script></a>
                       <script type="text/javascript">
                       document.getElementById("bbb3").href='loadLow7.jsp?vmId='+vmLowLoadId[3];
                       </script></td>
                       <td class="btbg font-center titfont"><script> document.write(vmLowLoad[3]);</script> </td>
                                   <td class="btbg font-center titfont"><script>document.write(vmLowStatus[3]);</script></td>
                               </tr>
                               <tr>
                       <td class="btbg font-center titfont"><script> document.write(hostLowName[4]);</script> </td>
                       <td class="btbg font-center titfont">
                       <a id="bbb4"><script> document.write(vmLowName[4]);</script></a>
                       <script type="text/javascript">
                       document.getElementById("bbb4").href='loadLow7.jsp?vmId='+vmLowLoadId[4];
                       </script></td>
                       <td class="btbg font-center titfont"><script> document.write(vmLowLoad[4]);</script> </td>
                                   <td class="btbg font-center titfont"><script>document.write(vmLowStatus[4]);</script></td>
                        </tr>

               </table>
             </div>						 
            </div>
            <!-- /. PAGE INNER  --> 
        </div>
        <!-- /. PAGE WRAPPER  -->
    </div>
    <!-- /. WRAPPER  -->
    <!-- JS Scripts-->
    <!-- jQuery Js -->

    <script src="assets/js/jquery-1.10.2.js"></script>
    <!-- Bootstrap Js -->
    <script src="assets/js/bootstrap.min.js"></script>
    <!-- Metis Menu Js -->
    <script src="assets/js/jquery.metisMenu.js" ></script>
    <!-- Morris Chart Js -->
<!--      <script src="assets/js/morris/raphael-2.1.0.min.js"></script>  -->
<!--      <script src="assets/js/morris/morris.js"></script>  -->
    <!-- Custom Js -->
<!--      <script src="assets/js/custom-scripts.js"></script>  -->
    
</body>
</html>