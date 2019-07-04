package org.fkit.controller;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

//import com.sun.xml.internal.bind.v2.schemagen.xmlschema.List;

//Error!
// Most of functions in this class will not close the connection to Sql DB.It may cause problems.
//Annotated by Yujunjie.2019.3.18
public class Get24 {
    //get the newest data of server in net,cpu,and memory.Writen by Yujunjie 19.3.18.
    public static String[] getUsage(String VM){
		String vm =VM;
		String[] Parameter = {"NetUsage","CpuUsage","MemoryUsage"};
		String sql="";
		SqlBean db= new SqlBean();
		String[] data1 = new String[3];
		for(int i=0 ;i<3; i++) {
			sql="select "+Parameter[i]+" from host_dynamic where HostId='"+ vm + "' order by Time desc limit 1";
			//System.out.println(sql);
			ResultSet rs = db.executeQuery(sql);
			//System.out.println(rs);
			try {
				while (rs.next()) {
					data1[i] = rs.getString(Parameter[i]);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {
				db.CloseDataBase();
			}
		}
		return data1;
    }

    //get the nearest 24 hours'data of server in net aspect .The parameter vm is the host id.Annotated by YJJ.19.3.18
	//add a parameter input_day.Use for select different day's data.Example:Zero means nearest 288(0-24hours') data;One means 288-576(24-48 hour's)data.Writtenned by YJJ 19.3.19
	public static String[] getHostNet(String VM , int input_day){
		String vm =VM;
		int day =input_day;
		String sql="select NetUsage from host_dynamic where HostId='"+vm+"' order by Time desc limit " + input_day * 288 + "," +  288;
		//System.out.println(sql);
		SqlBean db= new SqlBean();
		ResultSet rs = db.executeQuery(sql);
		String[] data1=new String[288];
		int i=0;
		try {
			while(rs.next()) {	
				//System.out.println(rs.getString("NetUsage"));
				data1[i]=rs.getString("NetUsage");
				 i++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		 return data1;
  }

    //get the nearest 7 days' average data of server in net aspect.The parameter vm is the host id.Annotated by YJJ.19.3.18
	public static String[] getHostAverageNet_w(String VM){
		String vm =VM;
		String sql="SELECT NetUsage from host_avg WHERE Hostid='"+vm+"' and days=7 ORDER BY time";
		//System.out.println(sql);
		SqlBean db= new SqlBean();
		ResultSet rs = db.executeQuery(sql);
		//System.out.println(rs);
		String[] data1=new String[288];
		int i=0;
		try {
			while(rs.next()) {
				//System.out.println(rs.getString("NetUsage"));
				data1[i]=rs.getString("NetUsage");
				i++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return data1;
	}

	public static String[] getHostAverageCpu_w(String VM){
		String vm =VM;
		String sql="SELECT CpuUsage from host_avg WHERE Hostid='"+vm+"' and days=7 ORDER BY time";
		//System.out.println(sql);
		SqlBean db= new SqlBean();
		ResultSet rs = db.executeQuery(sql);
		//System.out.println(rs);
		//System.out.println("Get24��ȡ���������������------------------------------------------------------------");
		String[] data1=new String[288];
		int i=0;
		try {
			while(rs.next()) {
				//System.out.println(rs.getString("NetUsage"));
				data1[i]=rs.getString("CpuUsage");
				i++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return data1;
	}
	public static String[] getHostAverageMemory_w(String VM){
		String vm =VM;
		String sql="SELECT MemoryUsage from host_avg WHERE Hostid='"+vm+"' and days=7 ORDER BY time";
		//System.out.println(sql);
		SqlBean db= new SqlBean();
		ResultSet rs = db.executeQuery(sql);
		//System.out.println(rs);
		//System.out.println("Get24��ȡ���������������------------------------------------------------------------");
		String[] data1=new String[288];
		int i=0;
		try {
			while(rs.next()) {
				data1[i]=rs.getString("MemoryUsage");
				i++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return data1;
	}

	public static String[] getHostCpu(String VM,int input_day){
		String vm =VM;
		String sql="select CpuUsage from Host_dynamic where HostId='"+vm+"' order by Time desc limit " + input_day * 288 + "," +  288;
		SqlBean db= new SqlBean();
		ResultSet rs = db.executeQuery(sql);
		String[] data1=new String[288];
		int i=0;
		try {
			while(rs.next()) {
				data1[i]=rs.getString("CpuUsage");
				 i++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		 return data1;
  } 
//	get the nearest 24 horus' average data of server in memory aspect.The parameter vm is the host id.Annotated by YJJ.19.3.18
	public static String[] getHostMemory(String VM, int input_day){
		String vm =VM;
		String sql="select MemoryUsage from Host_dynamic where HostId='"+vm+"' order by Time desc limit " + input_day * 288 + "," +  288;
		SqlBean db= new SqlBean();
		ResultSet rs = db.executeQuery(sql);
		String[] data1=new String[288];
		int i=0;
		try {
			while(rs.next()) {
				data1[i]=rs.getString("MemoryUsage");
				 i++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		 return data1;
  } 
	// get all VM devices'name which belongs to the host.The parameter vm is the host id.Annotated by YJJ.19.3.18
	public static ArrayList<String> getVmName(String VM){
		String vm=VM;
		String sql="select VmName from vm_static where HostId='"+vm+"'";
		SqlBean db= new SqlBean();
		
		ResultSet rs = db.executeQuery(sql);
		String[] data= new String[20];
		ArrayList<String> list=new ArrayList<String>();
		//System.out.println("���������");
		int i=0;
		try {
          while(rs.next()) {	
				//System.out.println(rs.getString("VmName"));
				data[i]=rs.getString("VmName");
				 //System.out.println(data[i]);
				 list.add(data[i]);
				 //System.out.println(list.get(i));
				 i++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	 
		return list;
	}
	//  get all VM devices'id which belongs to the host.The parameter vm is the host id.Annotated by YJJ.19.3.18
	public static ArrayList<String> getVmId(String VM){
		String vm=VM;
		String sql="select Id from vm_static where HostId='"+vm+"'";
		SqlBean db= new SqlBean();
		
		ResultSet rs = db.executeQuery(sql);
		String[] data= new String[50];
		ArrayList<String> list=new ArrayList<String>();
		//System.out.println("�����id");
		int i=0;
		try {
          while(rs.next()) {	
				data[i]=rs.getString("Id");
				// System.out.println(data[i]);
				 list.add(data[i]);
				// System.out.println(list.get(i));
				 i++;
			}
          
		} catch (SQLException e) {
			e.printStackTrace();
		}	 
		return list;
	}
	//  6         ȡ�������ƽ������������	
	public static String[] getHostAverageNet(String VM){
		String vm =VM;
		String sql1="insert into tmem_net "+
		"select time,NetUsage,(@i := @i + 1) as ord_num  from host_dynamic,(select @i := 0) b where HostId="+vm+" and Time >date_sub(now(),interval 2 day) and Time <date_sub(now(),interval 1 day)"+
		" UNION ALL "+
		" select time,NetUsage,(@j := @j + 1) as ord_num  from host_dynamic,(select @j := 0) c where HostId="+vm+" and Time >date_sub(now(),interval 3 day) and Time <date_sub(now(),interval 2 day)";
		String sql2="SELECT AVG( NetUsage),NetUsage,ord_num FROM tmem_net group by ord_num ORDER BY ord_num  ASc";
		String sql3="TRUNCATE TABLE tmem_net";
		//System.out.println(sql);
		SqlBean db= new SqlBean();
	    db.executeInsert(sql1);
	    //System.out.println("sql1ִ����");
	    ResultSet rs2 =db.executeQuery(sql2);
	   // System.out.println("sql2ִ����");
		db.executeDelete(sql3);
		//System.out.println("sql3ִ����");
		//System.out.println(rs);	
		//System.out.println("Get24��ȡ�����ƽ������������-------------------------------------------------------");
		
		String[] data1=new String[288];
		int i=0;
		try {
			while(rs2.next()) {	
				//System.out.println("ѭ��"+i+"��ʼ");
				//System.out.println(rs2.getString("NetUsage"));
				data1[i]=rs2.getString("NetUsage");
				 i++;
			}
			for(i=0;i<data1.length;i++){
				if(data1[i]==null){
					data1[i]=data1[i-1];
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		 return data1;
  } 
	//  7        ȡ�������ƽ���ڴ�������
	public static String[] getHostAverageMemory(String VM){
		String vm =VM;
		String sql1="insert into tmem "+
		"select time,MemoryUsage,(@i := @i + 1) as ord_num  from host_dynamic,(select @i := 0) b where HostId="+vm+" and Time >date_sub(now(),interval 2 day) and Time <date_sub(now(),interval 1 day)"+
		" UNION ALL "+
		" select time,MemoryUsage,(@j := @j + 1) as ord_num  from host_dynamic,(select @j := 0) c where HostId="+vm+" and Time >date_sub(now(),interval 3 day) and Time <date_sub(now(),interval 2 day)";
		String sql2="SELECT AVG( MemoryUsage),MemoryUsage,ord_num FROM TMEM group by ord_num ORDER BY ord_num  ASc";
		String sql3="TRUNCATE TABLE tmem";
		//System.out.println(sql);
		SqlBean db= new SqlBean();
	    db.executeInsert(sql1);
	   // System.out.println("sql1ִ����");
	    ResultSet rs2 =db.executeQuery(sql2);
	  //  System.out.println("sql2ִ����");
		db.executeDelete(sql3);
		//System.out.println("sql3ִ����");
		//System.out.println(rs);	
		//System.out.println("Get24��ȡ�����ƽ���ڴ�������------------------------------------------------------");
		
		String[] data1=new String[288];
		int i=0;
		try {
			while(rs2.next()) {	
				//System.out.println(i);
				//System.out.println(rs2.getString("MemoryUsage"));
				data1[i]=rs2.getString("MemoryUsage");
				 i++;
			}
			for(i=0;i<data1.length;i++){
				if(data1[i]==null){
					data1[i]=data1[i-1];
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		 return data1;
  } 
	//  8     ȡ�������ƽ��CPU������	
	public static String[] getHostAverageCpu(String VM){
		String vm =VM;
		String sql1="insert into tmem_cpu "+
		"select time,CpuUsage,(@i := @i + 1) as ord_num  from host_dynamic,(select @i := 0) b where HostId="+vm+" and Time >date_sub(now(),interval 2 day) and Time <date_sub(now(),interval 1 day)"+
		" UNION ALL "+
		" select time,CpuUsage,(@j := @j + 1) as ord_num  from host_dynamic,(select @j := 0) c where HostId="+vm+" and Time >date_sub(now(),interval 3 day) and Time <date_sub(now(),interval 2 day)";
		String sql2="SELECT AVG( CpuUsage),CpuUsage,ord_num FROM tmem_cpu group by ord_num ORDER BY ord_num  ASc";
		String sql3="TRUNCATE TABLE tmem_cpu";
		//System.out.println(sql);
		SqlBean db= new SqlBean();
	    db.executeInsert(sql1);
	   // System.out.println("sql1ִ����");
	    ResultSet rs2 =db.executeQuery(sql2);
	   // System.out.println("sql2ִ����");
		//db.executeDelete(sql3);
		//System.out.println("sql3ִ����");
		//System.out.println(rs);	
		//System.out.println("Get24��ȡ�����ƽ��cpu������----------------------------------------------------------------");
		
		String[] data1=new String[288];
		int i=0;
		try {
			while(rs2.next()) {	
			//	System.out.println("ѭ����ʼ");
			//	System.out.println(rs2.getString("CpuUsage"));
				data1[i]=rs2.getString("CpuUsage");
				 i++;
			}
			for(i=0;i<data1.length;i++){
				if(data1[i]==null){
					data1[i]=data1[i-1];
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		 return data1;
  } 
	//-----���������--ȡ����������������ʡ��ڴ������ʡ�CPU�����ʣ��������ƽ�����������ʡ��ڴ������ʡ�CPU������---------------------
// 1	ȡ�����CPU������
	public static String[] getVmCPU(String VM){
		String vm =VM;
		//String sql="select CpuUsage from CPU24 where Name='"+vm+"'";
		String sql="select CpuUsage from vm_dynamic where Id='"+vm+"' order by Time desc limit 288";
		//System.out.println(sql);
		SqlBean db= new SqlBean();
		ResultSet rs = db.executeQuery(sql);
		//System.out.println(rs);
		System.out.println("Get24��ȡ�����CPU������-----------------------------------------------------");
		//Float[] data = new Float[7663];
		String[] data1=new String[288];
		int i=0;
		try {
			while(rs.next()) {	
				//data[i]=Float.parseFloat(rs.getString("CpuUsage"));
//				System.out.println(rs.getString("CpuUsage"));
				//System.out.println(i);
				data1[i]=rs.getString("CpuUsage");
				 i++;
				 //System.out.println(i);
				 //System.out.println(data[i]);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		//System.out.println(data);
		 return data1;
		 
  } 
//  2 ȡ���������������
	public static String[] getVmNet(String VM){
		String vm =VM;
		String sql="select NetUsage from vm_dynamic where Id='"+vm+"' order by Time desc limit 288";
		//System.out.println(sql);
		SqlBean db= new SqlBean();
		ResultSet rs = db.executeQuery(sql);
		//System.out.println(rs);
		System.out.println("Get24��ȡ���������������------------------------------------------------------------------");
		
		String[] data1=new String[288];
		int i=0;
		try {
			while(rs.next()) {	
				
				//System.out.println(rs.getString("NetUsage"));
				data1[i]=rs.getString("NetUsage");
				 i++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		 return data1;
  } 
	//  3         ȡ��������ڴ�������
	public static String[] getVmMemory(String VM){
		String vm =VM;
		String sql="select MemoryUsage from vm_dynamic where Id='"+vm+"' order by Time desc limit 288";
		//System.out.println(sql);
		SqlBean db= new SqlBean();
		ResultSet rs = db.executeQuery(sql);
		//System.out.println(rs);
		System.out.println("Get24��ȡ������ڴ�������");
		
		String[] data1=new String[288];
		int i=0;
		try {
			while(rs.next()) {	
				
				//System.out.println(rs.getString("MemoryUsage"));
				data1[i]=rs.getString("MemoryUsage");
				 i++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		 return data1;
  } 
// 4   ȡ�������ƽ���ڴ�������
	public static String[] getVmAverageMemory(String VM){
		String vm =VM;
		String sql1="select MemoryUsage from vm_avg where Id='"+vm+"' and days=7 order by Time desc limit 288";
		SqlBean db= new SqlBean();
		ResultSet rs1=db.executeQuery(sql1);
		System.out.println("Get24��ȡ�����ƽ���ڴ�������---------------------------------");		
		String[] data1=new String[288];
		int i=0;
		try {
			while(rs1.next()) {	
			//	System.out.println("cpu������"+i);
			//	System.out.println(rs1.getString("MemoryUsage"));
				data1[i]=rs1.getString("MemoryUsage");
				 i++;		 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		 return data1;
  }
	// 5     ȡ�����������������
	public static String[] getVmAverageNet(String VM){
		String vm =VM;
		String sql="select NetUsage from vm_avg where Id='"+vm+"' and days=7 order by Time desc limit 288";
		SqlBean db= new SqlBean();
		ResultSet rs1 = db.executeQuery(sql);
		String[] data1=new String[288];
		System.out.println("Get24��ȡ�����ƽ������������---------------------------------");
		int i=0;
		try {
			while(rs1.next()) {	
				//System.out.println("����������"+i);
				//System.out.println(rs1.getString("NetUsage"));
				data1[i]=rs1.getString("NetUsage");
				 i++;			 
			}
	}catch (SQLException e) {
		e.printStackTrace();
	}
	 return data1;
} 
	// 6   ȡ�������ƽ��CPU������
	public static String[] getVmAverageCpu(String VM){
		String vm =VM;
		String sql="select CpuUsage from vm_avg where Id='"+vm+"' and days=7 order by Time desc limit 288";
		SqlBean db= new SqlBean();
		ResultSet rs1 = db.executeQuery(sql);
		String[] data1=new String[288];
		System.out.println("Get24��ȡ�����ƽ��cpu������---------------------------------");
		int i=0;
		try {
			while(rs1.next()) {	
				//System.out.println("cpu������"+i);
				//System.out.println(rs1.getString("CpuUsage"));
				data1[i]=rs1.getString("CpuUsage");
				 i++;			 
			}
	}catch (SQLException e) {
		e.printStackTrace();
	}
	 return data1;
} 
	
/*	public static String[] getVmCpuLoad(String VM){
		String vm =VM;
		String sql="select id,VmName,count(Id) from vm_dynamic where hostid= "+vm+"  and time>date_sub(NOW(),interval 1 day) and time < now() and CpuUsage>0.126 group by id";
		SqlBean db= new SqlBean();
		
		ResultSet rs = db.executeQuery(sql);
		
		String[] data = new String[14];
		String[] data1 = new String[14];
		String[] data2 = new String[14];
		double[] data3 = new double[14];
		int i=0;
		try {
			while(rs.next()) {	
				//data[i]=rs.getString("Id");
				// System.out.println(data[i]);
				 data1[i]=rs.getString("VmName");
				 //System.out.println(data1[i]);
				 data2[i]=rs.getString("count(Id)");
				 data3[i]=Float.parseFloat(data2[i]);
				 //System.out.println(data2[i]);
				 i++;
			}
			for(int j=0;j<data1.length;j++){
				for(int k=j+1;k<data1.length;k++){
				if(data3[j]<data3[k]){
					double temp=data3[j];
					String tempName=data1[j];
					data1[j]=data1[k];
					data3[j]=data3[k];
					data1[k]=tempName;
					data3[k]=temp;
				}
				}
			}
			for(int j=0;j<data1.length;j++){
				//System.out.println("aaaaaaa");
				System.out.println(data3[j]+""+j);
				System.out.println(data1[j]);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	 
		 return data1;
  } */
//---------------���ؽ���--ȡ������߸��ء��͸��ء���Ӧ����������֡����������---------------------------------------------
	// 1    ȡ����������������һ�츺��
	public static List<String> getVmCpuLoad(String VM){
		//����һ�������������һ��ĸ���
		String vm =VM;
		String sql1="select vp.vmname,vp.id ,IF( vk.cid IS NULL ,0,vk.cid)/288 from (select * from vm_static vs where vs.HostId="+vm+") as vp left JOIN (select  id as vid ,count(vd.Id) as cid from   vm_dynamic vd where   vd.hostid="+vm+"  and  vd.time>date_sub(NOW(),interval 1 day) and vd.time < now() and vd.CpuUsage>20 group by vd.Id) as vk on  vk.vid=vp.Id ";
		SqlBean db= new SqlBean();
		ResultSet rs1=db.executeQuery(sql1);		
        List<String> data1=new ArrayList();
		int i=0;
		try {
			while(rs1.next()) {
				//System.out.println(rs1.getString("IF( vk.cid IS NULL ,0,vk.cid)/288"));
				data1.add(rs1.getString("IF( vk.cid IS NULL ,0,vk.cid)/288"));
				 i++;		 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		return data1;
		
	}
// 2    ���ؽ���ȡ����ȡ�߸��أ���Ӧ����������֡����������	
	public static List<load> getVmCpuHighLoad(){
		String sql="select h.HostName,v.hostid,v.id,v.VmName,count(v.Id) as c from vm_dynamic v, host_static h where v.HostId=h.HostId and  v.time>date_sub(NOW(),interval 7 day) and v.time < now() and v.CpuUsage>20 group by v.id  order by c DESC";
		SqlBean db= new SqlBean();
		
		List<load> ld = new ArrayList();
		
		ResultSet rs = db.executeQuery(sql);
		int i=0;
		try {
			while(rs.next()) {	
				load tp =new load();
				tp.setHname(rs.getString("HostName"));
				tp.setvmload(rs.getString("c"));
				tp.setvmname(rs.getString("VmName"));
				tp.setvmId(rs.getString("id"));
				ld.add(tp);
				 i++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	 
		 return ld;
  } 
	// 3     ���ؽ���ȡ����ȡ�͸��أ���Ӧ����������֡����������
	public static List<load> getVmCpuLowLoad(){
		String sql="select h.HostName,v.hostid,v.id,v.VmName,count(v.Id) as c from vm_dynamic v, host_static h where v.HostId=h.HostId and  v.time>date_sub(NOW(),interval 7 day) and v.time < now() and v.CpuUsage<2 group by v.id  order by c DESC";
		SqlBean db= new SqlBean();
		List<load> ld = new ArrayList();		
		ResultSet rs = db.executeQuery(sql);

		int i=0;
		try {
			while(rs.next()) {	
				load tp =new load();
				tp.setHname(rs.getString("HostName"));
				tp.setvmload(rs.getString("c"));
				tp.setvmname(rs.getString("VmName"));
				tp.setvmId(rs.getString("id"));
				ld.add(tp);				
				 i++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	 
		 return  ld;
  }
	//--------����߸��ؽ���--ȡ���������ĸ���-----------------------
//����߸��ؽ���ȡ���������ĸ���
	public static List<Load7> getVmHighLoad7(String VM){
		String vm=VM;
		//String sql="select h.HostName,v.hostid,v.id,v.VmName,date(v.time) as c,count(date(v.time))/288  from vm_dynamic v, host_static h where v.id="+vm+" and v.HostId=h.HostId and time > date(date_sub(NOW(),interval 7 day)) and time <date(NOW())and v.CpuUsage>20 group by date(v.time)  order by c DESC";
		String sql="select h.HostName,v.hostid,v.id,v.VmName,date(v.time) as c,AVG(v.CpuUsage) as d  from vm_dynamic v, host_static h where v.id="+vm+" and v.HostId=h.HostId and time > date(date_sub(NOW(),interval 7 day)) and time <date(NOW()) group by date(v.time)  order by c DESC";
		SqlBean db=new SqlBean();
		ResultSet rs=db.executeQuery(sql);
		List<Load7> ld = new ArrayList();
		int i=0;
		try{
			while(rs.next()){
				Load7 tp =new Load7();
				//tp.setvmLoad(rs.getString("count(date(v.time))/288"));
				tp.setvmLoad(rs.getString("d"));
//				System.out.println(tp.vmLoad);
				tp.setvmName(rs.getString("VmName"));
//				System.out.println(tp.vmName);
				tp.setDate(rs.getString("c"));
//				System.out.println(tp.date);
				ld.add(tp);				
				i++;
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}
		return ld;
	}
	//--------����͸��ؽ���--ȡ���������ĸ���-----------------------
	//����͸��ؽ���ȡ���������ĸ���
		public static List<Load7> getVmLowLoad7(String VM){
			String vm=VM;
			//String sql="select h.HostName,v.hostid,v.id,v.VmName,date(v.time) as c,count(date(v.time))/288  from vm_dynamic v, host_static h where v.id="+vm+" and v.HostId=h.HostId and time > date(date_sub(NOW(),interval 7 day)) and time <date(NOW())and v.CpuUsage<2 group by date(v.time)  order by c DESC";
			String sql="select h.HostName,v.hostid,v.id,v.VmName,date(v.time) as c,AVG(v.CpuUsage) as d  from vm_dynamic v, host_static h where v.id="+vm+" and v.HostId=h.HostId and time > date(date_sub(NOW(),interval 7 day)) and time <date(NOW()) group by date(v.time)  order by c DESC";
//	换成		select h.HostName,v.hostid,v.id,v.VmName,date_format(time, '%Y-%m-%d %H') as c,AVG(v.CpuUsage) as d  from vm_dynamic v, host_static h where v.id=14 and v.HostId=h.HostId and time > date(date_sub(NOW(),interval 7 day)) and time <date(NOW()) group by date_format(time, '%Y-%m-%d %H')  order by c DESC
			SqlBean db=new SqlBean();
			ResultSet rs=db.executeQuery(sql);
			List<Load7> ld = new ArrayList();
			int i=0;
			try{
				while(rs.next()){
					Load7 tp =new Load7();
					tp.setvmLoad(rs.getString("d"));
//					System.out.println(tp.vmLoad);
					tp.setvmName(rs.getString("VmName"));
//					System.out.println(tp.vmName);
					tp.setDate(rs.getString("c"));
//					System.out.println(tp.date);
					ld.add(tp);				
					i++;
				}
				
			}catch(SQLException e){
				e.printStackTrace();
			}
			return ld;
		}
	public static List<VmInfo>  getAlarmedVm(){
		String sql="select * from vm_alarm ORDER BY Time desc LIMIT 5";
		SqlBean db=new SqlBean();
		ResultSet rs=db.executeQuery(sql);
		List list = new ArrayList<VmInfo>();
		try{
			while(rs.next()){
				VmInfo vmInfo = new VmInfo();
				System.out.println(rs.getString("VmName"));
				vmInfo.vmName = rs.getString("VmName");
				vmInfo.cpuUsage = rs.getString("CpuUsage");//存放虚拟机cpu利用率
				vmInfo.cpuUsageFlag = Double.parseDouble(rs.getString("CpuUsage"))>0.3;
				vmInfo.netUsage = rs.getString("NetUsage");//存放虚拟机net利用率
				vmInfo.netUsageFlag= Double.parseDouble(rs.getString("NetUsage"))>0.3;
				vmInfo.memoryUsage = rs.getString("MemoryUsage");//存放虚拟机memory利用率
				vmInfo.memoryUsageFlag = Double.parseDouble(rs.getString("MemoryUsage"))>0.3;
				vmInfo.date = rs.getString("Time");//存放虚拟机日期
				list.add(vmInfo);
			}

		}catch(SQLException e){
			e.printStackTrace();
		}
		System.out.println("list:"+list);
		for(int i = 0;i<5;i++){
			System.out.println(list.get(i));
			System.out.println(((VmInfo)list.get(i)).vmName);
			System.out.println(((VmInfo)list.get(i)).cpuUsage);
			System.out.println(((VmInfo)list.get(i)).cpuUsageFlag);
			System.out.println(((VmInfo)list.get(i)).date);
			System.out.println(((VmInfo)list.get(i)).memoryUsageFlag);
			System.out.println(((VmInfo)list.get(i)).netUsageFlag);
		}
		return list;
	}
	public static String  getSingleVmName(String id){
		String sql="select VmName from vm_static where Id = "+id;
		SqlBean db=new SqlBean();
		ResultSet rs=db.executeQuery(sql);
		String name  = "";
		try{
			while(rs.next()){
				name = rs.getString("VmName");
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		System.out.println("vmname:"+name);
		return name;
	}
	//---------------------------------------------------------------------------------------------------	
}
