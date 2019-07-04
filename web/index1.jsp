<%--
  Created by IntelliJ IDEA.
  User: wanhao
  Date: 2018/7/6
  Time: 16:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="assets/js/jquery-3.3.1.min.js"></script>
<html>
  <head>
    <title>$Title$</title>
  </head>
  <script>
      $(document).ready(function(){

          var power = getpowertochen();       //pdu电源耗能
          var temprature = gettemptochen();   //温度计温度，目前3台
          var host = gethotstochen();         //主机的参数，两台主机：host1，host2，包含内容CpuUsage，CpuUsage，MemoryUsage
          var vm = getvmtochen();             //虚拟的参数，三台：vm1，vm2，vm3，其实一共有24台，我只列举了3台，包含内容CpuUsage，CpuUsage，MemoryUsage
          $("#power_current").html("当前power："+power[0]);
          $("#power_forecast").html("预测power："+power[1]);
          $("#temp1").html("温度1："+temprature[0]);
          $("#temp2").html("温度2："+temprature[1]);
          $("#temp3").html("温度3："+temprature[2]);
          $("#host1").html("host1 CpuUsage："+host[0]+",NetUsage"+host[1]+",MemoryUsage"+host[2]);
          $("#host2").html("host2 CpuUsage："+host[3]+",NetUsage"+host[4]+",MemoryUsage"+host[5]);
          $("#vm1").html("vm1 CpuUsage："+vm[0]+",NetUsage"+vm[1]+",MemoryUsage"+vm[2]);
          $("#vm2").html("vm2 CpuUsage："+vm[3]+",NetUsage"+vm[4]+",MemoryUsage"+vm[5]);
          $("#vm3").html("vm3 CpuUsage："+vm[6]+",NetUsage"+vm[7]+",MemoryUsage"+vm[8]);
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
      function getvmtochen(){
          $.ajax({
              type: 'get',
              url: "${pageContext.request.contextPath}/json/getvmtochen",
              data: "id=",
              async : false,
              success: function(data){
//  			  console.log('id 2 '+data);
                  vm=data;
              },
              dataType: "json"
          });
          return vm;
      }
  </script>
  <body>
  <table border="1">
    <tr>
      <td><span id="power_current"></span></td>
    </tr>
    <tr>
      <td><span id="power_forecast"></span></td>
    </tr>
    <tr>
      <td><span id="temp1"></span></td>
    </tr>
      <td><span id="temp2"></span></td>
    </tr>
    <td><span id="temp3"></span></td>
    </tr>
    <tr>
      <td><span id="host1"></span></td>
    </tr>
    <tr>
    <td><span id="host2"></span></td>
  </tr>
    <tr>
      <td><span id="vm1"></span></td>
    </tr>
    <tr>
      <td><span id="vm2"></span></td>
    </tr>
    <tr>
      <td><span id="vm3"></span></td>
    </tr>

  </table>
  </body>
</html>
