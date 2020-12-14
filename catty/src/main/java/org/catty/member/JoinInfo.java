package org.catty.member;

import java.io.Serializable;

public class JoinInfo implements Serializable {
	private int no;
	private String id;
    private String pwd;
    private String name;
    private String phoneNo;
    private String authority;
    
    public JoinInfo() {
    }
    
    public JoinInfo(int no, String id, String pwd, String name, String phoneNo, String authority) {
		this.no = no;
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.phoneNo = phoneNo;
		this.authority = authority;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}
}