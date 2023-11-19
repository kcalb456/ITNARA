<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../header.jsp"></jsp:include>
<meta charset="UTF-8" />
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div>상점명: ${item.storeName }</div>
		<c:if test="${item.userId eq sessionScope.member.userId}">
			<a href="/products/new">상품 등록</a>
		</c:if>
		<c:forEach var="item" items="${list}">
			<div class="product">
				<a href="/store/${item.userId}/${item.productId}">
					<div class="privew-image">
						<img class="img-full"
							src="/upload/${item.images[0].uuid}_${item.images[0].imageName}"
							alt="${item.images[0].imageName}"
							onerror="handleImageError(this)" />
					</div>
					<div class="privew-info">
						<div class="privew-title">${item.productName}</div>
						<div class="privew-price">
							<div class="price">${item.productPrice }</div>
							<div>원</div>
						</div>
					</div>
				</a>
			</div>
		</c:forEach>
	</div>
</body>
</html>
