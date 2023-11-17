<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="/css/style.css" type="text/css" />
    <title>Document</title>
  </head>
  <body>
    <jsp:include page="../header.jsp"></jsp:include>
    <div class="container">
      <jsp:include page="../search.jsp"></jsp:include>
      <section class="section-board row">
        <div class="filter">testtest</div>
        <div class="product-bard">
          <c:forEach var="item" items="${list}">
            <a
              class="product-list"
              href="/store/${item.userId}/${item.productId}"
            >
              <div class="product-image">이미지</div>
              <div class="product-info">${item.productName}</div>
            </a>
          </c:forEach>
        </div>
      </section>
    </div>
    <script>
      window.onload = function () {
        urlSearch = new URLSearchParams(location.search);
        searchText = urlSearch.get("search");
        document.getElementById("search").value = searchText;
      };
    </script>
  </body>
</html>
