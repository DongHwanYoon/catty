package org.catty.member;

import java.sql.Date;
import java.io.Serializable;

/**
 * @author dbsehdghks45@naver.com
*/
public class Member implements Serializable {
    private int no;
    private String id;
    private String pwd;
    private String name;
    private String phoneNo;
    private String authority;

    public Member() {
    }

    public Member(int no, String id, String pwd, String name, String phoneNo, String authority) {
        this.no = no;
        this.id = id;
        this.pwd = pwd;
        this.name = name;
        this.phoneNo = phoneNo;
        this.authority = authority;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public int getNo() {
        return this.no;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId() {
        return this.id;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getPwd() {
        return this.pwd;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getPhoneNo() {
        return this.phoneNo;
    }

    public void setAuthority(String authority) {
        this.authority = authority;
    }

    public String getAuthority() {
        return this.authority;
    }

	@Override
	public String toString() {
		return "Member [no=" + no + ", id=" + id + ", pwd=" + pwd + ", name=" + name + ", phoneNo=" + phoneNo
				+ ", authority=" + authority + "]";
	}
}