package org.catty.observationlog;

import java.sql.Date;
import java.io.Serializable;

/**
 * @author dbsehdghks45@naver.com
*/
public class ObservationLog implements Serializable {
    private int no;
    private int memberNo;
    private int catNo;
    private String registrateDate;
    private String modifiedDate;
    private String note;

    private int itemStart;
    private int itemSizePerPage;

    public ObservationLog() {
    }

    public ObservationLog(int no, int memberNo, int catNo, String registrateDate, String modifiedDate, String note, int itemStart, int itemSizePerPage) {
        this.no = no;
        this.memberNo = memberNo;
        this.catNo = catNo;
        this.registrateDate = registrateDate;
        this.modifiedDate = modifiedDate;
        this.note = note;

        this.itemStart = itemStart;
        this.itemSizePerPage = itemSizePerPage;
    }

    public void setNo(int no) {
        this.no = no;
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

    public void setCatNo(int catNo) {
        this.catNo = catNo;
    }

    public int getCatNo() {
        return this.catNo;
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