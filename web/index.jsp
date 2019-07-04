<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="assets/js/jquery-3.3.1.min.js"></script>


<html>
<head>
<title>主界面1</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.STYLE1 {
	color: #0066FF;
	font-size: 14px;
}
.STYLE2 {
	color: #666666;
	font-size: 10px;
}
.STYLE3 {
	color: #666666;
	font-size: 9px;
}
.m {
		font-size: 18px;
}

td div{
	width:100px;
	height:30px;
}
.long{
	width:200px;
}
-->
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
</head>
<script>
	var backData;
    $(document).ready(function(){
        var power = getpowertochen();       //pdu电源耗能
        var temprature = gettemptochen();   //温度计温度，目前3台
        var host = gethotstochen();         //主机的参数，两台主机：host1，host2，包含内容CpuUsage，CpuUsage，MemoryUsage


        $("#power_pdu1").html(power[0]);
        $("#power_pdu2").html(power[1]);
        $("#temp1").html(temprature[0]);
        $("#temp2").html(temprature[1]);
        $("#temp3").html(temprature[2]);

        $("#host1cpu").html(host[0]);
        $("#host1net").html(host[1]);
        $("#host1memory").html(host[2]);
        $("#host2cpu").html(host[3]);
        $("#host2net").html(host[4]);
        $("#host2memory").html(host[5]);
    });
    function getpowertochen(){
        $.ajax({
            type: 'get',
            url: "${pageContext.request.contextPath}/json/getpowertochen",
            data: "id=",
            async : false,
            success: function(data){
//  			  console.log('id 2 '+data);
                power=data;
            },
            dataType: "json"
        });
        return power;
    }
    function gettemptochen(){
        $.ajax({
            type: 'get',
            url: "${pageContext.request.contextPath}/json/gettemptochen",
            data: "id=",
            async : false,
            success: function(data){
//  			  console.log('id 2 '+data);
                temp=data;
            },
            dataType: "json"
        });
        return temp;
    }
    function gethotstochen(){
        $.ajax({
            type: 'get',
            url: "${pageContext.request.contextPath}/json/gethotstochen",
            data: "id=",
            async : false,
            success: function(data){
//  			  console.log('id 2 '+data);
                host=data;
            },
            dataType: "json"
        });
        return host;
    }
    var vmAlarm = new Array();
	function getAlarm(){
		$.ajax({
			type: 'get',
			url: "${pageContext.request.contextPath}/json/alarmedVm",
			async : false,
			success: function(data){
  			  console.log('id 2 '+data);
				vmAlarm=data;
			},
			dataType: "json"
		});
		return vmAlarm;
	}
	vmAlarm = getAlarm();
	console.log(vmAlarm);
	var vmAlarm1 = new Array();
	function getAlarm1(){
		$.ajax({
			type:"get",
			url:"${pageContext.request.contextPath}/json/alarmedVm",
			//data:"id="+1,
			async:false,
			datatype:"json",
			contentType: 'application/json;charset=utf-8',
			success:function(data){
				console.log(data+"+alarmedVm1");
				vmAlarm1 = data;
			},
		});
		return vmAlarm1;
	}
	vmAlarm1 = getAlarm1();
	console.log(vmAlarm1);
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
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<div id="wrapper">
	<nav class="navbar navbar-default top-navbar" role="navigation">
		<div class="navbar-header">
			<a class="navbar-brand" href="">智能机房监测</a>
		</div>
	</nav>
	<!--/. NAV TOP  -->
	<nav class="navbar-default navbar-side" role="navigation">
		<div class="sidebar-collapse">
			<ul class="nav" id="main-menu">
				<li>
					<a href="#"><i class="fa fa-sitemap"></i> 主界面</a>
				</li>
				<li>
					<a href="" onclick="display(event)"><i class="fa fa-sitemap"></i> 物理机</a>
					<a href="PhysicalMachine.jsp?hostId=1"  id="host1" style="display:none;margin-left:50px;"><i class="fa fa-sitemap" ></i> 服务器1</a>
					<a href="PhysicalMachine.jsp?hostId=2"  id="host2" style="display:none;margin-left:50px;"><i class="fa fa-sitemap" ></i> 服务器2</a>
					<a href="VirtualMachine.jsp?vmId=1"><i class="fa fa-sitemap"></i> 虚拟机</a>
					<a href="Load.jsp?"><i class="fa fa-sitemap"></i> 负载详情</a>
					<a href="heatmap.jsp"><i class="fa fa-sitemap"></i> 负载热力图</a>
					<a href="globalpowerbyhost.jsp"><i class="fa fa-sitemap"></i> 负载损耗分布</a>

				</li>
			</ul>

		</div>

	</nav>
	<!-- /. NAV SIDE  -->
	<div id="page-wrapper">

							<!-- <i class="fa fa-bar-chart-o fa-5x"></i> -->
							<script type="text/javascript">
                                //console.log(hostNetUsage1);
							</script>
							<table id="__01" width="778" height="644" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td colspan="7">
										<img src="images/index_01.gif" width="777" height="10" alt=""></td>
									<td>
										<img src="images/d.gif" width="1" height="10" alt=""></td>
								</tr>
								<tr>
									<td colspan="2">
										<img src="images/index_02.gif" width="174" height="49" alt=""></td>
									<td  bgcolor="ffffff"><span class="STYLE1">温度计1</span>
										<br>
										<span class="STYLE2">温度：</span><span id="temp1" class="STYLE2"></span></td>
									<td  bgcolor="ffffff"><span class="STYLE1">温度计2</span>
										<br>
										<span class="STYLE2">温度：</span><span id="temp2" class="STYLE2"></span></td>
									<td colspan="2" bgcolor="ffffff">
										<span class="STYLE1">温度计3</span>
										<br>
										<span class="STYLE2">温度：</span><span id="temp3" class="STYLE2"></span></td>
									<td>
										<img src="images/index_06.gif" width="93" height="49" alt=""></td>
									<td>
										<img src="images/d.gif" width="1" height="49" alt=""></td>
								</tr>
								<tr>
									<td>
										<img src="images/index_07.gif" width="148" height="55" alt=""></td>
									<td colspan="6" rowspan="4">
										<img src="images/index_08.gif" width="629" height="472" border="0" usemap="#Map"></td>
									<td>
										<img src="images/d.gif" width="1" height="55" alt=""></td>
								</tr>
								<tr>
									<td align="center" bgcolor="ffffff"><span class="STYLE1">PDU1</span><br>

										<span class="STYLE2">功耗：</span><span id="power_pdu1" class="STYLE2"></span></td>
									<td>
										<img src="images/d.gif" width="1" height="98" alt=""></td>
								</tr>
								<tr>
									<td align="center" bgcolor="ffffff"><span class="STYLE1">PDU2</span><br>

										<span class="STYLE2">功耗：</span><span id="power_pdu2" class="STYLE2"></span></td>
									<td>
										<img src="images/d.gif" width="1" height="100" alt=""></td>
								</tr>
								<tr>
									<td rowspan="2">
										<img src="images/index_11.gif" width="148" height="331" alt=""></td>
									<td>
										<img src="images/d.gif" width="1" height="219" alt=""></td>
								</tr>
								<tr>
									<td colspan="2" bgcolor="ffffff">
										<span class="STYLE1">物理机202.120.103.128</span><BR>
										<span class="STYLE2">CpuUsage：</span><span id="host1cpu" class="STYLE2"></span><BR>
										<span class="STYLE2">NetUsage：</span><span id="host1net" class="STYLE2"></span><BR>
										<span class="STYLE2">MemoryUsage：</span><span id="host1memory" class="STYLE2"></span><BR>
										<span class="STYLE3">IPv6:2001:da8:8007:3c0:8190:ba8:ca78:6780</span><BR>
									</td>
									<td colspan="2" bgcolor="ffffff">
										<span class="STYLE1">物理机202.120.103.38</span><BR>
										<span class="STYLE2">CpuUsage：</span><span id="host2cpu" class="STYLE2"></span><BR>
										<span class="STYLE2">NetUsage：</span><span id="host2net" class="STYLE2"></span><BR>
										<span class="STYLE2">MemoryUsage：</span><span id="host2memory" class="STYLE2"></span><BR>
										<span class="STYLE3">IPv6:2001:da8:8007:3c0:8190:ba8:ca78:6726</span><BR>
									</td>
									<td colspan="2">
										<img src="images/index_14.gif" width="219" height="112" alt=""></td>
									<td>
										<img src="images/d.gif" width="1" height="112" alt=""></td>
								</tr>
								<tr>
									<td>
										<img src="images/d.gif" width="148" height="1" alt=""></td>
									<td>
										<img src="images/d.gif" width="26" height="1" alt=""></td>
									<td>
										<img src="images/d.gif" width="167" height="1" alt=""></td>
									<td>
										<img src="images/d.gif" width="167" height="1" alt=""></td>
									<td>
										<img src="images/d.gif" width="50" height="1" alt=""></td>
									<td>
										<img src="images/d.gif" width="126" height="1" alt=""></td>
									<td>
										<img src="images/d.gif" width="93" height="1" alt=""></td>
									<td></td>
								</tr>
							</table>
							<map name="Map">
								<area shape="rect" coords="28,307,186,434" href="PhysicalMachine.jsp?hostId=1">
								<area shape="rect" coords="238,309,407,436" href="PhysicalMachine.jsp?hostId=2">
							</map>
		                    <div style="margin:30px auto">
								<table style="width:600px;text-align:center">
									<tr>
										<td><div style='width:200px;'>虚机名</div></td>
										<td><div>Net</div></td>
										<td><div>CPU</div></td>
										<td><div>Memory</div></td>
										<td><div style="width:200px;">Time</div></td>
									</tr>
								</table>
								<div id="demo" style="overflow:hidden;height:90px;">
									<div id="demo1">
										   <table  id="alarm" style="width:600px;text-align:center"></table>
									</div>
									<div id="demo2"></div>
								</div>
							</div>
		<!-- /. PAGE INNER  -->
	</div>
	<!-- /. PAGE WRAPPER  -->
</div>
<script>
	function drawAlarm(arr){
		var ele = document.getElementById("alarm");
		var str = '';
		for(var i=0;i<5;i++){
			str += "<tr><td><div class='long'>"+ arr[i].vmName+"</div></td>";
			if(arr[i].netUsageFlag){
				str += "<td style='color:red'><div>" + arr[i].netUsage +"</div></td>"
			}else{
				str += "<td><div>" + arr[i].netUsage +"</div></td>"
			}
			if(arr[i].cpuUsageFlag){
				str += "<td style='color:red'><div>" + arr[i].cpuUsage +"</div></td>"
			}else{
				str += "<td><div>" + arr[i].cpuUsage +"</div></td>"
			}
			if(arr[i].memoryUsageFlag){
				str += "<td style='color:red'><div>" + arr[i].memoryUsage +"</div></td>"
			}else{
				str += "<td><div>" + arr[i].memoryUsage +"</div></td>"
			}
			str += "<td><div class='long'>"+ arr[i].date+"</div><td></tr>"
		}
		ele.innerHTML = str;
		demo2.innerHTML = demo1.innerHTML;
	}

	function Marquee() {
		if (demo.scrollTop >= 210 ) {
			demo.scrollTop -= demo1.offsetHeight;
		} else {
			demo.scrollTop++;
			//console.log(demo.scrollTop);
		}
	}

	// data = getAlarm();
	// console.log(data);
	// var arr = [{vmName:1,cpuUsage:1,netUsage:2,memoryUsage:3,cpuUsageFlag:true,netUsageFlag:true,memoryUsageFlag:true,date:"2012.03"},
	// 	{vmName:1,cpuUsage:1,netUsage:2,memoryUsage:3,cpuUsageFlag:true,netUsageFlag:true,memoryUsageFlag:true,date:"2012.03"},
	// 	{vmName:1,cpuUsage:1,netUsage:2,memoryUsage:3,cpuUsageFlag:true,netUsageFlag:true,memoryUsageFlag:true,date:"2012.03"},
	// 	{vmName:1,cpuUsage:1,netUsage:2,memoryUsage:3,cpuUsageFlag:true,netUsageFlag:true,memoryUsageFlag:true,date:"2012.03"},
	// 	{vmName:1,cpuUsage:1,netUsage:2,memoryUsage:3,cpuUsageFlag:true,netUsageFlag:true,memoryUsageFlag:true,date:"2012.03"}]
	drawAlarm(vmAlarm);
	var speed = 50;
	var MyMar = setInterval(Marquee, speed);


</script>
<!-- ImageReady Slices (1.psd) -->

<!-- End ImageReady Slices -->
</body>
</html>