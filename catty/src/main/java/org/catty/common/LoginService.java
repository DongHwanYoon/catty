package org.catty.common;

public interface LoginService {
	public boolean login(LoginInfo loginInfo);
	public void logout();
}
