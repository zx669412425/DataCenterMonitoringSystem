<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="js/json2.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/echarts.min.js"></script>


<html>
<head>
    <title>index</title>
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
                    <a href="index.jsp"><i class="fa fa-sitemap"></i> 主界面</a>
                </li>
                <li>
                    <a href="" onclick="display(event)"><i class="fa fa-sitemap"></i> 物理机</a>
                    <a href="PhysicalMachine.jsp?hostId=1"  id="host1" style="display:none;margin-left:50px;"><i class="fa fa-sitemap" ></i> 服务器1</a>
                    <a href="PhysicalMachine.jsp?hostId=2"  id="host2" style="display:none;margin-left:50px;"><i class="fa fa-sitemap" ></i> 服务器2</a>
                    <a href="VirtualMachine.jsp?vmId=1"><i class="fa fa-sitemap"></i> 虚拟机</a>
                    <a href="Load.jsp?"><i class="fa fa-sitemap"></i> 负载详情</a>
                    <a href="#"><i class="fa fa-sitemap"></i> 负载热力图</a>
                    <a href="globalpowerbyhost.jsp"><i class="fa fa-sitemap"></i> 负载损耗分布</a>

                </li>
            </ul>

        </div>

    </nav>
    <!-- /. NAV SIDE  -->
    <div id="page-wrapper">

        <div>
            <table>
                <tr>
                    <td height="10" valign="center" >虚拟机CPU不同时间段使用频繁度分布图</td>
                </tr>
            </table>
        </div>

        请选择 host主机:
        <form id="form1" name="form1" method="post" action="">
            <label>
                <select name="select">
                    <option value="host1">host1</option>
                    <option value="host2">host2</option>
                    <option value="host3">host3</option>
                </select>
            </label>
        </form>
        <div id="container1" style="height: 100%"></div>
        <div id="container2" style="height: 100%"></div>
        <div id="container3" style="height: 100%"></div>
        <div id="pageno">
            <%
                String dayinterval=request.getParameter("dayno");
                int curday = 0;
                int dayinc=0,daydec=0;
                if(dayinterval!=null){
                    curday= Integer.parseInt(dayinterval);
                }
                dayinc = curday + 1;
                daydec = curday - 1;
                if(daydec < 0) daydec = 0;
                //out.println("接收到:"+dayinterval+"当天是第几天："+curday);


            %>
            <table>
                <tr>
                    <td><a href="globalpowerbyhost.jsp?dayno=<%=dayinc%>">前一天</a></td>
                    <td><a href="globalpowerbyhost.jsp?dayno=<%=daydec%>">后一天</a></td>
                    <!--<td>数据与当天间隔：<%=curday%>天</td>-->
                    <td>数据日期：<script>
                        var now = new Date();now.setDate(now.getDate()-<%=curday%>);

                        document.write(now.getFullYear()+"年"+(now.getMonth() + 1)+"月"+now.getDate()+"日");
                    </script></td>
                </tr>
            </table>
        </div>

        <script>

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


            $(document).ready(function(){
                painthost1(<%=curday%>);
                document.getElementById("container1").style.display="inline";
                painthost2(<%=curday%>);
                document.getElementById("container2").style.display="none";
                painthost3(<%=curday%>);
                document.getElementById("container3").style.display="none";
            });
            function getglobalpower(id,interval){
                $.ajax({
                    type: 'get',
                    url: "${pageContext.request.contextPath}/json/get_1day_power_byid",
                    data: "id="+id +"&interval="+interval,
                    async : false,
                    success: function(data){
                        //console.log(data+"afadsfasdfsdf");
                        globalpower=data;
                    },
                    dataType: "json"
                });
                return globalpower;
            }

            function painthost1(interval)
            {
                var globalpower =getglobalpower("1",interval);
                console.log(globalpower);


                var dom = document.getElementById("container1");
                var myChart = echarts.init(dom);
                var app = {};
                option = null;
                app.title = '柱状图框选';

                var xAxisData = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23];
                data1=globalpower[0];
                data2=globalpower[1];
                data3=globalpower[2];
                data4=globalpower[3];
                data5=globalpower[4];
                data6=globalpower[5];
                data7=globalpower[6];
                var data8 = [];
                temp = globalpower[7];
                data8[1] = Number(data1[4])+Number(temp[5]);
                console.log("这里是主机1的消耗数组"+data8[1]+"a"+data1[4]+"b"+temp[5]);

                for(i=0;i<24;i++)
                {
                    data8[i]=Number(data1[i])+Number(data2[i])+Number(data3[i])+Number(data4[i])+Number(data5[i])+Number(data6[i])+Number(data7[i])-Number(temp[i]);
                }
                console.log("这里是主机1的消耗数组"+data8);
                var itemStyle = {
                    normal: {
                    },
                    emphasis: {
                        barBorderWidth: 1,
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowOffsetY: 0,
                        shadowColor: 'rgba(0,0,0,0.5)'
                    }
                };

                option = {
                    backgroundColor: '#eee',
                    legend: {
                        data: ['pvs02', 'Backup2012', 'openfile', 'Backup2016', 'NAS1', 'pvs2', 'testtemp', '主机损耗'],
                        align: 'left',
                        left: 10
                    },
                    brush: {
                        toolbox: ['rect', 'polygon', 'lineX', 'lineY', 'keep', 'clear'],
                        xAxisIndex: 0
                    },
                    toolbox: {
                        feature: {
                            magicType: {
                                type: ['stack', 'tiled']
                            },
                            dataView: {}
                        }
                    },
                    tooltip: {},
                    xAxis: {
                        data: xAxisData,
                        name: 'X Axis',
                        silent: false,
                        axisLine: {onZero: true},
                        splitLine: {show: false},
                        splitArea: {show: false}
                    },
                    yAxis: {
                        inverse: true,
                        splitArea: {show: false}
                    },
                    grid: {
                        left: 100
                    },
                    visualMap: {
                        type: 'continuous',
                        dimension: 1,
                        text: ['High', 'Low'],
                        inverse: true,
                        itemHeight: 200,
                        calculable: true,
                        min: -2,
                        max: 6,
                        top: 60,
                        left: 10,
                        inRange: {
                            colorLightness: [0.4, 0.8]
                        },
                        outOfRange: {
                            color: '#bbb'
                        },
                        controller: {
                            inRange: {
                                color: '#2f4554'
                            }
                        }
                    },
                    series: [
                        {
                            name: 'pvs02',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data1
                        },
                        {
                            name: 'Backup2012',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data2
                        },
                        {
                            name: 'openfile',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data3
                        },
                        {
                            name: 'Backup2016',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data4
                        },
                        {
                            name: 'NAS1',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data5
                        },
                        {
                            name: 'pvs2',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data6
                        },
                        {
                            name: 'testtemp',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data7
                        },
                        {
                            name: '主机损耗',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data8
                        }
                    ]
                };

                myChart.on('brushSelected', renderBrushed);

                if (option && typeof option === "object") {
                    myChart.setOption(option, true);
                }
            }

            function painthost2(interval)
            {
                var globalpower =getglobalpower("2",interval);
                console.log(globalpower);


                var dom = document.getElementById("container2");
                var myChart = echarts.init(dom);
                var app = {};
                option = null;
                app.title = '柱状图框选';

                var xAxisData = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23];
                data1=globalpower[0];
                data2=globalpower[1];
                data3=globalpower[2];
                data4=globalpower[3];
                var data5 = [];
                temp = globalpower[4];
                for(i=0;i<24;i++)
                {
                    data5[i]=Number(data1[i])+Number(data2[i])+Number(data3[i])+Number(data4[i])-Number(temp[i]);
                }
                console.log("这里是主机2的消耗数组"+data5);
                var itemStyle = {
                    normal: {
                    },
                    emphasis: {
                        barBorderWidth: 1,
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowOffsetY: 0,
                        shadowColor: 'rgba(0,0,0,0.5)'
                    }
                };

                option = {
                    backgroundColor: '#eee',
                    legend: {
                        data: ['windows7', 'Windows Server 2008', 'testcpu', 'testcpu1', '主机损耗'],
                        align: 'left',
                        left: 10
                    },
                    brush: {
                        toolbox: ['rect', 'polygon', 'lineX', 'lineY', 'keep', 'clear'],
                        xAxisIndex: 0
                    },
                    toolbox: {
                        feature: {
                            magicType: {
                                type: ['stack', 'tiled']
                            },
                            dataView: {}
                        }
                    },
                    tooltip: {},
                    xAxis: {
                        data: xAxisData,
                        name: 'X Axis',
                        silent: false,
                        axisLine: {onZero: true},
                        splitLine: {show: false},
                        splitArea: {show: false}
                    },
                    yAxis: {
                        inverse: true,
                        splitArea: {show: false}
                    },
                    grid: {
                        left: 100
                    },
                    visualMap: {
                        type: 'continuous',
                        dimension: 1,
                        text: ['High', 'Low'],
                        inverse: true,
                        itemHeight: 200,
                        calculable: true,
                        min: -2,
                        max: 6,
                        top: 60,
                        left: 10,
                        inRange: {
                            colorLightness: [0.4, 0.8]
                        },
                        outOfRange: {
                            color: '#bbb'
                        },
                        controller: {
                            inRange: {
                                color: '#2f4554'
                            }
                        }
                    },
                    series: [
                        {
                            name: 'windows7',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data1
                        },
                        {
                            name: 'Windows Server 2008',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data2
                        },
                        {
                            name: 'testcpu',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data3
                        },
                        {
                            name: 'testcpu1',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data4
                        },
                        {
                            name: '主机损耗',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data5
                        }
                    ]
                };

                myChart.on('brushSelected', renderBrushed);

                if (option && typeof option === "object") {
                    myChart.setOption(option, true);
                }
            }

            function painthost3(interval)
            {
                var globalpower =getglobalpower("3",interval);
                console.log(globalpower);


                var dom = document.getElementById("container3");
                var myChart = echarts.init(dom);
                var app = {};
                option = null;
                app.title = '柱状图框选';

                var xAxisData = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23];
                data1=globalpower[0];
                data2=globalpower[1];
                data3=globalpower[2];
                data4=globalpower[3];
                data5=globalpower[4];
                data6=globalpower[5];
                data7=globalpower[6];
                data8=globalpower[7];
                data9=globalpower[8];
                data10=globalpower[9];
                data11=globalpower[10];
                data12=globalpower[11];
                data13=globalpower[12];
                var data14 = [];
                temp = globalpower[13];
                for(i=0;i<24;i++)
                {
                    data14[i]=Number(data1[i])+Number(data2[i])+Number(data3[i])+Number(data4[i])+Number(data5[i])+Number(data6[i])+Number(data7[i])+Number(data8[i])+Number(data9[i])+Number(data10[i])+Number(data11[i])+Number(data12[i])+Number(data13[i])-Number(temp[i]);

                }
                console.log("这里是主机3的消耗数组"+data14);
                var itemStyle = {
                    normal: {
                    },
                    emphasis: {
                        barBorderWidth: 1,
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowOffsetY: 0,
                        shadowColor: 'rgba(0,0,0,0.5)'
                    }
                };

                option = {
                    backgroundColor: '#eee',
                    legend: {
                        data: ['hchen-stu01', 'cheng-stu-test01.52', 'it01', 'cheng-zabbix', 'cheng-ubuntu.56', 'cheng-ubuntu02', 'hcheng_web_tomcat.59', 'cheng-stu-01_20.51,57','cheng-stu-03.53','cheng-centos','hchstusvr','cheng-centos6.6.55','hchstusvr','主机损耗'],
                        align: 'left',
                        left: 10
                    },
                    brush: {
                        toolbox: ['rect', 'polygon', 'lineX', 'lineY', 'keep', 'clear'],
                        xAxisIndex: 0
                    },
                    toolbox: {
                        feature: {
                            magicType: {
                                type: ['stack', 'tiled']
                            },
                            dataView: {}
                        }
                    },
                    tooltip: {},
                    xAxis: {
                        data: xAxisData,
                        name: 'X Axis',
                        silent: false,
                        axisLine: {onZero: true},
                        splitLine: {show: false},
                        splitArea: {show: false}
                    },
                    yAxis: {
                        inverse: true,
                        splitArea: {show: false}
                    },
                    grid: {
                        left: 100
                    },
                    visualMap: {
                        type: 'continuous',
                        dimension: 1,
                        text: ['High', 'Low'],
                        inverse: true,
                        itemHeight: 200,
                        calculable: true,
                        min: -2,
                        max: 6,
                        top: 60,
                        left: 10,
                        inRange: {
                            colorLightness: [0.4, 0.8]
                        },
                        outOfRange: {
                            color: '#bbb'
                        },
                        controller: {
                            inRange: {
                                color: '#2f4554'
                            }
                        }
                    },
                    series: [
                        {
                            name: 'hchen-stu01',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data1
                        },
                        {
                            name: 'cheng-stu-test01.52',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data2
                        },
                        {
                            name: 'it01',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data3
                        },
                        {
                            name: 'cheng-zabbix',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data4
                        },
                        {
                            name: 'cheng-ubuntu.56',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data5
                        },
                        {
                            name: 'cheng-ubuntu02',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data6
                        },
                        {
                            name: 'hcheng_web_tomcat.59',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data7
                        },
                        {
                            name: 'cheng-stu-01_20.51,57',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data8
                        },
                        {
                            name: 'cheng-stu-03.53',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data9
                        },
                        {
                            name: 'cheng-centos',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data10
                        },
                        {
                            name: 'hchstusvr',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data11
                        },
                        {
                            name: 'cheng-centos6.6.55',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data12
                        },

                        {
                            name: 'hchstusvr',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data13
                        },
                        {
                            name: '主机损耗',
                            type: 'bar',
                            stack: 'one',
                            itemStyle: itemStyle,
                            data: data14
                        }
                    ]
                };

                myChart.on('brushSelected', renderBrushed);

                if (option && typeof option === "object") {
                    myChart.setOption(option, true);
                }
            }

            function renderBrushed(params) {
                var brushed = [];
                var brushComponent = params.batch[0];

                for (var sIdx = 0; sIdx < brushComponent.selected.length; sIdx++) {
                    var rawIndices = brushComponent.selected[sIdx].dataIndex;
                    brushed.push('[Series ' + sIdx + '] ' + rawIndices.join(', '));
                }

                myChart.setOption({
                    title: {
                        backgroundColor: '#333',
                        text: 'SELECTED DATA INDICES: \n' + brushed.join('\n'),
                        bottom: 0,
                        right: 0,
                        width: 100,
                        textStyle: {
                            fontSize: 12,
                            color: '#fff'
                        }
                    }
                });
            };

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

        <!-- /. PAGE INNER  -->
    </div>
    <!-- /. PAGE WRAPPER  -->
</div>



</body>
</html>