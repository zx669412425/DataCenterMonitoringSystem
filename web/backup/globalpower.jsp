<%--
  Created by IntelliJ IDEA.
  User: wanhao
  Date: 2018/7/8
  Time: 8:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="assets/js/jquery-3.3.1.min.js"></script>
<html>
<head>
    <title>Title</title>
</head>

<body>
<div id="container" style="height: 100%"></div>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/echarts.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-gl/echarts-gl.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-stat/ecStat.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/dataTool.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/china.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/world.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=ZUONbpqGBsYGXNIYHicvbAbM"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
power_current<span id="power_current"></span>
globalpower<span id="globalpower"></span>


<script>
    $(document).ready(function(){

        // var powerbyid = getpowerbyid("23","21");       //pdu电源耗能
        //console.log(powerbyid);
        // $("#power_current").html("当前power："+powerbyid[0]);

        paint();
    });
    function getglobalpower(){
        $.ajax({
            type: 'get',
            url: "${pageContext.request.contextPath}/json/getglobalpower2",
            data: "id=",
            async : false,
            success: function(data){
                console.log(data);
                globalpower=data;
            },
            dataType: "json"
        });
        return globalpower;

    }
    function getpowerbyid(a,b){
        $.ajax({
            type: 'get',
            url: "${pageContext.request.contextPath}/json/getpowerbyid",
            data: "id="+a+"&count="+b ,
            async : false,
            success: function(data){
                console.log(data);
                power=data;
            },
            dataType: "json"
        });
        return power;
    }

    function paint()
    {
        var globalpower =getglobalpower();
        console.log(globalpower);


        var dom = document.getElementById("container");
        var myChart = echarts.init(dom);
        var app = {};
        option = null;
        app.title = '柱状图框选';

        var xAxisData = [];
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
        data14=globalpower[13];
        data15=globalpower[14];
        data16=globalpower[15];
        data17=globalpower[16];
        data18=globalpower[17];
        data19=globalpower[18];
        data20=globalpower[19];
        data21=globalpower[20];
        data22=globalpower[21];
        data23=globalpower[22];
        data24=globalpower[23];
        var data25 = [];
        temp = globalpower[24];
        for(i=0;i<288;i++)
        {
            data25[i]=temp[i]-data1[i]-data2[i]-data3[i]-data4[i]-data5[i]-data6[i]-data7[i]-data8[i]-data9[i]-data10[i]-data11[i]-data12[i]-data13[i]-data14[i]-data15[i]-data16[i]-data17[i]-data18[i]-data19[i]-data20[i]-data21[i]-data22[i]-data23[i]-data24[i];
        }


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
                data: ['bar', 'bar2', 'bar3', 'bar4', 'bar5', 'bar6', 'bar7', 'bar8', 'bar9', 'bar10', 'bar11', 'bar12', 'bar13', 'bar14', 'bar15', 'bar16','bar17','bar18','bar19','bar20','bar21','bar22','bar23','bar24','bar25'],
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
                    name: 'bar',
                    type: 'bar',
                    stack: 'one',
                    itemStyle: itemStyle,
                    data: data1
                },
                {
                    name: 'bar2',
                    type: 'bar',
                    stack: 'one',
                    itemStyle: itemStyle,
                    data: data2
                },
                {
                    name: 'bar3',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data3
                },
                {
                    name: 'bar4',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data4
                },
                {
                    name: 'bar5',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data5
                },
                {
                    name: 'bar6',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data6
                },
                {
                    name: 'bar7',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data7
                },
                {
                    name: 'bar8',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data8
                },
                {
                    name: 'bar9',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data9
                },
                {
                    name: 'bar10',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data10
                },
                {
                    name: 'bar11',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data11
                },
                {
                    name: 'bar12',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data12
                },
                {
                    name: 'bar13',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data13
                },
                {
                    name: 'bar14',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data14
                },
                {
                    name: 'bar15',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data15
                },
                {
                    name: 'bar16',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data16
                },
                {
                    name: 'bar17',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data17
                },
                {
                    name: 'bar18',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data18
                },
                {
                    name: 'bar19',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data19
                },
                {
                    name: 'bar20',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data20
                },
                {
                    name: 'bar21',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data21
                },
                {
                    name: 'bar22',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data22
                },
                {
                    name: 'bar23',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data23
                },
                {
                    name: 'bar24',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data24
                },
                {
                    name: 'bar25',
                    type: 'bar',
                    stack: 'two',
                    itemStyle: itemStyle,
                    data: data25
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
</script>
</body>
</html>
