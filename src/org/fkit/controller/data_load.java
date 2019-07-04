package org.fkit.controller;

import org.fkit.domain.cur_Temperature;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class data_load {



    public static List getpower() {
        String sql = "select * from power order by Time desc limit 10";
        SqlBean db = new SqlBean();
        ResultSet rs = db.executeQuery(sql);
        List<String> p = new ArrayList();
        List<String> t = new ArrayList();
        String  powerstatic;
        String timestatic;
        String tst;

        try {
            while (rs.next()) {

                powerstatic = rs.getString("Power");
                p.add(powerstatic);
                timestatic = rs.getString("Time");
                tst= timestatic.substring(12,19);
                t.add(tst);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        p.addAll(t);

        return p;
    }

    public static List getcurtemp(){

        List<String> p3 = new ArrayList();
        List<String> p4 = new ArrayList();
        List<String> p5 = new ArrayList();
        List<String> time = new ArrayList();
        List<String> all = new ArrayList();
        String powerstatic;
        String timestatic;
        String tst;
        cur_Temperature cts = new cur_Temperature();

        SqlBean db = new SqlBean();

        String sql = "select * from (select * from temptcp where DeviceId = 3 order by Time desc limit 1000) h ORDER BY h.time asc";
        ResultSet rs = db.executeQuery(sql);
        try {
            while (rs.next()) {
                powerstatic = rs.getString("Temp");
                p3.add(powerstatic);
                timestatic = rs.getString("Time");
                tst= timestatic.substring(12,19);
                time.add(tst);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        sql = "select * from (select * from temptcp where DeviceId = 4 order by Time desc limit 1000) h ORDER BY h.time asc";
        rs = db.executeQuery(sql);
        try {
            while (rs.next()) {
                powerstatic = rs.getString("Temp");
                p4.add(powerstatic);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        sql = "select * from (select * from temptcp where DeviceId = 5 order by Time desc limit 1000) h ORDER BY h.time asc";
        rs = db.executeQuery(sql);
        try {
            while (rs.next()) {
                powerstatic = rs.getString("Temp");
                p5.add(powerstatic);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        all.addAll(time);
        all.addAll(p3);
        all.addAll(p4);
        all.addAll(p5);
    return all;
    }

    public static List getvirpower(){

        //List<VirMachine> p3 = new ArrayList<VirMachine>();
        List<double[]> p3 = new ArrayList<double[]>();


        String s_id,s_time,s_usage;
        SqlBean db = new SqlBean();
       //String sql = "select * ,floor(TIME_TO_SEC(STR_TO_DATE( b.time, '%H:%i' ))/300) as x from vm_dynamic b where id="+i+" order by Time desc limit 288";
            String sql = "select * ,floor(TIME_TO_SEC(STR_TO_DATE( time(b.time), '%H:%i' ))/300) as x from vm_dynamic b order by Time desc limit 6912";
            System.out.println(sql);
            ResultSet rs = db.executeQuery(sql);
            try {
                while (rs.next()) {
                    s_id = rs.getString("Id");

                    s_time = rs.getString("x");
                    s_usage = rs.getString("CpuUsage");

                    double[] t = new double[3];
                    t[0]= rs.getFloat("id")-1;
                    t[1]= rs.getFloat("x");
                    double f = rs.getFloat("CpuUsage");
                    BigDecimal   b   =   new BigDecimal(f);
                    double   f1   =   b.setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue();
                    t[2] = f1;
                    // VirMachine vm = new VirMachine();

                 //   vm.setId(s_id);
                 //   vm.setTime(s_time);
                 //   vm.setCpu(s_usage);
                    p3.add(t);

//                    p3.add(vm);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }


        return p3;
    }

    public static List getvirpowerbyweek(){

        List<double[]> p3 = new ArrayList<double[]>();


        String s_id,s_time,s_usage;
        SqlBean db = new SqlBean();
        //String sql = "select * ,floor(TIME_TO_SEC(STR_TO_DATE( time(b.time), '%H:%i' ))/300) as x from vm_dynamic b order by Time desc limit 4608";
        /*
         * select * ,floor(UNIX_TIMESTAMP(STR_TO_DATE(b.Time,'%Y-%m-%d %H:%i:%s'))/3600) as x ,date_format(time, '%Y-%m-%d %H') as y
         *from vm_dynamic b
         *where date(b.time) >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) and date(b.time) <= DATE_SUB(CURDATE(), INTERVAL 1 DAY)
         *GROUP BY Id,y
         *order by id ASC, time desc
         *limit 4032
         */
        String sql = "select Id,AVG(CpuUsage) as c,date_format(time, '%Y-%m-%d %H') as y from vm_dynamic b" +
                " where date(b.time) >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) and date(b.time) <= DATE_SUB(CURDATE(), INTERVAL 1 DAY)"+
                " GROUP BY Id,y order by id ASC, time desc limit 4032";
        System.out.println(sql);
        int tictac=167;
        ResultSet rs = db.executeQuery(sql);
        try {
            while (rs.next()) {
                if(tictac<0){tictac=167;}
                double[] t = new double[3];
                t[0]= rs.getFloat("id")-1;//纵坐标
                t[1]= tictac;//横坐标         rs.getFloat("x");
                double f = rs.getFloat("c");
                BigDecimal   b   =   new BigDecimal(f);
                double   f1   =   b.setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue();
                t[2] = f1;
                p3.add(t);
                tictac--;

//                    p3.add(vm);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }


        return p3;
    }

    public static List getvirpowerbymonth(){

        List<double[]> p3 = new ArrayList<double[]>();


        String s_id,s_time,s_usage;
        SqlBean db = new SqlBean();
        //String sql = "select * ,floor(TIME_TO_SEC(STR_TO_DATE( time(b.time), '%H:%i' ))/300) as x from vm_dynamic b order by Time desc limit 4608";
        /*
         * select * ,floor(UNIX_TIMESTAMP(STR_TO_DATE(b.Time,'%Y-%m-%d %H:%i:%s'))/3600) as x ,date_format(time, '%Y-%m-%d %H') as y
         *from vm_dynamic b
         *where date(b.time) >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) and date(b.time) <= DATE_SUB(CURDATE(), INTERVAL 1 DAY)
         *GROUP BY Id,y
         *order by id ASC, time desc
         *limit 4032
         */
        String sql = "select Id,AVG(CpuUsage) as c,date_format(time, '%Y-%m-%d %H') as y from vm_dynamic b" +
                " where date(b.time) >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) and date(b.time) <= DATE_SUB(CURDATE(), INTERVAL 1 DAY)"+
                " GROUP BY Id,y order by id ASC, time desc limit 4032";
        System.out.println(sql);
        int tictac=167;
        ResultSet rs = db.executeQuery(sql);
        try {
            while (rs.next()) {
                if(tictac<0){tictac=167;}
                double[] t = new double[3];
                t[0]= rs.getFloat("id")-1;//纵坐标
                t[1]= tictac;//横坐标         rs.getFloat("x");
                double f = rs.getFloat("c");
                BigDecimal   b   =   new BigDecimal(f);
                double   f1   =   b.setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue();
                t[2] = f1;
                p3.add(t);
                tictac--;

//                    p3.add(vm);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }


        return p3;
    }//未完成

    public static List Wget_power_of3(){
        List<double[]> p3 = new ArrayList<double[]>();

        SqlBean db = new SqlBean();
        String sql = "SELECT * from temptcp ORDER BY time limit 3";
        ResultSet rs = db.executeQuery(sql);
        try {
            while (rs.next()) {
                double[] t = new double[3];
                t[0]= rs.getFloat("DeviceId");
                t[1]= rs.getFloat("Temp");
            }
    } catch (SQLException e) {
        e.printStackTrace();
    }
        return p3;
    }

    public static List getpowertochen(){

        List<String> powerlist = new ArrayList();
        SqlBean db = new SqlBean();
        String power,time;
        String sql = "select * from power order by time desc limit 2";
        ResultSet rs = db.executeQuery(sql);

        try {
            while (rs.next()) {
                power = rs.getString("Power");
                powerlist.add(power);
                time =rs.getString("Time");
                System.out.println(time);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        sql = "select * from power_forecast order by time desc limit 2";
        rs = db.executeQuery(sql);
        try {
            while (rs.next()) {
                power = rs.getString("Power");
                powerlist.add(power);
                time =rs.getString("Time");
                System.out.println(time);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return powerlist;
    }

    public static List gettemptochen(){

        List<String> temperlist = new ArrayList();
        SqlBean db = new SqlBean();
        String temp,time;
        String sql = "select * from temptcp order by time desc limit 3";
        ResultSet rs = db.executeQuery(sql);

        try {
            while (rs.next()) {
                temp = rs.getString("Temp");
                temperlist.add(temp);
                time =rs.getString("Time");
                System.out.println(time);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return  temperlist;
    }

    public static List gethotstochen(){

        List<String> hostlist = new ArrayList();
        SqlBean db = new SqlBean();
        String cpu,net,memory;
        String sql = "select * from host_dynamic order by time desc limit 2";
        ResultSet rs = db.executeQuery(sql);

        try {
            while (rs.next()) {
                cpu = rs.getString("CpuUsage");
                hostlist.add(cpu);
                net =rs.getString("NetUsage");
                hostlist.add(net);
                memory =rs.getString("MemoryUsage");
                hostlist.add(memory);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return  hostlist;
    }

    public static List getvmtochen(){

        List<String> hostlist = new ArrayList();
        SqlBean db = new SqlBean();
        String cpu,net,memory;
        String sql = "select * from vm_dynamic where id >18 and id <22  order by Time desc limit 3";
        ResultSet rs = db.executeQuery(sql);

        try {
            while (rs.next()) {
                cpu = rs.getString("CpuUsage");
                hostlist.add(cpu);
                net =rs.getString("NetUsage");
                hostlist.add(net);
                memory =rs.getString("MemoryUsage");
                hostlist.add(memory);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return  hostlist;
    }

    public static List getpowerbyid(String i,String count)    {
        List<String> powerlist = new ArrayList();
        SqlBean db = new SqlBean();
        String power;
        String sql = "select * from vm_dynamic where id= "+i+" order by Time desc limit " + count;
        System.out.println(sql);
        ResultSet rs = db.executeQuery(sql);
        try {
            while (rs.next()) {
                power = rs.getString("Power");
                powerlist.add(power);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return  powerlist;
    }


    public static List gethostpowerbyid(String i,String count)    {
        List<String> powerlist = new ArrayList();
        SqlBean db = new SqlBean();
        String power;
        String sql = "select * from power where powerid= "+i+" order by Time desc limit " + count;
        System.out.println(sql);
        ResultSet rs = db.executeQuery(sql);
        try {
            while (rs.next()) {
                power = rs.getString("Power");
                powerlist.add(power);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return  powerlist;
    }

    public static List getglobalpower(){

        List<List> all = new ArrayList();
        for(int i=1;i<25;i++)
        {
            List<String> globalpower = new ArrayList();
            String id= String.valueOf(i);
            globalpower = getpowerbyid(id,"288");
            all.add(globalpower);
        }

        for(int i=1;i<2;i++)
        {
            List<String> globalpower = new ArrayList();
            String id= String.valueOf(i);
            globalpower = gethostpowerbyid(id,"288");
            all.add(globalpower);
        }

        return all;
    }

    public static List getglobalpower2(){
            List<List> globalpower = new ArrayList();
            globalpower = getpowernotbyid("6912");
            List<String>hostpower = gethostpowerbyid("1","288");
            globalpower.add(hostpower);


        return globalpower;
    }

    public static List getpowernotbyid(String count)    {
        List[] listall = new List[25];
        for(int i=0;i<25;i++)
        {
            listall[i] = new ArrayList();
        }
        List<List> powerlist = new ArrayList();
        SqlBean db = new SqlBean();
        String power;
        int id;
        String sql = "select * from vm_dynamic order by Time desc limit " + count;
        System.out.println(sql);
        ResultSet rs = db.executeQuery(sql);
        try {
            while (rs.next()) {
                power = rs.getString("Power");
                id = rs.getInt("id");
                listall[id].add(power);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        for(int i=1;i<25;i++)
        {
            powerlist.add(listall[i]);
        }
        return  powerlist;
    }


    //select time,Id,HostId,VMName,AVG(CpuUsage),AVG(NetUsage),AVG(MemoryUsage),AVG(CpuHz),AVG(Power) from vm_dynamic
    //where DATE_SUB(CURDATE(), INTERVAL 1 DAY) <= date(time) and id = 1
    //GROUP BY date_format(time, '%Y-%m-%d %H') order by time ASC
    //limit 24
    public static List get_1day_vmpower_byid(String id ,String interval_day)    {

        List<String> powerlist = new ArrayList();
        SqlBean db = new SqlBean();
        String power;
        String sql = "select time,Id,HostId,VMName,AVG(Power) as avgpower" +
                " from vm_dynamic where DATE_SUB(CURDATE(), INTERVAL "+ interval_day +" DAY) <= date(time) and id ="+ id +
                " GROUP BY date_format(time, '%Y-%m-%d %H') order by time ASC limit 24";
        System.out.println(sql);
        ResultSet rs = db.executeQuery(sql);
        try {
            while (rs.next()) {
                power = rs.getString("avgpower");

                powerlist.add(power);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        db.CloseDataBase();
        return  powerlist;
    }

    public static List get_1day_hostpower_byid(String hostid, String interval_day) {
        /* 原先没有3的数据，所以会这样
        if(hostid.equals("3")){
            List<String> powerlist = new ArrayList();
            for(int i =0;i<24;i++)
            {
                powerlist.add("0");
                return powerlist;
            }
        }
        */
        List<String> powerlist = new ArrayList();
        SqlBean db = new SqlBean();
        String power;
        String sql = "select time,Id,AVG(Power) as avgpower" +
                " from power where DATE_SUB(CURDATE(), INTERVAL "+ interval_day +" DAY) <= date(time) and powerid ="+ hostid +
                " GROUP BY date_format(time, '%Y-%m-%d %H') order by time ASC limit 24";
        System.out.println(sql);
        ResultSet rs = db.executeQuery(sql);
        try {
            while (rs.next()) {
                power = rs.getString("avgpower");

                powerlist.add(power);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        db.CloseDataBase();
        return  powerlist;
    }

    public static List get_1day_vmpower(int start ,int end,String interval_day)    {
        List<List> listall = new ArrayList();
        int lcount=end-start+1;
        for(int i =0;i<lcount;i++){
            List<String> powerlist = new ArrayList();
            listall.add(powerlist);
        }

        SqlBean db = new SqlBean();
        String power;
        String sql = "select time,Id,HostId,VMName,AVG(Power) as avgpower" +
                " from vm_dynamic where DATE_SUB(CURDATE(), INTERVAL "+ interval_day +" DAY) <= date(time) " +
                "and id >="+ start +" and id <="+end+
                " GROUP BY date_format(time, '%Y-%m-%d %H'),id order by time ASC limit " +lcount*24;
        System.out.println(sql);
        ResultSet rs = db.executeQuery(sql);
        try {
            while (rs.next()) {
                power = rs.getString("avgpower");
                int id = rs.getInt("Id")-start;
                listall.get(id).add(power);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        db.CloseDataBase();
        return  listall;
    }

    public static List get_1day_power_byid(String hostid ,String interval_day)    {
//1~7->1, 8~11->2, 12~24->3

        List<List> powerlist = new ArrayList();
        if(hostid.equals("1")){

            powerlist = get_1day_vmpower(1,7,interval_day);
            List<String> hostpowerlist = get_1day_hostpower_byid("1",interval_day);
            powerlist.add(hostpowerlist);
            /*
            List<String> vmpowerlist1 = get_1day_vmpower_byid("1" , interval_day);
            List<String> vmpowerlist2 = get_1day_vmpower_byid("2" , interval_day);
            List<String> vmpowerlist3 = get_1day_vmpower_byid("3" , interval_day);
            List<String> vmpowerlist4 = get_1day_vmpower_byid("4" , interval_day);
            List<String> vmpowerlist5 = get_1day_vmpower_byid("5" , interval_day);
            List<String> vmpowerlist6 = get_1day_vmpower_byid("6" , interval_day);
            List<String> vmpowerlist7 = get_1day_vmpower_byid("7" , interval_day);
            List<String> hostpowerlist = get_1day_hostpower_byid("1",interval_day);
            powerlist.add(vmpowerlist1);
            powerlist.add(vmpowerlist2);
            powerlist.add(vmpowerlist3);
            powerlist.add(vmpowerlist4);
            powerlist.add(vmpowerlist5);
            powerlist.add(vmpowerlist6);
            powerlist.add(vmpowerlist7);
            powerlist.add(hostpowerlist);
            */
        }
        else if(hostid.equals("2")){

            powerlist = get_1day_vmpower(8,11,interval_day);
            List<String> hostpowerlist = get_1day_hostpower_byid("3",interval_day);
            powerlist.add(hostpowerlist);
            /*

            List<String> vmpowerlist1 = get_1day_vmpower_byid("8" , interval_day);
            List<String> vmpowerlist2 = get_1day_vmpower_byid("9" , interval_day);
            List<String> vmpowerlist3 = get_1day_vmpower_byid("10" , interval_day);
            List<String> vmpowerlist4 = get_1day_vmpower_byid("11" , interval_day);
            List<String> hostpowerlist = get_1day_hostpower_byid("3",interval_day);
            powerlist.add(vmpowerlist1);
            powerlist.add(vmpowerlist2);
            powerlist.add(vmpowerlist3);
            powerlist.add(vmpowerlist4);
            powerlist.add(hostpowerlist);
            */
        }
        else if(hostid.equals("3")){

            powerlist = get_1day_vmpower(12,24,interval_day);
            List<String> hostpowerlist = get_1day_hostpower_byid("2",interval_day);
            powerlist.add(hostpowerlist);
            /*
            List<String> vmpowerlist1 = get_1day_vmpower_byid("12" , interval_day);
            List<String> vmpowerlist2 = get_1day_vmpower_byid("13" , interval_day);
            List<String> vmpowerlist3 = get_1day_vmpower_byid("14" , interval_day);
            List<String> vmpowerlist4 = get_1day_vmpower_byid("15" , interval_day);
            List<String> vmpowerlist5 = get_1day_vmpower_byid("16" , interval_day);
            List<String> vmpowerlist6 = get_1day_vmpower_byid("17" , interval_day);
            List<String> vmpowerlist7 = get_1day_vmpower_byid("18" , interval_day);
            List<String> vmpowerlist8 = get_1day_vmpower_byid("19" , interval_day);
            List<String> vmpowerlist9 = get_1day_vmpower_byid("20" , interval_day);
            List<String> vmpowerlist10 = get_1day_vmpower_byid("21" , interval_day);
            List<String> vmpowerlist11 = get_1day_vmpower_byid("22" , interval_day);
            List<String> vmpowerlist12 = get_1day_vmpower_byid("23" , interval_day);
            List<String> vmpowerlist13 = get_1day_vmpower_byid("24" , interval_day);
            List<String> hostpowerlist = get_1day_hostpower_byid("2",interval_day);
            powerlist.add(vmpowerlist1);
            powerlist.add(vmpowerlist2);
            powerlist.add(vmpowerlist3);
            powerlist.add(vmpowerlist4);
            powerlist.add(vmpowerlist5);
            powerlist.add(vmpowerlist6);
            powerlist.add(vmpowerlist7);
            powerlist.add(vmpowerlist8);
            powerlist.add(vmpowerlist9);
            powerlist.add(vmpowerlist10);
            powerlist.add(vmpowerlist11);
            powerlist.add(vmpowerlist12);
            powerlist.add(vmpowerlist13);
            powerlist.add(hostpowerlist);
            */
        }

        return  powerlist;
    }
  /*
1	1	pvs02
2	1	Backup2012
3	1	openfile
4	1	Backup2016
5	1	NAS1
6	1	pvs2.ecustdei302.com
7	1	testtemp
8	2	windows7 (1)
9	2	Windows Server 2008
10	2	testcpu
11	2	testcpu1
12	3	hchen-stu01
13	3	cheng-stu-test01.52
14	3	it01
15	3	cheng-zabbix
16	3	cheng-ubuntu.56
17	3	cheng-ubuntu02
18	3	hcheng_web_tomcat.59
19	3	cheng-stu-01_20.51,57
20	3	cheng-stu-03.53	0.146
21	3	cheng-centos6.6.55
22	3	hchstusvr-01.ecustdei.com
23	3	cheng-centos6.6.55
24	3	hchstusvr-01.ecustdei.com
        * */
}
