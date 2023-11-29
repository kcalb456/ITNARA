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
    <title>Document</title>
  </head>
  <body>
    <jsp:include page="../header.jsp"></jsp:include>
    <div class="container">
      <jsp:include page="../search.jsp"></jsp:include>
      <section class="section-board row">
        <div class="filter">
          <ul class="accordion">
            <li class="item">
              <h2 class="accordionTitle">
                London <span class="accIcon"></span>
              </h2>
              <div class="text">
                London is the capital and largest city of England, the United
                Kingdom, and the European Union. Standing on the River Thames in
                southeastern England, at the head of its 50-mile (80 km) estuary
                leading to the North Sea, London has been a major settlement for
                two millennia.
              </div>
            </li>
            <li class="item">
              <h2 class="accordionTitle">
                Madrid <span class="accIcon"></span>
              </h2>
              <div class="text">
                Madrid is the capital of Spain and the largest municipality in
                both the Community of Madrid and Spain as a whole. The city has
                almost 3.2 million inhabitants and a metropolitan area
                population of approximately 6.5 million.
              </div>
            </li>
            <li class="item">
              <h2 class="accordionTitle">
                Paris <span class="accIcon"></span>
              </h2>
              <div class="text">
                Paris is the capital and most populous city of France, with an
                area of 105 square kilometres (41 square miles) and a population
                of 2,206,488. Since the 17th century, Paris has been one of
                Europe's major centres of finance, commerce, fashion, science,
                and the arts.
              </div>
            </li>
            <li class="item">
              <h2 class="accordionTitle">
                Barcelona <span class="accIcon"></span>
              </h2>
              <div class="text">
                Barcelona is a city in Spain. It is the capital and largest city
                of Catalonia, as well as the second most populous municipality
                of Spain. With a population of 1.6 million within city limits,
                its urban area extends to numerous neighbouring municipalities
                within the Province of Barcelona and is home to around 4.8
                million people.
              </div>
            </li>
            <li class="item">
              <h2 class="accordionTitle">
                Milan <span class="accIcon"></span>
              </h2>
              <div class="text">
                Milan is a city in northern Italy, capital of Lombardy, and the
                second-most populous city in Italy after Rome, with the city
                proper having a population of 1,372,810 while its metropolitan
                area has a population of 3,242,820.
              </div>
            </li>
          </ul>
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
      fetch("/api/");

      // variables
      var accordionBtn = document.querySelectorAll(".accordionTitle");
      var allTexts = document.querySelectorAll(".text");

      // event listener
      accordionBtn.forEach(function (el) {
        el.addEventListener("click", toggleAccordion);
      });

      // function
      function toggleAccordion(el) {
        var targetText = el.currentTarget.nextElementSibling.classList;
        var target = el.currentTarget;

        if (targetText.contains("show")) {
          targetText.remove("show");
          target.classList.remove("accordionTitleActive");
        } else {
          accordionBtn.forEach(function (el) {
            el.classList.remove("accordionTitleActive");

            allTexts.forEach(function (el) {
              el.classList.remove("show");
            });
          });

          targetText.add("show");
          target.classList.add("accordionTitleActive");
        }
      }
    </script>
  </body>
</html>
