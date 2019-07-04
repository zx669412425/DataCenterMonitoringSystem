package org.fkit.controller;

import java.io.Serializable;

public class VmInfo implements Serializable {
    String vmName;
    String cpuUsage;
    boolean cpuUsageFlag;
    String netUsage;
    boolean netUsageFlag;
    String memoryUsage;
    boolean memoryUsageFlag;
    String date;
    public String getVmName() {
        return vmName;
    }
    public void setVmName(String vmName) {
        this.vmName = vmName;
    }
    public String getCpuUsage() {
        return cpuUsage;
    }
    public void setCpuUsage(String cpuUsage) {
        this.cpuUsage = cpuUsage;
    }
    public boolean isCpuUsageFlag() {
        return cpuUsageFlag;
    }
    public void setCpuUsageFlag(boolean cpuUsageFlag) {
        this.cpuUsageFlag = cpuUsageFlag;
    }
    public String getNetUsage() {
        return netUsage;
    }
    public void setNetUsage(String netUsage) {
        this.netUsage = netUsage;
    }
    public boolean isNetUsageFlag() {
        return netUsageFlag;
    }
    public void setNetUsageFlag(boolean netUsageFlag) {
        this.netUsageFlag = netUsageFlag;
    }
    public String getMemoryUsage() {
        return memoryUsage;
    }
    public void setMemoryUsage(String memoryUsage) {
        this.memoryUsage = memoryUsage;
    }
    public boolean isMemoryUsageFlag() {
        return memoryUsageFlag;
    }
    public void setMemoryUsageFlag(boolean memoryUsageFlag) {
        this.memoryUsageFlag = memoryUsageFlag;
    }
    public String getDate() {
        return date;
    }
    public void setDate(String date) {
        this.date = date;
    }
}
