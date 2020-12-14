package org.catty.photo;

import java.sql.Date;
import java.io.Serializable;

/**
 * @author dbsehdghks45@naver.com
*/
public class Photo implements Serializable {
    private int no;
    private String type;
    private int typeNo;
    private String logicalName;
    private String physicalName;
    private String path;

    private int itemStart;
    private int itemSizePerPage;

    public Photo() {
    }

    public Photo(int no, String type, int typeNo, String logicalName, String physicalName, String path, int itemStart, int itemSizePerPage) {
        this.no = no;
        this.type = type;
        this.typeNo = typeNo;
        this.logicalName = logicalName;
        this.physicalName = physicalName;
        this.path = path;

        this.itemStart = itemStart;
        this.itemSizePerPage = itemSizePerPage;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public int getNo() {
        return this.no;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getType() {
        return this.type;
    }

    public void setTypeNo(int typeNo) {
        this.typeNo = typeNo;
    }

    public int getTypeNo() {
        return this.typeNo;
    }

    public void setLogicalName(String logicalName) {
        this.logicalName = logicalName;
    }

    public String getLogicalName() {
        return this.logicalName;
    }

    public void setPhysicalName(String physicalName) {
        this.physicalName = physicalName;
    }

    public String getPhysicalName() {
        return this.physicalName;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getPath() {
        return this.path;
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