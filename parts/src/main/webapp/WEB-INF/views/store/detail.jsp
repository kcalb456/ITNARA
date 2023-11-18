<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
  </head>
  <body>
    <jsp:include page="../header.jsp"></jsp:include>
    <div class="container">
      <section>
        <div class="title">
          <div class="product-name">${product.productName}</div>
          <div class="product-date">${product.productDate}</div>
        </div>
        <div class="info">
          <div class="first-image">
            <img
              class="img-full"
              src="/upload/${product.images[0].uuid}_${product.images[0].imageName}"
              alt="${image.imageName}"
              onerror="handleImageError(this)"
            />
          </div>
          <div class="main">
            <button class="long-button c-blue">안전결제</button>
          </div>
        </div>
        <!--
        <c:forEach var="image" items="${product.images}">
          <li>
            <img
              src="/upload/${image.uuid}_${image.imageName}"
              alt="${image.imageName}"
            />
          </li>
        </c:forEach> -->
      </section>
      <section>${product.productDetail}</section>
    </div>
  </body>
</html>
