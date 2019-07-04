package org.fkit.domain;

import java.util.ArrayList;
import java.util.List;

import org.fkit.controller.Get24;
import org.fkit.controller.Inspection;
import org.fkit.controller.load;

public class Test {
public static void main(String[] args) {
Get24.getVmCpuLoad("2");
	//String vm="1";
/*	//String id="1";
	//String name;
	//String[] vmCpuLoad=new String[14];
	double[] vmLoad = new double[7];
    //vmLoad=Test.ab(vm);
	String[] data1 = new String[]{"name1","name2","name3","name4","name5"};
	String[] data2 = new String[]{"5.1","2.3","3.5","1.6","5.2"};
	double[] data3 = new double[14];
	String[] cpuUsage = new String[288];
	//cpuUsage=Get24.getVmAverageMemory(id);
	double degree;
	//degree=Inspection.inspect(id);
	String[] vmName=new String[10];
	vmName=Get24.getVmCpuLoad(vm);*/
	/*String[] cpuUsage = new String[288];
	cpuUsage=Get24.getHostMemory("1");
	for(String a : cpuUsage){
		System.out.println(a);
	}*/
	List<load> ld = new ArrayList();
	ld = Get24.getVmCpuHighLoad();
	for(load a :ld){
		//System.out.println(a.getHname()+"--"+a.getvmload()+"--"+a.getvmname());
	}
	/*for(int i=0;i<data2.length;i++){
		data3[i]=Float.parseFloat(data2[i]);
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
    for(int i=0;i<data1.length;i++){
    	System.out.println(data3[i]);
    	System.out.println(data1[i]);
    }*/
}
public static double[] ab(String vm){
	System.out.println("abº¯ÊýÖ´ÐÐÁË");
	double vmLoad1;
	ArrayList<String> vmId=Get24.getVmId(vm);
	int j=vmId.size();
	double[] vmLoad = new double[j];
	for(int i=0;i<j;i++){
		//vmId1 = 
		vmLoad1 = Inspection.inspect(vmId.get(i));
		vmLoad[i] = vmLoad1; 
		System.out.println(vmLoad[i]);
	}
	return vmLoad;
}
}
