package kr.ac.kopo.itnara.model;

public class User {
	private Long userId;
	private String email;
	private String passwd;
	private String nickName;
	private int verify;
	private int enabled;
	private int roll;
	private String authority;
	@Override
	public String toString() {
		return "User [userId=" + userId + ", email=" + email + ", passwd=" + passwd + ", nickName=" + nickName
				+ ", verify=" + verify + ", enabled=" + enabled + ", roll=" + roll + "auth" + authority +"]";
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public int getVerify() {
		return verify;
	}
	public void setVerify(int verify) {
		this.verify = verify;
	}

	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
}
