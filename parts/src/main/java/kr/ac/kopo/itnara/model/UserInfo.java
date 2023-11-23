package kr.ac.kopo.itnara.model;

public class UserInfo {
	private Long userId;
	private Long countSell;
	private Long countPurchase;
	private Long countLike;
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Long getCountSell() {
		return countSell;
	}
	public void setCountSell(Long countSell) {
		this.countSell = countSell;
	}
	public Long getCountPurchase() {
		return countPurchase;
	}
	public void setCountPurchase(Long countPurchase) {
		this.countPurchase = countPurchase;
	}
	public Long getCountLike() {
		return countLike;
	}
	public void setCountLike(Long countLike) {
		this.countLike = countLike;
	}
}
