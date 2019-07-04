<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="assets/js/jquery-3.3.1.min.js"></script>


<html>
<head>
<title>1</title>
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
.m {
		font-size: 18px;
}
-->
</style>
</head>
<script>
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
</script>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- ImageReady Slices (1.psd) -->
<table widthh="778" height="30" border="0" cellpadding="0" cellspacing="0">
<tr align="right"><td align="right"><a href="http://localhost:8080/PhysicalMachine.jsp?hostId=1"> <span class="m">主界面</span></a></td></tr>
</table>
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
		<td><span class="STYLE1">温度计1</span><br>
			<br>
			<span class="STYLE2">温度：</span><span id="temp1" class="STYLE2"></span></td>
		<td><span class="STYLE1">温度计2</span><br>
			<br>
			<span class="STYLE2">温度：</span><span id="temp2" class="STYLE2"></span></td>
		<td colspan="2">
			<span class="STYLE1">温度计3</span><br>
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
		<td align="center"><span class="STYLE1">PDU1</span><br>
			<br>
			<span class="STYLE2">功耗：</span><span id="power_pdu1" class="STYLE2"></span></td>
		<td>
			<img src="images/d.gif" width="1" height="98" alt=""></td>
	</tr>
	<tr>
		<td align="center"><span class="STYLE1">PDU2</span><br>
			<br>
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
		<td colspan="2">
			<span class="STYLE1">物理机202.120.103.128</span><br>
			<br>
			<span class="STYLE2">CpuUsage：</span><span id="host1cpu" class="STYLE2"></span><BR>
			<span class="STYLE2">NetUsage：</span><span id="host1net" class="STYLE2"></span><BR>
			<span class="STYLE2">MemoryUsage：</span><span id="host1memory" class="STYLE2"></span><BR>
			<span class="STYLE2">IPv6:<BR>2001:da8:8007:3c0:-<BR>-8190:ba8:ca78:6780</span><BR>
		</td>
		<td colspan="2">
			<span class="STYLE1">物理机202.120.103.38</span><br>
			<br>
			<span class="STYLE2">CpuUsage：</span><span id="host2cpu" class="STYLE2"></span><BR>
			<span class="STYLE2">NetUsage：</span><span id="host2net" class="STYLE2"></span><BR>
			<span class="STYLE2">MemoryUsage：</span><span id="host2memory" class="STYLE2"></span><BR>
			<span class="STYLE2">IPv6:2001:da8:8007:3c0:-<BR>-8190:ba8:ca78:6726</span><BR>
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
	<area shape="rect" coords="28,307,186,434" href="http://localhost:8080/PhysicalMachine.jsp?hostId=1">
	<area shape="rect" coords="238,309,407,436" href="http://localhost:8080/PhysicalMachine.jsp?hostId=2">
</map>
<!-- End ImageReady Slices -->
</body>
</html>