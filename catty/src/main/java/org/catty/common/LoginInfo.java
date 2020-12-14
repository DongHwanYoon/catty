package org.catty.common;

import java.io.Serializable;

public class LoginInfo implements Serializable {
	private String id;
	private String pwd;
	private boolean isRemember;
	
	public LoginInfo() {
	}
	
	public LoginInfo(String id, String pwd, boolean isRemember) {
		this.id = id;
		this.pwd = pwd;
		this.isRemember = isRemember;
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

	public boolean isRemember() {
		return isRemember;
	}

	public void setRemember(boolean isRemember) {
		this.isRemember = isRemember;
	}
}