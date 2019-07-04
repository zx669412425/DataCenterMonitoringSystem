<!DOCTYPE html>
<html style="height: 100%">
   <head>
       <meta charset="utf-8">
       <title>系统状态监测</title>
       <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

       <script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>
       <script type="text/javascript" src="js/json2.js"></script>
   </head>

   <body style="height: 100%; margin: 0">
   <div>
      <table>
       <tr>
           <td height="10" valign="center" >虚拟机CPU不同时间段使用频繁度分布图</td>
       </tr>
      </table>
   </div>

   <div class="panel-heading">
       请选择数据 <select id="select">
       <option id="netUsage" value="netUsage">一天的频繁度</option>
       <option id="cpuUsage" value="cpuUsage">一个星期的频繁度</option>
       <option id="memoryUsage" value="memoryUsage">一月的频繁度</option>
   </select>

   </div>
       <div id="container" style="height: 90%"></div>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/echarts.min.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-gl/echarts-gl.min.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-stat/ecStat.min.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/dataTool.min.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/china.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/world.js"></script>
       <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=ZUONbpqGBsYGXNIYHicvbAbM"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>



   </body>

   <script type="text/javascript">

       $(document).ready(function(){
            var data2;
           testRequestBody();
           paint();

       });
       window.onload = function() {
           document.getElementById('select').addEventListener('change',function() {
               if (this.value == netUsage) {
                   $("#testhtml").html("当前温度：");
               }
           }, true);
       }
   </script>

   <script type="text/javascript">

       function testRequestBody(){
           $.ajax("${pageContext.request.contextPath}/json/HSRequest",// 发送请求的URL字符串。

               {
                   dataType : "json", // 预期服务器返回的数据类型。
                   type : "post", //  请求方式 POST或GET
                   contentType:"application/json", //  发送信息至服务器时的内容编码类型
                   // 发送到服务器的数据。
                   async:  false , // 默认设置下，所有请求均为异步请求。如果设置为false，则发送同步请求
                   // 请求成功后的回调函数。
                   success :function(data1){
                     console.log(data1);
                       data2= data1;
                       a = data1.slice(0,10);
                       b = data1.slice(10,20);
                       c = data1.slice(20,30);
                       d = data1.slice(30,40);
                       return b;
                       /*
                       $("#id").html(data1[0].id);
                       $("#name").html(data1[0].name);
                       $("#author").html(data1[0].author);*/
                   },
                   // 请求出错时调用的函数
                   error:function(){
                       alert("数据发送失败");
                   }
               });
       }

       function paint(){

           var dom = document.getElementById("container");
           var myChart = echarts.init(dom);
           var app = {};
           option = null;
           app.title = '笛卡尔坐标系上的热力图';


           /*
           var hours = ['12a', '1a', '2a', '3a', '4a', '5a', '6a',
               '7a', '8a', '9a','10a','11a',
               '12p', '1p', '2p', '3p', '4p', '5p',
               '6p', '7p', '8p', '9p', '10p', '11p'];
           var days = ['Saturday', 'Friday', 'Thursday',
               'Wednesday', 'Tuesday', 'Monday', 'Sunday'];
           */


               var hours = new Array(288);
               for(var i=0;i<hours.length;i++){
                   hours[i] = (i/12).toFixed(0);
               }
           var days = new Array(16);
           for(var i=0;i<days.length;i++){
               days[i] = i+1;
           }
           var days = ['pvs02', 'Backup2012', 'openfile', 'Backup2016', 'NAS1', 'pvs2.ecustdei302.com', 'testtemp','windows7 ','Windows Server 2008','testcpu','testcpu1','hchen-stu01','cheng-stu-test01.52','it01','cheng-zabbix','cheng-ubuntu.56','cheng-ubuntu02','hcheng_web_tomcat.59','cheng-spark -20.70','cheng-spark-centos-20.71','cheng-stu-01_20.51,57','cheng-stu-03.53','cheng-centos6.6.55','hchstusvr-01'];
           /*
                      var data = new Array(4608);
                      for(var i=0;i<data.length;i++){
                          data[i] =new Array(3);
                          data[i][0] = data1[i][0];
                          data[i][1] = data1[i][1];
                          data[i][2] = data1[i][2];
                      }
           //var data =data2.slice(0,100);
           data[11]=[12,210,.811231231231231231234124124];
           data[12]=[13,210,.8112312312312312321321231231];
           data[13]=[12,210,11.81124312312345346456234121];*/

           console.log(data2);
           //data=[[0,0,0.5],[0,1,.81],[0,2,.70],[0,3,.60],[0,4,.50],[0,5,.40],[0,6,.30],[0,7,.20],[0,8,.10]];
           //var data = [[0,0,5],[0,1,1],[0,2,0],[0,3,0],[0,4,0],[0,5,0],[0,6,0],[0,7,0],[0,8,0],[0,9,0],[0,10,0],[0,11,2],[0,12,4],[0,13,1],[0,14,1],[0,15,3],[0,16,4],[0,17,6],[0,18,4],[0,19,4],[0,20,3],[0,21,3],[0,22,2],[0,23,5],[1,0,7],[1,1,0],[1,2,0],[1,3,0],[1,4,0],[1,5,0],[1,6,0],[1,7,0],[1,8,0],[1,9,0],[1,10,5],[1,11,2],[1,12,2],[1,13,6],[1,14,9],[1,15,11],[1,16,6],[1,17,7],[1,18,8],[1,19,12],[1,20,5],[1,21,5],[1,22,7],[1,23,2],[2,0,1],[2,1,1],[2,2,0],[2,3,0],[2,4,0],[2,5,0],[2,6,0],[2,7,0],[2,8,0],[2,9,0],[2,10,3],[2,11,2],[2,12,1],[2,13,9],[2,14,8],[2,15,10],[2,16,6],[2,17,5],[2,18,5],[2,19,5],[2,20,7],[2,21,4],[2,22,2],[2,23,4],[3,0,7],[3,1,3],[3,2,0],[3,3,0],[3,4,0],[3,5,0],[3,6,0],[3,7,0],[3,8,1],[3,9,0],[3,10,5],[3,11,4],[3,12,7],[3,13,14],[3,14,13],[3,15,12],[3,16,9],[3,17,5],[3,18,5],[3,19,10],[3,20,6],[3,21,4],[3,22,4],[3,23,1],[4,0,1],[4,1,3],[4,2,0],[4,3,0],[4,4,0],[4,5,1],[4,6,0],[4,7,0],[4,8,0],[4,9,2],[4,10,4],[4,11,4],[4,12,2],[4,13,4],[4,14,4],[4,15,14],[4,16,12],[4,17,1],[4,18,8],[4,19,5],[4,20,3],[4,21,7],[4,22,3],[4,23,0],[5,0,2],[5,1,1],[5,2,0],[5,3,3],[5,4,0],[5,5,0],[5,6,0],[5,7,0],[5,8,2],[5,9,0],[5,10,4],[5,11,1],[5,12,5],[5,13,10],[5,14,5],[5,15,7],[5,16,11],[5,17,6],[5,18,0],[5,19,5],[5,20,3],[5,21,4],[5,22,2],[5,23,0],[6,0,1],[6,1,0],[6,2,0],[6,3,0],[6,4,0],[6,5,0],[6,6,0],[6,7,0],[6,8,0],[6,9,0],[6,10,1],[6,11,0],[6,12,2],[6,13,1],[6,14,3],[6,15,4],[6,16,0],[6,17,0],[6,18,0],[6,19,0],[6,20,1],[6,21,2],[6,22,2],[6,23,6]];
           var data = data2;
               data = data.map(function (item) {
               return [item[1], item[0], item[2] || '-'];
           });

           option = {
               tooltip: {
                   position: 'top'
               },
               animation: false,
               grid: {
                   height: '50%',
                   y: '10%'
               },
               xAxis: {
                   type: 'category',
                   data: hours,
                   axisLabel :{interval: 12},
                   splitArea: {
                       show: true
                   }
               },
               yAxis: {
                   type: 'category',
                   data: days,
                   splitArea: {
                       show: true
                   }
               },
               visualMap: {

                   min: 0,
                   max: 1,
                   calculable: true,
                   orient: 'horizontal',
                   left: 'center',
                   bottom: '15%'
               },
               series: [{
                   name: 'Punch Card',
                   type: 'heatmap',
                   data: data,
                   label: {
                       normal: {
                           show: false
                       }
                   },
                   itemStyle: {
                       emphasis: {
                           shadowBlur: 10,
                           shadowColor: 'rgba(0, 0, 0, 0.5)'
                       }
                   }
               }]
           };
           if (option && typeof option === "object") {
               myChart.setOption(option, true);
           }
       }
   </script>

</html>