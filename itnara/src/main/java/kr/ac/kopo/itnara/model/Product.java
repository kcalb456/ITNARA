package kr.ac.kopo.itnara.model;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

public class Product {
private Long productId;
private Long userId;
private String userEmail;
private int category1Code;
private int category2Code;
private int productPrice;
private String productName;
private int productStock;
private int views;
private int productStatus;
@DateTimeFormat(pattern = "yyyy-MM-ddd")
private Date productDate;
private String productDetail;
private List<ProductImage> images;


public Long getProductId() {
	return productId;
}
public void setProductId(Long productId) {
	this.productId = productId;
}

public int getCategory1Code() {
	return category1Code;
}
public void setCategory1Code(int category1Code) {
	this.category1Code = category1Code;
}
public int getCategory2Code() {
	return category2Code;
}
public void setCategory2Code(int category2Code) {
	this.category2Code = category2Code;
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
public int getViews() {
	return views;
}
public void setViews(int views) {
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
@Override
public String toString() {
	return "Product [productId=" + productId + ", userId=" + userId + ", userEmail=" + userEmail + ", category1Code="
			+ category1Code + ", category2Code=" + category2Code + ", productPrice=" + productPrice + ", productName="
			+ productName + ", productStock=" + productStock + ", views=" + views + ", productStatus=" + productStatus
			+ ", productDate=" + productDate + ", productDetail=" + productDetail + "]";
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
public String getUserEmail() {
	return userEmail;
}
public void setUserEmail(String userEmail) {
	this.userEmail = userEmail;
}
public List<ProductImage> getImages() {
	return images;
}
public void setImages(List<ProductImage> images) {
	this.images = images;
}
}
