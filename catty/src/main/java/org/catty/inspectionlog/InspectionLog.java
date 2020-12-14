package org.catty.inspectionlog;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

/**
 * @author dbsehdghks45@naver.com
*/
public class InspectionLog implements Serializable {
    private int no;				//일련번호
    private int memberNo;		//점검일지 작성자 일련번호
    private int facilityNo;		//시설물 일련번호
    private String registrateDate;//등록일자
    private String modifiedDate;	//수정일자
    private String note;		//내용
    
    private List<InspectionLog> inspectionLogList;

//    private int itemStart;
//    private int itemSizePerPage;

	public InspectionLog() {
    }

    public InspectionLog(int memberNo, int facilityNo, String registrateDate, String modifiedDate, String note) {
        this.memberNo = memberNo;
        this.facilityNo = facilityNo;
        this.registrateDate = registrateDate;
        this.modifiedDate = modifiedDate;
        this.note = note;
    }
    
    public InspectionLog(int no, int memberNo, int facilityNo, String registrateDate, String modifiedDate, String note) {
    	this.no = no;
        this.memberNo = memberNo;
        this.facilityNo = facilityNo;
        this.registrateDate = registrateDate;
        this.modifiedDate = modifiedDate;
        this.note = note;
    }

    public List<InspectionLog> getInspectionLogList() {
		return inspectionLogList;
	}

	public void setInspectionLogList(List<InspectionLog> inspectionLogList) {
		this.inspectionLogList = inspectionLogList;
	}
	
    public void setNo(int inspectionLogNo) {
        this.no = inspectionLogNo;
    }

    public int getNo() {
        return this.no;
    }

    public void setMemberNo(int memberNo) {
        this.memberNo = memberNo;
    }

    public int getMemberNo() {
        return this.memberNo;
    }

    public void setFacilityNo(int facilityNo) {
        this.facilityNo = facilityNo;
    }

    public int getFacilityNo() {
        return this.facilityNo;
    }

    public void setRegistrateDate(String registrateDate) {
        this.registrateDate = registrateDate;
    }

    public String getRegistrateDate() {
        return this.registrateDate;
    }

    public void setModifiedDate(String modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public String getModifiedDate() {
        return this.modifiedDate;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getNote() {
        return this.note;
    }
}