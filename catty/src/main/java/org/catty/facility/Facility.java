package org.catty.facility;

import java.io.Serializable;
import java.util.List;

/**
 * @author dbsehdghks45@naver.com
 */
public class Facility implements Serializable {
	private int no;
	private String name;
	private String uid;
	private double latitude;
	private double longitude;
	private String status;
	private String type;
	
	private List<Facility> facilityList;

	
	
	public Facility(int no, String name, String uid, double latitude, double longitude, String status, String type) {
		this.no = no;
		this.name = name;
		this.uid = uid;
		this.latitude = latitude;
		this.longitude = longitude;
		this.status = status;
		this.type = type;
	}

	public Facility() {
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public List<Facility> getFacilityList() {
		return facilityList;
	}

	public void setFacilityList(List<Facility> facilityList) {
		this.facilityList = facilityList;
	}

	@Override
	public String toString() {
		return "Facility [no=" + no + ", name=" + name + ", uid=" + uid + ", latitude=" + latitude + ", longitude="
				+ longitude + ", status=" + status + ", type=" + type + ", facilityList=" + facilityList + "]";
	}

//    private int itemStart;
//    private int itemSizePerPage;
	
	
}