<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="org.fkit.controller.Get24" 
    import="java.util.List"  %>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>主界面</title>
	<%-- Bootstrap Styles--%>
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
     <%-- FontAwesome Styles--%>
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
        <%-- Custom Styles--%>
    <link href="assets/css/custom-styles.css" rel="stylesheet" />
     <%-- Google Fonts--%>
   <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
</head>



<body>

<div id="wrapper">
         
        <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">
				     <li>
					    <a href="#"><i class="fa fa-sitemap"></i> 主界面</a>
					 </li>
                    <li>
					   
                        <a href="PhysicalMachine.jsp?hostId=1"><i class="fa fa-sitemap"></i> 物理机</a>
                        <a href="VirtualMachine.jsp?vmId=1"><i class="fa fa-sitemap"></i> 虚拟机</a>
                        <a href="Load.jsp"><i class="fa fa-sitemap"></i> 负载详情</a>
                        <a href="heatmap.jsp" target="_blank"><i class="fa fa-sitemap"></i> 负载热力图</a>
                        <a href="globalpowerbyhost.jsp" target="_blank"><i class="fa fa-sitemap"></i> 负载损耗分布</a>

                    </li>
                </ul>

            </div>

        </nav> -->
        <!-- /. NAV SIDE  -->
        <div id="page-wrapper" >
            <div id="page-inner">
			 <div class="row">
                    <div class="col-md-12">
                        <h1 class="page-header">
                            
                        </h1>
                    </div>
                </div> 
                 <!-- /. ROW  -->
				<!--<a href="#"><img src="b2.png" width="700" height="300" ismap="ismap"></a>-->
				 <img src="b2.png" width="700" height="300" usemap="#testmap" alt="test" ismap="ismap"/>
                    <map name="testmap" id="testmap">
                         <area shape="rect " coords="211,21,247,82" href ="PhysicalMachine.jsp?hostId=1" alt="test1" />
                         <area shape="rect" coords="480,24,516,82" href ="PhysicalMachine.jsp?hostId=2" alt="test2" />
                         <area shape="rect" coords="342,218,375,277" href ="PhysicalMachine.jsp?hostId=1" alt="test3" />
                     </map> 
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
      <!-- Custom Js -->
    <script src="assets/js/custom-scripts.js"></script>
</body>
</html>