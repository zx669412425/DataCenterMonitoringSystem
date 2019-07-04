<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8"/>
    <title>七天负载</title>
	<!--定义表格样式-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- Bootstrap Styles-->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FontAwesome Styles-->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- Morris Chart Styles-->
    <link href="assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" /> 
    <!-- Custom Styles-->
    <link href="assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <script src="assets/js/jquery-3.3.1.min.js"></script>
</head>
<body>
 <script type="text/javascript">
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
 var a = request['vmId'] ; 
 document.write(a);
 //获取ur的参数的函数-----------
 var vmLoad7 = new Array();
 var date = new Array();
 var vmName;
     function getVmLoad7(){
    	$.ajax({
    		  type: 'get',
    		  url: "${pageContext.request.contextPath}/json/vmLowLoad7",
    		  data: "id="+a,
    		  async : false,
    		  success: function(data){   			  
    			  for (i=0;i<data.length;i++)
    			  {
    				  vmName=data[i].vmName;
    				  vmLoad7[i]=data[i].vmLoad;
    				  date[i]=data[i].date;
    			  }
    		  },
    		  dataType: "json"
    		});
    	return vmLoad7;
    }
     getVmLoad7();
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
					    <a href="main.jsp"><i class="fa fa-sitemap"></i> 主界面</a>
					 </li>
                    <li>
                        <a href="PhysicalMachine.jsp?hostId=1"><i class="fa fa-sitemap"></i> 物理机</a>
                        
                        <a href="VirtualMachine.jsp?vmId=1"><i class="fa fa-sitemap"></i> 虚拟机</a>
                        <a href="Load.jsp?"><i class="fa fa-sitemap"></i> 负载</a>
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
<!--                             <div class="panel-heading">
                                请选择数据
							<select id="select" >
                            <option id="netUsage" value ="netUsage">物理机1</option>
                            <option id="cpuUsage" value ="cpuUsage">物理机2</option>
                            </select>
							
                            </div> -->
                            <div class="panel-body">
                            <!-- 在此处添加图表 -->
                            <!-- <div id="morris-bar-chart"></div> -->
                             <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main"style="height:500px",width="1000px"></div>
    
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-12 col-xs-12">
                        <div class="panel panel-default">
                            
							
							  </div>
                    </div>

                </div>
                <!-- /. ROW  -->
            </div>
            <!-- /. PAGE INNER  -->
        </div>
        <!-- /. PAGE WRAPPER  -->
    </div>
    <!-- /. WRAPPER  -->
    <!-- JS Scripts-->
    <!-- jQuery Js -->
    <script src="js/echarts.min.js"></script>
    <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
 option = {

         title : {
              text: '7天平均低负载状态监控图',
                  },
        tooltip : {
             trigger: 'axis'
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
	    xAxis: {
	        type: 'category',
	        data: date
	    },
	    yAxis: {
	        type: 'value'
	    },
     	   series : [
         	        {
         	            name:'七天的负载',
         	            type:'bar',
         	           data: vmLoad7
         	        },
         	    ]
    };

 
myChart.setOption(option);
    </script>
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