package org.catty.facility;

import java.io.Serializable;
import java.util.List;

/**
 * @author dbsehdghks45@naver.com
*/
public class WaterBarrel implements Serializable {
	private int no;
    private int facilityNo;
    private String supplementStatus;
    private int criticalValue;
    private int capacity;
    private String status;
    private int standard;
    
    private List<WaterBarrel> waterBarrelList;

	public WaterBarrel() {
	}

	public WaterBarrel(int no, int facilityNo, String supplementStatus, int criticalValue, int capacity, String status,
			int standard) {
		this.no = no;
		this.facilityNo = facilityNo;
		this.supplementStatus = supplementStatus;
		this.criticalValue = criticalValue;
		this.capacity = capacity;
		this.status = status;
		this.standard = standard;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getFacilityNo() {
		return facilityNo;
	}

	public void setFacilityNo(int facilityNo) {
		this.facilityNo = facilityNo;
	}

	public String getSupplementStatus() {
		return supplementStatus;
	}

	public void setSupplementStatus(String supplementStatus) {
		this.supplementStatus = supplementStatus;
	}

	public int getCriticalValue() {
		return criticalValue;
	}

	public void setCriticalValue(int criticalValue) {
		this.criticalValue = criticalValue;
	}

	public int getCapacity() {
		return capacity;
	}

	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getStandard() {
		return standard;
	}

	public void setStandard(int standard) {
		this.standard = standard;
	}

	public List<WaterBarrel> getWaterBarrelList() {
		return waterBarrelList;
	}

	public void setWaterBarrelList(List<WaterBarrel> waterBarrelList) {
		this.waterBarrelList = waterBarrelList;
	}

//    private int itemStart;
//    private int itemSizePerPage;
    
}