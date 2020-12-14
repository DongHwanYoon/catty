package org.catty.cat;

import java.io.Serializable;
import java.sql.Date;
import java.time.LocalDateTime;

/**
 * @author dbsehdghks45@naver.com
*/
public class Cat implements Serializable {
    private int no;
    private String name;
    private String tagId;
    private String gender;
    private String spices;
    private String birthDate;
    private String feature;
    private String tnrStatus;

    private int itemStart;
    private int itemSizePerPage;

    public Cat() {
    }

    public Cat(int no, String name, String tagId, String gender, String spices, String birthDate, String feature, String tnrStatus, int itemStart, int itemSizePerPage) {
        this.no = no;
        this.name = name;
        this.tagId = tagId;
        this.gender = gender;
        this.spices = spices;
        this.birthDate = birthDate;
        this.feature = feature;
        this.tnrStatus = tnrStatus;

        this.itemStart = itemStart;
        this.itemSizePerPage = itemSizePerPage;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public int getNo() {
        return this.no;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }

    public void setTagId(String tagId) {
        this.tagId = tagId;
    }

    public String getTagId() {
        return this.tagId;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getGender() {
        return this.gender;
    }

    public void setSpices(String spices) {
        this.spices = spices;
    }

    public String getSpices() {
        return this.spices;
    }

    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    public String getBirthDate() {
        return this.birthDate;
    }

    public void setFeature(String feature) {
        this.feature = feature;
    }

    public String getFeature() {
        return this.feature;
    }

    public void setTnrStatus(String tnrStatus) {
        this.tnrStatus = tnrStatus;
    }

    public String getTnrStatus() {
        return this.tnrStatus;
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