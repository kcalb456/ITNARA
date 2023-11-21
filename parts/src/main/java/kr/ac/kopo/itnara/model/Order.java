package kr.ac.kopo.itnara.model;

import java.util.Date;

public class Order {
 private Long orderId;
 private Long productId;
 
 public Long getOrderId() {
	return orderId;
}
public void setOrderId(Long orderId) {
	this.orderId = orderId;
}
public Long getUserId() {
	return userId;
}
public void setUserId(Long userId) {
	this.userId = userId;
}
public Long getUserId2() {
	return userId2;
}
public void setUserId2(Long userId2) {
	this.userId2 = userId2;
}
public int getZip() {
	return zip;
}
public void setZip(int zip) {
	this.zip = zip;
}
public String getAddress1() {
	return address1;
}
public void setAddress1(String address1) {
	this.address1 = address1;
}
public String getAddress2() {
	return address2;
}
public void setAddress2(String address2) {
	this.address2 = address2;
}
public Date getSaleDate() {
	return saleDate;
}
public void setSaleDate(Date saleDate) {
	this.saleDate = saleDate;
}
private Long userId;
 private Long userId2;
 private int zip;
 private String address1;
 private String address2;
 private Date saleDate;
public Long getProductId() {
	return productId;
}
public void setProductId(Long productId) {
	this.productId = productId;
}

}
