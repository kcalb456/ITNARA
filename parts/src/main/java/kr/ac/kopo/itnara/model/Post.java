package kr.ac.kopo.itnara.model;

import java.util.Date;

public class Post {
	private Long postId;
	private Long subId;
	private Long userId;
	private String postHeader;
	private String postDetail;
	private Date postDate;
	private Long postView;
	public Long getPostId() {
		return postId;
	}
	public void setPostId(Long postId) {
		this.postId = postId;
	}
	public Long getSubId() {
		return subId;
	}
	public void setSubId(Long subId) {
		this.subId = subId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getPostHeader() {
		return postHeader;
	}
	public void setPostHeader(String postHeader) {
		this.postHeader = postHeader;
	}
	public String getPostDetail() {
		return postDetail;
	}
	public void setPostDetail(String postDetail) {
		this.postDetail = postDetail;
	}
	public Date getPostDate() {
		return postDate;
	}
	public void setPostDate(Date postDate) {
		this.postDate = postDate;
	}
	public Long getPostView() {
		return postView;
	}
	public void setPostView(Long postView) {
		this.postView = postView;
	}
}
