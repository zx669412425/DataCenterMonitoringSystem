package org.fkit.controller;

public class Inspection {
	
     public static double inspect (String id){
    	 double degree =1.0 ;
    	 int j=0;
    	 String[] data=new String[288];
    	 float[] dataChange=new float[288];
    	 //data=Get24.getHostAverageMemory(id);
    	 data=Get24.getVmCPU(id);//取数据
    	 for(int i=0;i<288;i++){//转换成float类型
    		 /*float dataChange1 = Float.parseFloat(data[i]);
    		 dataChange[i] = dataChange1;
    		 System.out.println(dataChange1);
    		 System.out.println(i);
    		 System.out.println("转换后"+dataChange[i]);*/
    		 if(data[i]==null){
    			 break;
    		 }
//    		 System.out.println(data[i]+""+i);
    		 dataChange[i] = Float.parseFloat(data[i]);
//    		 System.out.println("转换后"+dataChange[i]);
    		//System.out.println(getType(dataChange[i]));
    		
    	 }
    	 for(int i=0;i<288;i++){//求高负载时间长度
    		if(dataChange[i]>0.226){
    			j++;
    			//System.out.println(j);
    		} 
    	 }
    	 /*if(j>200){
    		 degree=10.0;
    		 System.out.println(degree+"高负荷");
    	 }else{
    		 degree=5.0;
    		 System.out.println(degree+"低负荷");
    	 }*/
    	 degree=j;
    	 System.out.println("高负载时间长度为："+degree);
		return degree;
     }
     //获取变量类型方法
     public static String getType(Object o){ //获取变量类型方法
    	 return o.getClass().toString(); //使用int类型的getClass()方法
    	 }
     
     public static String inspectName(String id){
    	 double degree;
    	 degree=Inspection.inspect(id);
    	 if (degree>5){
    		 id="!";
    	 }else{
    		 id="?";
    	 }
    	 
    	return id; 
     }
}
