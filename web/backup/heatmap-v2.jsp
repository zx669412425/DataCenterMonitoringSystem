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
   </select>

   </div>
        <div id="container1" style="height: 90%"></div>
        <div id="container2" style="height: 90%"></div>
        <div id="container3" style="height: 90%"></div>
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

       $("select").on("change",function(){

           var index = this.selectedIndex;//获取选中option的脚标,$(this).prop("selectedIndex")亦可
           var hostid;
           console.log(index);
           if(index==0){
               document.getElementById("container1").style.display="inline";
               document.getElementById("container2").style.display="none";
               document.getElementById("container3").style.display="none";
               hostid=1;
           }
           else if(index==1){
               document.getElementById("container1").style.display="none";
               document.getElementById("container2").style.display="inline";
               document.getElementById("container3").style.display="none";
               hostid=2;
           }
           else if(index==2){
               document.getElementById("container1").style.display="none";
               document.getElementById("container2").style.display="none";
               document.getElementById("container3").style.display="inline";
               hostid=3;
           }
           //var option = this.options[index ];//获取选中项
           //console.log(option);
           //var number = $(option).attr("num");
           //console.log(number);

       });
       /**/
       $(document).ready(function(){
            var data2;
            var data3;
            var data4;
           testRequestBody1();
           paint1();
           testRequestBody2();
           paint2();

           document.getElementById("container1").style.display="inline";
           document.getElementById("container2").style.display="none";
          // testRequestBody3();
          // paint3();

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

       //  一天的数据，每五分钟取一个点 ，纵坐标24台虚拟机，横坐标288个时间点
       function testRequestBody1(){
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
                       // a = data1.slice(0,10);
                       // b = data1.slice(10,20);
                       // c = data1.slice(20,30);
                       // d = data1.slice(30,40);
                       return data2;
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

       //  一周的数据，每个小时取一个点，纵坐标24台虚拟机，横坐标168个时间点
       function testRequestBody2(){
           $.ajax("${pageContext.request.contextPath}/json/HSRequestweek",// 发送请求的URL字符串。

               {
                   dataType : "json", // 预期服务器返回的数据类型。
                   type : "post", //  请求方式 POST或GET
                   contentType:"application/json", //  发送信息至服务器时的内容编码类型
                   // 发送到服务器的数据。
                   async:  false , // 默认设置下，所有请求均为异步请求。如果设置为false，则发送同步请求
                   // 请求成功后的回调函数。
                   success :function(data1){
                       console.log(data1);
                       data3= data1;
                       // a = data1.slice(0,10);
                       // b = data1.slice(10,20);
                       // c = data1.slice(20,30);
                       // d = data1.slice(30,40);
                       return data3;
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

       //  一月的数据，每天取一个点，纵坐标24台虚拟机，横坐标168个时间点
       function testRequestBody3(){
           $.ajax("${pageContext.request.contextPath}/json/HSRequestmonth",// 发送请求的URL字符串。

               {
                   dataType : "json", // 预期服务器返回的数据类型。
                   type : "post", //  请求方式 POST或GET
                   contentType:"application/json", //  发送信息至服务器时的内容编码类型
                   // 发送到服务器的数据。
                   async:  false , // 默认设置下，所有请求均为异步请求。如果设置为false，则发送同步请求
                   // 请求成功后的回调函数。
                   success :function(data1){
                       console.log(data1);
                       data4= data1;
                       // a = data1.slice(0,10);
                       // b = data1.slice(10,20);
                       // c = data1.slice(20,30);
                       // d = data1.slice(30,40);
                       return data4;
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


       function paint1(){

           var dom = document.getElementById("container1");
           var myChart = echarts.init(dom);
           var app = {};
           option = null;
           app.title = '笛卡尔坐标系上的热力图';

               var hours = new Array(288);
               for(var i=0;i<hours.length;i++){
                   hours[i] = (i/12).toFixed(0);
               }

           var days =  ['pvs02','Backup2012','openfile','Backup2016','NAS1','pvs2.ecustdei302.com',
           'testtemp','windows7 (1)','Windows Server 2008','testcpu','testcpu1','hchen-stu01','cheng-stu-test01.52',
           'it01','cheng-zabbix','cheng-ubuntu.56','cheng-ubuntu02','hcheng_web_tomcat.59','cheng-stu-01_20.51,57',
           'cheng-stu-03.53\t0.146','cheng-centos6.6.55','hchstusvr-01.ecustdei.com','cheng-centos6.6.55','hchstusvr-01.ecustdei.com']

           console.log(data2);
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
                   max: 100,
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

       function paint2(){

           var dom = document.getElementById("container2");
           var myChart = echarts.init(dom);
           var app = {};
           option = null;
           app.title = '笛卡尔坐标系上的热力图';

           var hours = new Array(168);
           for(i=0;i<7;i++)
           {
               for(j=0;j<24;j++)
               {
                   hours[i*24+j]=i+1;
               }
           }
           console.log(hours);
           /*
           for(var i=0;i<hours.length;i++){
               hours[i] = (i/12).toFixed(0);
           }
            */
           var days =  ['pvs02','Backup2012','openfile','Backup2016','NAS1','pvs2.ecustdei302.com',
               'testtemp','windows7 (1)','Windows Server 2008','testcpu','testcpu1','hchen-stu01','cheng-stu-test01.52',
               'it01','cheng-zabbix','cheng-ubuntu.56','cheng-ubuntu02','hcheng_web_tomcat.59','cheng-stu-01_20.51,57',
               'cheng-stu-03.53\t0.146','cheng-centos6.6.55','hchstusvr-01.ecustdei.com','cheng-centos6.6.55','hchstusvr-01.ecustdei.com']

           console.log(data3);
           var data = data3;
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
                   max: 100,
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

       function paint3(){

           var dom = document.getElementById("container3");
           var myChart = echarts.init(dom);
           var app = {};
           option = null;
           app.title = '笛卡尔坐标系上的热力图';

           var hours = new Array(288);
           for(var i=0;i<hours.length;i++){
               hours[i] = (i/12).toFixed(0);
           }

           var days =  ['pvs02','Backup2012','openfile','Backup2016','NAS1','pvs2.ecustdei302.com',
               'testtemp','windows7 (1)','Windows Server 2008','testcpu','testcpu1','hchen-stu01','cheng-stu-test01.52',
               'it01','cheng-zabbix','cheng-ubuntu.56','cheng-ubuntu02','hcheng_web_tomcat.59','cheng-stu-01_20.51,57',
               'cheng-stu-03.53\t0.146','cheng-centos6.6.55','hchstusvr-01.ecustdei.com','cheng-centos6.6.55','hchstusvr-01.ecustdei.com']

           console.log(data4);
           var data = data4;
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
                   max: 100,
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