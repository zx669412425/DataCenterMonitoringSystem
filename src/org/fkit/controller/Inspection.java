package org.fkit.controller;

public class Inspection {
	
     public static double inspect (String id){
    	 double degree =1.0 ;
    	 int j=0;
    	 String[] data=new String[288];
    	 float[] dataChange=new float[288];
    	 //data=Get24.getHostAverageMemory(id);
    	 data=Get24.getVmCPU(id);//ȡ����
    	 for(int i=0;i<288;i++){//ת����float����
    		 /*float dataChange1 = Float.parseFloat(data[i]);
    		 dataChange[i] = dataChange1;
    		 System.out.println(dataChange1);
    		 System.out.println(i);
    		 System.out.println("ת����"+dataChange[i]);*/
    		 if(data[i]==null){
    			 break;
    		 }
//    		 System.out.println(data[i]+""+i);
    		 dataChange[i] = Float.parseFloat(data[i]);
//    		 System.out.println("ת����"+dataChange[i]);
    		//System.out.println(getType(dataChange[i]));
    		
    	 }
    	 for(int i=0;i<288;i++){//��߸���ʱ�䳤��
    		if(dataChange[i]>0.226){
    			j++;
    			//System.out.println(j);
    		} 
    	 }
    	 /*if(j>200){
    		 degree=10.0;
    		 System.out.println(degree+"�߸���");
    	 }else{
    		 degree=5.0;
    		 System.out.println(degree+"�͸���");
    	 }*/
    	 degree=j;
    	 System.out.println("�߸���ʱ�䳤��Ϊ��"+degree);
		return degree;
     }
     //��ȡ�������ͷ���
     public static String getType(Object o){ //��ȡ�������ͷ���
    	 return o.getClass().toString(); //ʹ��int���͵�getClass()����
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
