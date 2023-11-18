package kr.ac.kopo.itnara.model;

public class Store {
	private Long userId;
	private String storeName;
	private int StoreZip;
	private String StoreAddress1;
	private String StoreAddress2;

	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public int getStoreZip() {
		return StoreZip;
	}
	public void setStoreZip(int storeZip) {
		StoreZip = storeZip;
	}
	public String getStoreAddress1() {
		return StoreAddress1;
	}
	public void setStoreAddress1(String storeAddress1) {
		StoreAddress1 = storeAddress1;
	}
	public String getStoreAddress2() {
		return StoreAddress2;
	}
	public void setStoreAddress2(String storeAddress2) {
		StoreAddress2 = storeAddress2;
	}
	
}
