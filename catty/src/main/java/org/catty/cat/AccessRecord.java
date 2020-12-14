package org.catty.cat;

import java.sql.Date;
import java.io.Serializable;

/**
 * @author dbsehdghks45@naver.com
*/
public class AccessRecord implements Serializable {
    private int no;
    private String accessTime;
    private int catNo;
    private int facilityNo;

    private int itemStart;
    private int itemSizePerPage;

    public AccessRecord() {
    }

    public AccessRecord(int no, String accessTime, int catNo, int facilityNo, int itemStart, int itemSizePerPage) {
        this.no = no;
        this.accessTime = accessTime;
        this.catNo = catNo;
        this.facilityNo = facilityNo;

        this.itemStart = itemStart;
        this.itemSizePerPage = itemSizePerPage;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public int getNo() {
        return this.no;
    }

    public void setAccessTime(String accessTime) {
        this.accessTime = accessTime;
    }

    public String getAccessTime() {
        return this.accessTime;
    }

    public void setCatNo(int catNo) {
        this.catNo = catNo;
    }

    public int getCatNo() {
        return this.catNo;
    }

    public void setFacilityNo(int facilityNo) {
        this.facilityNo = facilityNo;
    }

    public int getFacilityNo() {
        return this.facilityNo;
    }

    public void setItemStart(int itemStart) {
        this.itemStart = itemStart;
    }

    public int getItemStart() {
        return this.itemStart;
    }

    public void setItemSizePerPage(int itemSizePerPage) {
        this.itemSizePerPage = itemSizePerPage;
    }

    public int getItemSizePerPage() {
        return this.itemSizePerPage;
    }
}