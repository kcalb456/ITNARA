package kr.ac.kopo.itnara.model;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

public class Product {
private Long productId;
private Long userId;
private String name;
private String name2;
private int productPrice = 0;
private String productName;
private int productStock = 1;
private long views;
private int productStatus;
@DateTimeFormat(pattern = "yyyy-MM-ddd")
private Date productDate;
private String productDetail;
private List<ProductImage> images;
private int soldCheck;
private long likesCount = 0;
private int deliveryPrice = 0;


public Long getProductId() {
	return productId;
}
public void setProductId(Long productId) {
	this.productId = productId;
}



public String getProductName() {
	return productName;
}
public void setProductName(String productName) {
	this.productName = productName;
}
public int getProductStock() {
	return productStock;
}
public void setProductStock(int productStock) {
	this.productStock = productStock;
}
public long getViews() {
	return views;
}
public void setViews(long views) {
	this.views = views;
}
public int getProductStatus() {
	return productStatus;
}
public void setProductStatus(int productStatus) {
	this.productStatus = productStatus;
}
public Date getProductDate() {
	return productDate;
}
public void setProductDate(Date productDate) {
	this.productDate = productDate;
}
public String getProductDetail() {
	return productDetail;
}

public void setProductDetail(String productDetail) {
	this.productDetail = productDetail;
}
public Long getUserId() {
	return userId;
}
public void setUserId(Long userId) {
	this.userId = userId;
}
public int getProductPrice() {
	return productPrice;
}
public void setProductPrice(int productPrice) {
	this.productPrice = productPrice;
}
public List<ProductImage> getImages() {
	return images;
}
public void setImages(List<ProductImage> images) {
	this.images = images;
}
public String getName2() {
	return name2;
}
public void setName2(String name2) {
	this.name2 = name2;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public int getSoldCheck() {
	return soldCheck;
}
public void setSoldCheck(int soldCheck) {
	this.soldCheck = soldCheck;
}
@Override
public String toString() {
	return "Product [productId=" + productId + ", userId=" + userId + ", name=" + name + ", name2=" + name2
			+ ", productPrice=" + productPrice + ", productName=" + productName + ", productStock=" + productStock
			+ ", views=" + views + ", productStatus=" + productStatus + ", productDate=" + productDate
			+ ", productDetail=" + productDetail + ", images=" + images + ", soldCheck=" + soldCheck + "]";
}

public int getDeliveryPrice() {
	return deliveryPrice;
}
public void setDeliveryPrice(int deliveryPrice) {
	this.deliveryPrice = deliveryPrice;
}
public long getLikesCount() {
	return likesCount;
}
public void setLikesCount(long likesCount) {
	this.likesCount = likesCount;
}
}
