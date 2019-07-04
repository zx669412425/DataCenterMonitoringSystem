package org.fkit.controller;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.fkit.domain.Book;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.fkit.controller.Get24;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/json")
public class BookController {
    //------get the newest data of server in net,cpu,and memory.Writen by Yujunjie 19.3.18.------
    @RequestMapping(value="/hostNewUsage")
    @ResponseBody
    public Object getUsage(@RequestParam("id") String vm) {
        String[] hostUsage=new String[3];
        //String vm="1";
        hostUsage = Get24.getUsage(vm);
        return hostUsage;
    }
	//------------------function below all changed by YJJ Date:2019.3.19----------------------------------
    @RequestMapping(value="/hostNetUsage")
    @ResponseBody
    //------old edition ,but do not delete------------------------------
    public Object getHostNet(@RequestParam("id") String vm) {
    	String[] hostNet=new String[288];
        hostNet=Get24.getHostNet(vm,0);
    	System.out.println("controller��ȡ���������������");
    	return hostNet;
    }
    @RequestMapping(value="/hostNetUsage_new")
    @ResponseBody
    //this is the choosable edition for the old one.Use "day"to choose different day's data
    public Object getHostNet_new(@RequestParam("id") String vm,@RequestParam("day") int input_day) {
        String[] hostNet=new String[288];
        hostNet=Get24.getHostNet(vm,input_day);
        return hostNet;
    }

    @RequestMapping(value="/hostCpuUsage")
    @ResponseBody
    public Object getHostCpu(@RequestParam("id") String vm) {
    	String[] hostCpu=new String[288];
    	hostCpu=Get24.getHostCpu(vm,0);
    	return hostCpu;
    }
    @RequestMapping(value="/hostCpuUsage_new")
    @ResponseBody
    public Object getHostCpu_new(@RequestParam("id") String vm,@RequestParam("day") int input_day) {
        String[] hostNet=new String[288];
        hostNet=Get24.getHostCpu(vm,input_day);
        return hostNet;
    }

    @RequestMapping(value="/hostMemoryUsage")
    @ResponseBody
    public Object getHostMemory(@RequestParam("id") String vm) {
    	String[] hostMemory=new String[288];
    	hostMemory=Get24.getHostMemory(vm,0);
    	return hostMemory;
    }
    @RequestMapping(value="/hostMemoryUsage_new")
    @ResponseBody
    public Object getHostMemory_new(@RequestParam("id") String vm,@RequestParam("day") int input_day) {
        String[] hostNet=new String[288];
        hostNet=Get24.getHostMemory(vm,input_day);
        return hostNet;
    }
    //------------------------------YJJ,Date:2019.3.19----------------------------------------------
    @RequestMapping(value="/vmName")
    @ResponseBody
    public Object getVmName(@RequestParam("id") String vm) {
    	ArrayList<String> vmList=new ArrayList<String>();
//    	String vm="1";
    	//System.out.println("12345"+vm);
    	vmList=Get24.getVmName(vm);
    	return vmList;
    }
    @RequestMapping(value="/vmId")
    @ResponseBody 
  //------------------���������ȡ�����ID------------------------------    
    public Object getVmId(@RequestParam("id") String vm) {
    	ArrayList<String> vmId=new ArrayList<String>();
    	vmId=Get24.getVmId(vm);
    	return vmId;
    }
    @RequestMapping(value="/hostAverageMemory")
    @ResponseBody 
    //------------------���������  ȡƽ���ڴ�������------------------------------
    public Object getHostAverageMemory(@RequestParam("id") String vm) {
    	String[] hostAverageMemoryUsage=new String[288];
    	hostAverageMemoryUsage=Get24.getHostAverageMemory_w(vm);
        //System.out.println("controller��ȡ�����ƽ������������");
    	return hostAverageMemoryUsage;
    }
    @RequestMapping(value="/hostAverageCpu")
    @ResponseBody 
    //------------------���������ȡƽ��CPU������------------------------------    
    public Object getHostAverageCpu(@RequestParam("id") String vm) {
    	String[] hostAverageCpuUsage=new String[288];
    	hostAverageCpuUsage=Get24.getHostAverageCpu_w(vm);
    	System.out.println("controller��ȡ�����ƽ��cpu������");
    	return hostAverageCpuUsage;
    }
    @RequestMapping(value="/hostAverageNet")
    @ResponseBody 
  //------------------���������ȡƽ������������------------------------------
    public Object getHostAverageNet(@RequestParam("id") String vm) {
    	String[] hostAverageNetUsage=new String[288];
    	//hostAverageNetUsage=Get24.getHostAverageNet(vm);
        hostAverageNetUsage=Get24.getHostAverageNet_w(vm);
    	return hostAverageNetUsage;
    }
    //------���������  --ȡ��������������ʡ�CPU�����ʡ��ڴ������ʣ�ȡ�����ƽ�����������ʡ�CPU�����ʡ��ڴ�������----------------------------    
    @RequestMapping(value="/vmNetUsage")
    @ResponseBody 
    //------------------���������  ȡ���������������------------------------------    
    public Object getVmNetUsage(@RequestParam("id") String vm) {
    	String[] vmNetUsage=new String[288];
    	vmNetUsage=Get24.getVmNet(vm);
    	return vmNetUsage;
    }
    @RequestMapping(value="/vmMemoryUsage")
    @ResponseBody 
    //------------------���������  ȡ������ڴ�������------------------------------
    public Object getVmMemoryUsage(@RequestParam("id") String vm) {
    	String[] vmMemoryUsage=new String[288];
    	vmMemoryUsage=Get24.getVmMemory(vm);
    	return vmMemoryUsage;
    }
    @RequestMapping(value="/vmCpuUsage")
    @ResponseBody 
    //------------------���������   ȡ�����CPU������------------------------------
    public Object getVmCpuUsage(@RequestParam("id") String vm) {
    	String[] vmCpuUsage=new String[288];
    	vmCpuUsage=Get24.getVmCPU(vm);
    	return vmCpuUsage;
    }
    @RequestMapping(value="/vmAverageNet")
    //ȡ�������7��ƽ������������
    @ResponseBody 
    //------------------���������  ȡ�����ƽ������������------------------------------
    public Object getVmAverageNet(@RequestParam("id") String vm) {
    	
    	String[] vmAverageNet=new String[288];
    	vmAverageNet=Get24.getVmAverageNet(vm);
    	return vmAverageNet;
    }
    @RequestMapping(value="/vmAverageCpu")
    //ȡ�������7��ƽ��CPU������
    @ResponseBody 
    //------------------���������ȡ�����ƽ��CPU������------------------------------
    public Object getVmAverageCpu(@RequestParam("id") String vm) {
    	
    	String[] vmAverageCpu=new String[288];
    	vmAverageCpu=Get24.getVmAverageCpu(vm);
    	return vmAverageCpu;
    } 
    @RequestMapping(value="/vmAverageMemory")
    //ȡ�������7��ƽ���ڴ�������
    @ResponseBody 
    //------------------���������ȡ������ڴ�������------------------------------
    public Object getVmAverageMemory(@RequestParam("id") String vm) {
    	
    	String[] vmAverageMemory=new String[288];
    	vmAverageMemory=Get24.getVmAverageMemory(vm);
    	return vmAverageMemory;
    }   
 //------------------------���ؽ���--ȡ�������һ�츺�أ�������ĸߡ��͸��ص���Ӧ����������֡���������֡����ر�-------------------
    @RequestMapping(value="/getAllVmAverageCpu")
    //------------���ؽ���ȡ�������һ�츺��----------------
    @ResponseBody 
    public Object getAllVmAverageCpu(@RequestParam("id") String vm) {    	
    	return Get24.getVmCpuLoad(vm);
/*    	System.out.println("��̨����ִ����");
    	double vmLoad1;
    	ArrayList<String> vmId=Get24.getVmId(vm);
    	NumberFormat nbf=NumberFormat.getInstance(); 
    	nbf.setMinimumFractionDigits(2);
    	int j=vmId.size();
    	double[] vmLoad = new double[j];
    	String[] vmLoadPercent = new String[j];
    	for(int i=0;i<j;i++){ 
    		vmLoad1 = Inspection.inspect(vmId.get(i));
//    		vmLoad[i] = vmLoad1; 
    		vmLoadPercent[i] = nbf.format(vmLoad1/288*100); 
//    		vmLoadPercent[i]=num.format(vmLoad1/288);
//     		System.out.println(vmLoadPercent[i]+"----------------------");
    	}
    	return vmLoadPercent;*/

    }
 // 2 ------------   ���ؽ���ȡ����ȡ�߸��أ���Ӧ����������֡����������
    @RequestMapping(value="/getVmHighCpuLoad")
    @ResponseBody 
    public Object getVmAverageHighCpuLoad() {
    	return Get24.getVmCpuHighLoad();
    }
 // 3  --------------   ���ؽ���ȡ����ȡ�߸��أ���Ӧ����������֡����������
    @RequestMapping(value="/getVmLowCpuLoad")
    @ResponseBody 
    public Object getVmAverageLowCpuLoad() {
    	return Get24.getVmCpuLowLoad();
    }
    //----------------------------���������߸��ؽ���      ȡ���츺��-----------------------------
    @RequestMapping(value="/vmHighLoad7")
    @ResponseBody 
    //----------------------------ȡ��������츺�ؽ���     -----------------------------
    public Object getVmHighLoad7(@RequestParam("id") String vm) {
 //   	System.out.println("-----------------------------------------"+vm);
    	return Get24.getVmHighLoad7(vm);
    } 
    //----------------------------���������͸��ؽ���      ȡ���츺��-----------------------------
    @RequestMapping(value="/vmLowLoad7")
    @ResponseBody 
    //----------------------------ȡ��������츺�ؽ���     -----------------------------
    public Object getVmLowLoad7(@RequestParam("id") String vm) {
    	return Get24.getVmLowLoad7(vm);
    }

    @RequestMapping(value="/getpowertochen")
    @ResponseBody
    public Object getpowertochen(){
        List<String> list_p = new ArrayList();
        data_load dl= new data_load();
        list_p = dl.getpowertochen();
        return list_p;
    }
    @RequestMapping(value="/gettemptochen")
    @ResponseBody
    public Object gettemptochen(){
        List<String> list_p = new ArrayList();
        data_load dl= new data_load();
        list_p = dl.gettemptochen();
        return list_p;
    }
    @RequestMapping(value="/gethotstochen")
    @ResponseBody
    public Object gethotstochen(){
        List<String> list_p = new ArrayList();
        data_load dl= new data_load();
        list_p = dl.gethotstochen();
        return list_p;
    }
    @RequestMapping(value="/getvmtochen")
    @ResponseBody
    public Object getvmtochen(){
        List<String> list_p = new ArrayList();
        data_load dl= new data_load();
        list_p = dl.getvmtochen();
        return list_p;
    }

    @RequestMapping(value="/getpowerbyid")
    @ResponseBody
    public Object getpowerbyid(@RequestParam("id") String id,@RequestParam("count") String count){
        List<String> list_p = new ArrayList();
        data_load dl= new data_load();

        list_p = dl.getpowerbyid(id,count);
        return list_p;
    }
    @RequestMapping(value="/getglobalpower")
    @ResponseBody
    public Object getglobalpower(){
        List<String> list_p = new ArrayList();
        data_load dl= new data_load();
        list_p = dl.getglobalpower();
        return list_p;
    }
    @RequestMapping(value="/getglobalpower2")
    @ResponseBody
    public Object getglobalpower2(){
        List<List> list_p = new ArrayList();
        data_load dl= new data_load();
        list_p = dl.getglobalpower2();
        return list_p;
    }
    @RequestMapping(value="/get_1day_power_byid")
    @ResponseBody
    //得到一天的power数据，每个小时一个节点，根据
    public Object get_1day_power_byid(@RequestParam("id") String hostid,@RequestParam("interval") String interval){
        List<List> list_p = new ArrayList();
        data_load dl= new data_load();
        list_p = dl.get_1day_power_byid(hostid,interval);
        return list_p;
    }

    @RequestMapping(value = "/HSRequest")
    @ResponseBody
    // @RequestBody根据json数据，转换成对应的Object
    public Object get_heatmapbyday(){
        List<double[]> list_p = new ArrayList();
        data_load d = new data_load();
        list_p = d.getvirpower();
        return list_p;
    }
    @RequestMapping(value = "/HSRequestweek")
    @ResponseBody
    public Object get_heatmapbyweek(){
        List<double[]> list_p = new ArrayList();
        data_load d = new data_load();
        list_p = d.getvirpowerbyweek();
        return list_p;
    }


    @RequestMapping(value = "/HSRequestmonth")
    @ResponseBody
    public Object get_heatmapbymonth(){
        List<double[]> list_p = new ArrayList();
        data_load d = new data_load();
        list_p = d.getvirpowerbymonth();
        return list_p;
    }
    @RequestMapping(value = "/alarmedVm")
    @ResponseBody
    //----------------------------
    public Object getAlarmedVm() {
        System.out.println("alarmController================");
        return Get24.getAlarmedVm();
    }
    @RequestMapping(value = "/singleVmName")
    @ResponseBody
    public Object getSingleVmName(@RequestParam("id") String vm) {
        System.out.println(vm);
        System.out.println("vmName-controller");
        String string = Get24.getSingleVmName(vm);
        System.out.println(string);
        return string;
    }
    @RequestMapping(value="/vmNetUsage1")
    @ResponseBody
    //------------------���������  ȡ���������������------------------------------
    public Object getVmNetUsage1(@RequestParam("id") String vm) {
        System.out.println("vm:"+vm);
        //return Get24.getSingleVmName(vm);
        return "qwwert";
    }
}

