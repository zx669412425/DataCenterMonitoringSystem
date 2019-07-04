<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" import="org.fkit.controller.Get24"
	import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>虚拟机界面</title>
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
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css' />
<script src="assets/js/jquery-3.3.1.min.js"></script>
</head>
<body>
	<!-- ECharts单文件引入 -->
	<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
	<script type="text/JavaScript">

	function GetRequest() {
		var url = location.search; //获取url中"?"符后的字串  
		var theRequest = new Object();
		if (url.indexOf("?") != -1) {
			var str = url.substr(1);
			strs = str.split("&");
			for (var i = 0; i < strs.length; i++) {
				theRequest[strs[i].split("=")[0]] = decodeURI(strs[i]
						.split("=")[1]);//获取中文参数转码<span style="font-family: Arial, Helvetica, sans-serif;">decodeURI</span>，（unescape只针对数字，中文乱码)  
			}
		}
		return theRequest;
	}
	// $(function(){  
	//通过url取数  
	var request = new Object();
	request = GetRequest();
	var a = request['vmId'];
	// document.write(a+ "<br />");   
	var vmNetUsage = new Array();
	var vmCpuUsage = new Array();
	var vmMemoryUsage = new Array();
	var vm = a;
    var vmAverageNetUsage = new Array();
    var vmAverageCpuUsage = new Array();
    var vmAverageMemoryUsage = new Array();
	function getVmNetUsage(){
		$.ajax({	
		type:"get",
		url:"${pageContext.request.contextPath}/json/vmNetUsage",
		data:"id="+vm,
		async:false,
		success:function(data){
			vmNetUsage = data;	
		},
		dataType:"json"
		});		
		//setTimeout(getVmNetUsage, 15000);
		return vmNetUsage;
	}
	function getVmCpuUsage(){
		$.ajax({
		type:"get",	
		url:"${pageContext.request.contextPath}/json/vmCpuUsage",
		data:"id="+vm,
		async:false,
		success:function(data){
			vmCpuUsage = data;
			console.log("vmCpuUsage"+vmCpuUsage);
		},
		dataType:"json"		
		});
		//setTimeout(getVmCpuUsage,15000);
		return vmCpuUsage;
		}	
	function getVmMemoryUsage(){
		$.ajax({	
		type:"get",
		url:"${pageContext.request.contextPath}/json/vmMemoryUsage",
		data:"id="+vm,
		async:false,
		success:function(data){
			vmMemoryUsage = data;	
		},
		dataType:"json"
		});		
		//setTimeout(getVmMemoryUsage, 15000);
		return vmMemoryUsage;
	}
	function getVmAverageNetUsage(){
		$.ajax({	
		type:"get",
		url:"${pageContext.request.contextPath}/json/vmAverageNet",
		data:"id="+vm,
		async:false,
		success:function(data){
			vmAverageNetUsage = data;	
		},
		dataType:"json"
		});		
		//setTimeout(getVmAverageNetUsage, 15000);
		return vmAverageNetUsage;
	}
	function getVmAverageCpuUsage(){
		$.ajax({	
		type:"get",
		url:"${pageContext.request.contextPath}/json/vmAverageCpu",
		data:"id="+vm,
		async:false,
		success:function(data){
			vmAverageCpuUsage = data;	
		},
		dataType:"json"
		});		
		//setTimeout(getVmAverageCpuUsage, 15000);
		return vmAverageCpuUsage;
	}
	function getVmAverageMemoryUsage(){
		$.ajax({	
		type:"get",
		url:"${pageContext.request.contextPath}/json/vmAverageMemory",
		data:"id="+vm,
		async:false,
		success:function(data){
			vmAverageMemoryUsage = data;	
		},
		dataType:"json"
		});		
		//setTimeout(getVmAverageMemoryUsage, 15000);
		return vmAverageMemoryUsage;
	}
    function getArray288(){
    	var arr1 = new Array(288);
        for(var i=0;i<arr1.length;i++){
            arr1[i] = i;
        }
        return arr1;
    }
   // getVmNetUsage();
    //getVmCpuUsage();
   // getVmMemoryUsage();
	// 路径配置
	require.config({
		paths : {
			echarts : 'http://echarts.baidu.com/build/dist'
		}
	});

	// 使用
	require([ 'echarts',
	          'echarts/chart/line' // 使用柱状图就加载bar模块，按需加载
	        ],
			function(ec) {
				// 基于准备好的dom，初始化echarts图表
				   var myChart = ec.init(document.getElementById('main')); 

				option = {
					title : {
						text : '网络利用率'
					},
					tooltip : {
						trigger : 'axis'
					},
					legend : {
						data : [ '网络利用率' ]
					},
					toolbox : {
						show : true,
						feature : {
							mark : {
								show : true
							},
							dataView : {
								show : true,
								readOnly : false
							},
							magicType : {
								show : true,
								type : [ 'line', 'bar' ]
							},
							restore : {
								show : true
							},
							saveAsImage : {
								show : true
							}
						}
					},
					calculable : true,
					xAxis : [ {
						type : 'category',
						boundaryGap : true,
						data : getArray288()
					} ],
					yAxis : [ {
						type : 'value',
						// min:1.35,
						//max:1.60,
						axisLabel : {
							formatter : '{value} %'
						}
					} ],
					series : [ {
						name : '平均利用率',
						type : 'line',
						data : [],
						markPoint : {
							data : [ {
								type : 'max',
								name : '最大值'
							}, {
								type : 'min',
								name : '最小值'
							} ]
						},
						data : getVmNetUsage()
					},
					{
                        name:'7天平均网络利用率',
                        type:'line',
                        data: getVmAverageNetUsage()
                    },
					]
				};
				//cpu_option                    
				cpu_option = {
					title : {
						text : 'CPU利用率'
					},
					tooltip : {
						trigger : 'axis'
					},
					legend : {
						data : [ 'CPU利用率' ]
					},
					toolbox : {
						show : true,
						feature : {
							mark : {
								show : true
							},
							dataView : {
								show : true,
								readOnly : false
							},
							magicType : {
								show : true,
								type : [ 'line', 'bar' ]
							},
							restore : {
								show : true
							},
							saveAsImage : {
								show : true
							}
						}
					},
					calculable : true,
					xAxis : [ {
						type : 'category',
						boundaryGap : true,
						data : getArray288()
					} ],
					yAxis : [ {
						type : 'value',
						// min:1.35,
						//max:1.60,
						axisLabel : {
							formatter : '{value} %'
						}
					} ],
					series : [ {
						name : '平均利用率',
						type : 'line',
						data : [],
						markPoint : {
							data : [ {
								type : 'max',
								name : '最大值'
							}, {
								type : 'min',
								name : '最小值'
							} ]
						},
						data : getVmCpuUsage()
					},
					{
                        name:'7天平均CPU利用率',
                        type:'line',
                        data: getVmAverageCpuUsage()
                    },
					]
				};
				//memory_option
				memory_option = {
					title : {
						text : '内存利用率'
					},
					tooltip : {
						trigger : 'axis'
					},
					legend : {
						data : [ '内存利用率' ]
					},
					toolbox : {
						show : true,
						feature : {
							mark : {
								show : true
							},
							dataView : {
								show : true,
								readOnly : false
							},
							magicType : {
								show : true,
								type : [ 'line', 'bar' ]
							},
							restore : {
								show : true
							},
							saveAsImage : {
								show : true
							}
						}
					},
					calculable : true,
					xAxis : [ {
						type : 'category',
						boundaryGap : true,
						data : getArray288()
					} ],
					yAxis : [ {
						type : 'value',
						// min:1.35,
						//max:1.60,
						axisLabel : {
							formatter : '{value} %'
						}
					} ],
					series : [ 
					    {
						name : '平均内存利用率',
						type : 'line',
						data : [],
						markPoint : {
							data : [ {
								type : 'max',
								name : '最大值'
							}, {
								type : 'min',
								name : '最小值'
							} ]
						},
						data : getVmMemoryUsage()
					},
					{
                        name:'7天平均内存利用率',
                        type:'line',
                        data: getVmAverageMemoryUsage()
                    },

					]
				};
				// 为echarts对象加载数据 
/* vmNetUsage=getVmNetUsage();				
vmcpuUsage=getVmCpuUsage();					
memoryUsage=getVmMemoryUsage();					
var netUsage=vmNetUsage[287];
var cpuUsage=vmcpuUsage[287];
var memoryUsage=vmMemoryUsage[287]; */
				myChart.setOption(option);

/* 				setInterval(a, 5000);
				function a() {
					//document.write("aaaaaaaaaaaaaaaaaaaaaaa");
					getVmNetUsage();
					myChart.setOption(option);
				} */

				window.onload = function() {
					//myChart.setOption(option);
					// setInterval(myChart.setOption(option), 5000);
					document.getElementById('select').addEventListener('change',function() {
										//alert("当前选项是:"+this.value);
										var netUsage = "netUsage";
										var cpuUsage = "cpuUsage";
										var memoryUsage = "memoryUsage";
										if (this.value == netUsage) {
											//alert("当前选项是:1");
											myChart.clear();
											myChart.setOption(option);
											setInterval(myChart.setOption(option), 5000);
										}
										if (this.value == cpuUsage) {
											//alert("当前选项是:2");
											myChart.clear();
											myChart.setOption(cpu_option);
											setInterval(myChart.setOption(cpu_option),5000);
										}
										if (this.value == memoryUsage) {
											//alert("当前选项是:3");
											myChart.clear();
											myChart.setOption(memory_option);
											setInterval(myChart.setOption(memory_option),5000);
										}

									}, true);
				}
			});
</script>

	<div id="wrapper">
		<nav class="navbar navbar-default top-navbar" role="navigation">
		<div class="navbar-header">
			<a class="navbar-brand" href="">Dream</a>
		</div>
		</nav>
		<!--/. NAV TOP  -->
		<nav class="navbar-default navbar-side" role="navigation">
		<div class="sidebar-collapse">
			<ul class="nav" id="main-menu">
				<li><a href="index.jsp"><i class="fa fa-sitemap"></i> 主界面</a></li>
				<li><a href="PhysicalMachine.jsp?hostId=1"><i
						class="fa fa-sitemap"></i> 物理机</a> <!--  <ul class="nav nav-second-level">
                            <li>
                                <a href="#">虚拟机1</a>
                            </li>
                            <li>
                                <a href="#">虚拟机2</a>
                            </li>
                            <li>
                                <a href="#">虚拟机3</a>
                            </li>
                        </ul> -->
					<a href="VirtualMachine.jsp?vmId=1"><i	class="fa fa-sitemap"></i> 虚拟机</a>
					<a href="Load.jsp?"><i class="fa fa-sitemap"></i> 负载详情</a>
					<a href="heatmap.jsp" target="_blank"><i class="fa fa-sitemap"></i> 负载热力图</a>
					<a href="globalpowerbyhost.jsp" target="_blank"><i class="fa fa-sitemap"></i> 负载损耗分布</a>
			</ul>

		</div>

		</nav>
		<!-- /. NAV SIDE  -->
		<div id="page-wrapper">
			<div id="page-inner">


				<!--  <div class="row">
                    <div class="col-md-12">
                        <h1 class="page-header">
                            Dashboard <small>Summary of your App</small>
                        </h1>
                    </div>
                </div> -->
				<!-- /. ROW  -->

				<div class="row">
					<div class="col-md-3 col-sm-12 col-xs-12">
						<div
							class="panel panel-primary text-center no-boder bg-color-green">
							<div class="panel-body">
								<!-- <i class="fa fa-bar-chart-o fa-5x"></i> -->
								<script type="text/javascript">
								 var vmNetUsage=getVmNetUsage();				
								var vmcpuUsage=getVmCpuUsage();					
								var memoryUsage=getVmMemoryUsage();
								//console.log("-------------------"+vmNetUsage);
								 netUsage=vmNetUsage[287];
								  cpuUsage=vmcpuUsage[287];
								  memoryUsage=vmMemoryUsage[287]; 
								/*
								function check(){
                                 var num = document.getElementById('num'); //获取数据
                                 if(num.value < 50){ //进行比较
                                 num.style.color = 'red';
                                 }
								 else{
                                     num.style.color = 'black';
                                      }
									  }
								*/
								</script>
								<h3>
									<script>
									/* getVmNetUsage();
									document.write(vmNetUsage[287]); */
									document.write(netUsage);
									</script>
								</h3>
							</div>
							<div class="panel-footer back-footer-green">网络利用率</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-12 col-xs-12">
						<div
							class="panel panel-primary text-center no-boder bg-color-green">
							<div class="panel-body">
								<!-- <i class="fa fa-shopping-cart fa-5x"></i> -->
								<script type="text/javascript">
								//getVmCpuUsage();
								//var cpuUsage=10
								</script>
								<h3>
									<script>
									/* getVmCpuUsage();
									document.write(vmCpuUsage[287]); */
									document.write(cpuUsage);
									</script>
								</h3>
							</div>
							<div class="panel-footer back-footer-green">CPU利用率</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-12 col-xs-12">
						<div
							class="panel panel-primary text-center no-boder bg-color-green">
							<div class="panel-body">
								<!-- <i class="fa fa fa-comments fa-5x"></i> -->
								<script type="text/javascript">
								//getVmMemoryUsage();
								//var memoryUsage=10
								</script>
								<h3>
									<script>
									/* getVmMemoryUsage();
									document.write(vmMemoryUsage[287]); */
									document.write(memoryUsage);
									</script>
								</h3>
							</div>
							<div class="panel-footer back-footer-green">内存利用率</div>
						</div>
					</div>
					<!-- <div class="col-md-3 col-sm-12 col-xs-12">
						<div
							class="panel panel-primary text-center no-boder bg-color-green">
							<div class="panel-body">
								<i class="fa fa-users fa-5x"></i>
								<script type="text/javascript">
								var netUsage=10
								</script>
								<h3>
									<script>document.write(netUsage)</script>
								</h3>
							</div>
							<div class="panel-footer back-footer-green">No. of Visits</div>
						</div>
					</div> -->
				</div>


				<div class="row">


					<div style="height: 400px" ,width="400px">
						<div class="panel panel-default">
							<div class="panel-heading">
								请选择数据 <select id="select">
									<option id="netUsage" value="netUsage">网络利用率</option>
									<option id="cpuUsage" value="cpuUsage">CPU利用率</option>
									<option id="memoryUsage" value="memoryUsage">内存利用率</option>
								</select>

							</div>
							<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
							<div id="main" style="height: 400px" ,width="400px"></div>

							<!-- <div class="panel-body">
                                <div id="morris-bar-chart"></div>
                            </div> -->
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
	<script src="assets/js/jquery-1.10.2.js"></script>
	<!-- Bootstrap Js -->
	<script src="assets/js/bootstrap.min.js"></script>
	<!-- Metis Menu Js -->
	<script src="assets/js/jquery.metisMenu.js"></script>
	<!-- Morris Chart Js -->
	<script src="assets/js/morris/raphael-2.1.0.min.js"></script>
	<script src="assets/js/morris/morris.js"></script>
	<!-- Custom Js -->
	<script src="assets/js/custom-scripts.js"></script>
</body>
</html>