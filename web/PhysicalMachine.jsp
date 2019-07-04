<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8"/>
    <title>物理机界面</title>
    <!--定义表格样式-->
    <style type="text/css">
        table{
            width:150px;
            height:60px;
            border:green 1px solid;
            border-collapse:collapse;
        }
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- Bootstrap Styles-->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FontAwesome Styles-->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- Morris Chart Styles-->
    <!-- link href="assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" /> -->
    <!-- Custom Styles-->
    <link href="assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <script src="assets/js/jquery-3.3.1.min.js"></script>
</head>


<body>
<!-- ECharts单文件引入 -->
<script src="js/echarts.min.js"></script>
<!--<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>-->
<script type="text/javascript">
    var hostNetUsage=new Array();
    var hostCpuUsage=new Array();
    var hostMemoryUsage=new Array();
    var vmName=new Array();
    var vmId=new Array();
    var hostAverageMemoryUsage=new Array();
    var hostAverageCpuUsage=new Array();
    var hostAverageNetUsage=new Array();
    var hostNetUsage1;
    //var vm=1;

    /* $.ajaxSetup({
         async : true
     });
     */
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
    var vm=a;
    //document.write(a+ "<br />");
    //物理机网络利用率
    function getHostNetUsage(){
        $.ajax({
            type: 'get',
            url: "${pageContext.request.contextPath}/json/hostNetUsage",
            data: "id="+vm,
            async : false,
            success: function(data){
                // console.log("hostNetUsage"+data);
                hostNetUsage=data;
                // console.log("hostNetUsage"+hostNetUsage);
            },
            dataType: "json"
        });
        return hostNetUsage;
    }
    function getHostCpuUsage(){
        $.ajax({
            type: 'get',
            url: "${pageContext.request.contextPath}/json/hostCpuUsage",
            data: "id="+vm,
            async : false,
            success: function(data){

                hostCpuUsage=data;
                // console.log("hostCpuUsage"+hostCpuUsage);
            },
            dataType: "json"
        });
        return hostCpuUsage;
    }
    function getHostMemoryUsage(){
        $.ajax({
            type: 'get',
            url: "${pageContext.request.contextPath}/json/hostMemoryUsage",
            data: "id="+vm,
            async : false,
            success: function(data){
                hostMemoryUsage=data;
                //  console.log("hostMemoryUsage"+hostMemoryUsage);
            },
            dataType: "json"
        });
        return hostMemoryUsage;
    }
    function getHostVmName(){
        $.post("${pageContext.request.contextPath}/json/vmName",{id:vm},
            function(data){
                for(var i=0;i<data.length;i++){
                    vmName[i]=data[i];
                }
            },"json");
    }
    function getVmId(){
        $.post("${pageContext.request.contextPath}/json/vmId",{id:vm},
            function(data){
                for(var i=0;i<data.length;i++){
                    vmId[i]=data[i];
                }
            },"json");
    }
    function getHostAverageMemoryUsage(){
        $.ajax({
            type: 'get',
            url: "${pageContext.request.contextPath}/json/hostAverageMemory",
            data: "id="+vm,
            async : false,
            success: function(data){

                hostAverageMemoryUsage=data;
                //  console.log("hostAverageMemoryUsage"+hostAverageMemoryUsage);
            },
            dataType: "json"
        });
        return hostAverageMemoryUsage;
    }
    function getHostAverageCpuUsage(){
        $.ajax({
            type: 'get',
            url: "${pageContext.request.contextPath}/json/hostAverageCpu",
            data: "id="+vm,
            async : false,
            success: function(data){

                hostAverageCpuUsage=data;
                // console.log("hostAverageCpuUsage"+hostAverageCpuUsage);
            },
            dataType: "json"
        });
        return hostAverageCpuUsage;
    }
    //物理机平均网络利用率
    function getHostAverageNetUsage(){
        $.ajax({
            type: 'get',
            url: "${pageContext.request.contextPath}/json/hostAverageNet",
            data: "id="+vm,
            async : false,
            success: function(data){
                // console.log("hostAverageNetUsage"+data);
                hostAverageNetUsage=data;
                // console.log("hostAverageNetUsage"+hostAverageNetUsage);
            },
            dataType: "json"
        });
        return hostAverageNetUsage;
    }
    function getarray288(){
        var arr1 = new Array(288);
        for(var i=0;i<arr1.length;i++){
            arr1[i] = parseInt(i/12);
        }
        return arr1;
    }
    getHostVmName();
    getVmId();
    option = {
        title : {
            text: '网络利用率'
        },
        tooltip : {
            trigger: 'axis'
        },
        legend: {
            data:['网络利用率']
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                //magicType : {show: true, type: ['line', 'bar']},
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        calculable : true,
        xAxis : [
            {
                type : 'category',
                boundaryGap : true,
                data:getarray288()
                //data : ['0时','1时','2时','3时','4时','5时','6时','7时','8时','9时','10时','11时','12时','13时','14时','15时','16时','17时','18时','19时','20时','21时','22时','23时',]
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
                        //  {type : 'max', name: '最大值'},
                        //  {type : 'min', name: '最小值'}
                    ]
                },
                data: getHostNetUsage()
//                            data: getarray288()
            },
            {
                name:'7天平均网络利用率',
                type:'line',
                data: getHostAverageNetUsage()
                //                            data:getarray288()
            },

        ]
    };
    //cpu_option
    cpu_option = {
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
                //magicType : {show: true, type: ['line', 'bar']},
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        calculable : true,
        xAxis : [
            {
                type : 'category',
                boundaryGap : true,
                //data : ['0时','1时','2时','3时','4时','5时','6时','7时','8时','9时','10时','11时','12时','13时','14时','15时','16时','17时','18时','19时','20时','21时','22时','23时',]
                data:getarray288()
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
                name:'平均CPU利用率',
                type:'line',
                data:[],
                markPoint : {
                    data : [
                        //   {type : 'max', name: '最大值'},
                        //   {type : 'min', name: '最小值'}
                    ]
                },
                data:getHostCpuUsage()
            },
            {
                name:'7天平均CPU利用率',
                type:'line',
                data: getHostAverageCpuUsage()
            },

        ]
    };
    //memory_option
    memory_option = {
        title : {
            text: '内存利用率'
        },
        tooltip : {
            trigger: 'axis'
        },
        legend: {
            data:['内存利用率']
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                //magicType : {show: true, type: ['line', 'bar']},
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        calculable : true,
        xAxis : [
            {
                type : 'category',
                boundaryGap : true,
                data:getarray288()
                //data : ['0时','1时','2时','3时','4时','5时','6时','7时','8时','9时','10时','11时','12时','13时','14时','15时','16时','17时','18时','19时','20时','21时','22时','23时',]
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
                name:'平均内存利用率',
                type:'line',
                data:[],
                markPoint : {
                    data : [
                        {type : 'max', name: '最大值'},
                        {type : 'min', name: '最小值'}
                    ]
                },
                data: getHostMemoryUsage()
            },
            {
                name:'7天平均内存利用率',
                type:'line',
                data: getHostAverageMemoryUsage()

            },

        ]
    };
    $(document).ready(function() {
        //创建table表格
        var table=document.createElement("table");
        //设置属性
        table.setAttribute("border","1");
        //获取行数值
        var line=vmName.length-1;
        //获取列数值
        var list=2;
        for(var i=0;i<=line;i++){
            //创建tr
            var tr=document.createElement("tr");
            var td=document.createElement("td");
            td.style.width="100";
            tr.appendChild(td);
            td.innerHTML=vmName[i];


            var td=document.createElement("td");
//        td.style.height = "30";//高度
//        var butt=document.createElement("button");
//        butt.style.height = "30";//高度
//        butt.style.width = "50";//宽度
//        butt.id = i;
//        butt.innerHTML = "查看";
            tr.appendChild(td);
            td.innerHTML="<a href=VirtualMachine.jsp?vmId="+vmId[i]+"> 查 看  </a>";
            /* td.innerHTML="查看";
            td.innerHTML.href='VirtualMachine.jsp?vmId='+vmId[i] ; */
//        td.appendChild(butt);

            table.appendChild(tr);
        }
        document.getElementById("d1").appendChild(table);

        var dom = document.getElementById("main");
        var myChart = echarts.init(dom);
        myChart.clear();
        // alert("当前选项是:1");
        myChart.setOption(option);
    });

    window.onload=function() {
    // 基于准备好的dom，初始化echarts图表
    // var myChart = ec.init(document.getElementById('main'));
    //alert("初始化图表");
    //var dom = document.getElementById("main");
    //var myChart = echarts.init(dom);
    //---------------------------------------------------------------------------------------------------------

    //myChart.clear();
    //myChart.setOption(option);
    //-----------------------------------------------------------------------------------------------------------
    // 为echarts对象加载数据

    //使用window.location函数来设置页面自动加载，1为下拉框添加监听事件，并为每一个option添加反应。2设置页面自动生成表格。

        var dom = document.getElementById("main");
        var myChart = echarts.init(dom);
        //myChart.setOption(option);
        //setInterval(myChart.setOption(option), 5000);
        //得到下拉列表，并对每个选项添加反应
        document.getElementById('select').addEventListener('change', function () {
            //alert("当前选项是:"+this.value);
            var netUsage = "netUsage";
            var cpuUsage = "cpuUsage";
            var memoryUsage = "memoryUsage";
            if (this.value == netUsage) {
                myChart.clear();
                // alert("当前选项是:1");
                myChart.setOption(option);
            }
            if (this.value == cpuUsage) {
                myChart.clear();
                myChart.setOption(cpu_option);
            }
            if (this.value == memoryUsage) {
                myChart.clear();
                myChart.setOption(memory_option);
            }
        }, true);


        //创建table表格

    }

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
            <a class="navbar-brand" href="">Dream</a>
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
                    <a href="VirtualMachine.jsp?vmId=1"><i	class="fa fa-sitemap"></i> 虚拟机</a>
                    <a href="Load.jsp?"><i class="fa fa-sitemap"></i> 负载详情</a>
                    <a href="heatmap.jsp"><i class="fa fa-sitemap"></i> 负载热力图</a>
                    <a href="globalpowerbyhost.jsp"><i class="fa fa-sitemap"></i> 负载损耗分布</a>
                </li>
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
                    <div class="panel panel-primary text-center no-boder bg-color-green">
                        <div class="panel-body">
                            <!-- <i class="fa fa-bar-chart-o fa-5x"></i> -->
                            <script type="text/javascript">
                                //console.log(hostNetUsage1);
                            </script>
                            <h3><script>getHostNetUsage();console.log(hostNetUsage[287]);document.write(hostNetUsage[287]);</script></h3>
                        </div>
                        <div class="panel-footer back-footer-green" id="netPanel">
                            网络利用率
                             <script>
                                 if(hostNetUsage[287]>30){
                                     var netPanel = document.getElementById("netPanel");
                                     netPanel.className = "panel-footer back-footer-red";
                                 }
                             </script>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-12 col-xs-12">
                    <div class="panel panel-primary text-center no-boder bg-color-green">
                        <div class="panel-body">
                            <!-- <i class="fa fa-shopping-cart fa-5x"></i> -->
                            <script type="text/javascript">
                                //console.log(hostCpuUsage[23]);
                            </script>
                            <h3><script>getHostCpuUsage();console.log(hostCpuUsage[287]);document.write(hostCpuUsage[287]);</script></h3>
                        </div>
                        <div class="panel-footer back-footer-green" id="cpuPanel">
                            CPU利用率
                            <script>
                                if(hostCpuUsage[287]>30){
                                    var cpuPanel = document.getElementById("cpuPanel");
                                    cpuPanel.className = "panel-footer back-footer-red";
                                }
                            </script>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-12 col-xs-12">
                    <div class="panel panel-primary text-center no-boder bg-color-green">
                        <div class="panel-body">
                            <!-- <i class="fa fa fa-comments fa-5x"></i> -->
                            <script type="text/javascript">
                                //console.log(hostMemoryUsage[23]);
                            </script>
                            <h3><script>getHostMemoryUsage();console.log(hostMemoryUsage[287]);document.write(hostMemoryUsage[287]);</script></h3>
                        </div>
                        <div class="panel-footer back-footer-green" id="memoryPanel">
                            内存利用率
                            <script>
                                if(hostMemoryUsage[287]>30){
                                    var memoryPanel = document.getElementById("memoryPanel");
                                    memoryPanel.className = "panel-footer back-footer-red";
                                }
                            </script>
                        </div>
                    </div>
                </div>

            </div>


            <div class="row">


                <div class="col-md-9 col-sm-12 col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            请选择数据
                            <select id="select" >
                                <option id="netUsage" value ="netUsage">网络利用率</option>
                                <option id="cpuUsage" value ="cpuUsage">CPU利用率</option>
                                <option id="memoryUsage" value="memoryUsage">内存利用率</option>
                            </select>
                             <span class="pull-right" id="hostName">
                                 主机ID:
                                 <script>
										var str = location.search;
										console.log(str);
                                        var arr = str.split("=");
                                        console.log(arr);
                                        if(arr[1]=="1"){
                                            document.write("192.168.2.40")
                                        }else if(arr[1]=="2"){
                                            document.write("192.168.3.175")
                                        }
									</script>
                             </span>
                        </div>
                        <div class="panel-body">
                            <!-- 在此处添加图表 -->
                            <!-- <div id="morris-bar-chart"></div> -->
                            <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
                            <div id="main" style="height:400px;width:100%"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-12 col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            虚拟机列表
                        </div>
                        <div id="d1" style="height:600px; width:100px;">
                        </div>
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
<script src="assets/js/jquery.metisMenu.js" ></script>
<!-- Morris Chart Js -->
<script src="assets/js/morris/raphael-2.1.0.min.js"></script>
<script src="assets/js/morris/morris.js"></script>
<!-- Custom Js -->
<script src="assets/js/custom-scripts.js"></script>

</body>
</html>