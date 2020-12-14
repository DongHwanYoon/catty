package org.catty.facility;

import java.io.Serializable;
import java.util.List;

/**
 * @author dbsehdghks45@naver.com
 */
public class ManagementFacility implements Serializable {
	private int no;
	private int memberNo;
	private int facilityNo;
	
	private List<ManagementFacility> managementFacilityList;
	
	public ManagementFacility(int memberNo, int facilityNo) {
		this.memberNo = memberNo;
		this.facilityNo = facilityNo;
	}

	public ManagementFacility() {
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getFacilityNo() {
		return facilityNo;
	}

	public void setFacilityNo(int facilityNo) {
		this.facilityNo = facilityNo;
	}

	public List<ManagementFacility> getManagementFacilityList() {
		return managementFacilityList;
	}

	public void setManagementFacilityList(List<ManagementFacility> managementFacilityList) {
		this.managementFacilityList = managementFacilityList;
	}
}