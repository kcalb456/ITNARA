<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="/css/style.css" type="text/css" />
    <script src="/js/price_format.js"></script>
    <script src="/js/category.js"></script>
    <title>Document</title>
  </head>
  <body>
    <jsp:include page="../header.jsp"></jsp:include>
    <div class="container">
      <jsp:include page="../search.jsp"></jsp:include>
      <section class="section-board row">
        <div class="filter">
          <ul class="accordion"></ul>
        </div>
        <div class="product-board">
          <c:forEach var="item" items="${list}">
            <a
              class="product-list"
              href="/store/${item.userId}/${item.productId}"
            >
              <div class="product-image">
                <img
                  class="img-full"
                  src="/upload/${item.images[0].uuid}_${item.images[0].imageName}"
                  alt="${item.images[0].imageName}"
                  onerror="handleImageError(this)"
                />
              </div>
              <div class="product-info">
                <div class="product-title">${item.productName}</div>
                <div class="product-detail">${item.productDetail}</div>
                <div class="product-price">
                  <div class="price">
                    ${item.productPrice}
                    <div>원</div>
                  </div>
                </div>
              </div>
            </a>
          </c:forEach>
        </div>
      </section>
    </div>
    <script>
      getCategory().then((result) => {
        // variables

        const categoryList = document.querySelector(".accordion");

        result.forEach((element) => {
          const li = document.createElement("li");
          li.classList.add("item");
          const h2 = document.createElement("h2");
          h2.classList.add("accordionTitle");
          const a = document.createElement("a");
          a.textContent = element.name;

          categoryList.appendChild(li);
          li.appendChild(h2);
          h2.appendChild(a);

          element.category2.forEach((category) => {
            const a2 = document.createElement("div");
            a2.textContent = category.name2;
            a2.classList.add("text");
            li.appendChild(a2);
          });
        });
        var accordionBtn = document.querySelectorAll(".accordionTitle");
        var allTexts = document.querySelectorAll(".text");
        // event listener
        accordionBtn.forEach(function (el) {
          el.addEventListener("click", toggleAccordion);
        });

        // function
        function toggleAccordion(el) {
          var targetTexts =
            el.currentTarget.parentNode.querySelectorAll(".text");
          var target = el.currentTarget;

          console.log(targetTexts);

          accordionBtn.forEach(function (btn) {
            if (btn != target) {
              btn.classList.remove("accordionTitleActive");
            }
          });

          targetTexts.forEach(function (text) {
            if (text.classList.contains("show")) {
              text.classList.remove("show");
              target.classList.remove("accordionTitleActive");
            } else {
              text.classList.add("show");
              target.classList.add("accordionTitleActive");
            }
          });
        }
      });
    </script>
  </body>
</html>
