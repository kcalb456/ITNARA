<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
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
      <div class="store-product-list"></div>
    </div>
    <script>
      window.addEventListener("DOMContentLoaded", function () {
        // 현재 URL의 경로를 가져오기
        var path = window.location.pathname;

        // 경로에서 userId 추출하기
        var userIdMatch = path.match(/\/store\/(\d+)/);

        // userId가 존재하면 값을 추출
        var userId = userIdMatch ? userIdMatch[1] : null;

        if (userId) {
          fetch("/api/store/" + userId, {
            method: "GET",
            headers: {
              "Content-Type": "application/json",
            },
          })
            .then((resp) => {
              if (!resp.ok) {
                throw new Error(`HTTP error! Status: ${resp.status}`);
              }
              return resp.json();
            })
            .then((result) => {
              console.log(result);

              const productList = document.querySelector(".store-product-list");

              // 모든 "product" 요소를 제거 (첫 번째 요소를 제외하고)
              productList
                .querySelectorAll(".product")
                .forEach((item, index) => {
                  if (index !== 0) {
                    item.remove();
                  }
                });

              // API 응답에서 가져온 각 항목에 대해 새 "product" 요소를 생성하고 추가
              result.list.forEach((item) => {
                const div = document.createElement("div");
                div.classList.add("product");

                const div2 = document.createElement("div");
                div2.classList.add("preview-image");

                // "a" 요소를 생성하고 href 속성을 설정
                const a = document.createElement("a");
                const img = document.createElement("img");

                const div3 = document.createElement("div");
                div3.classList.add("privew-info");
                const div4 = document.createElement("div");
                div4.classList.add("privew-title");
                div4.textContent = item.productName;
                const div5 = document.createElement("div");
                div5.classList.add("privew-price");
                const div6 = document.createElement("div");
                div6.classList.add("price");
                div6.textContent = item.productPrice;
                const div7 = document.createElement("div");
                div7.textContent = "원";

                a.href = "/store/" + item.userId + "/" + item.productId;

                img.classList = "img-full";
                img.src =
                  "/upload/" +
                  item.images[0].uuid +
                  "_" +
                  item.images[0].imageName;
                img.alt = item.images[0].imageName;
                img.onerror = () => handleImageError(img);

                // 여기서 내용(content)이나 다른 속성을 "a" 요소에 추가할 수 있음
                // 예를 들어, 내용을 추가하려면:
                // a.textContent = item.name;

                // "a" 요소를 "div"에 추가
                div.appendChild(a);
                a.appendChild(div2);
                a.appendChild(div3);
                div3.appendChild(div4);
                div3.appendChild(div5);
                div5.appendChild(div6);
                div5.appendChild(div7);
                div2.appendChild(img);

                // "div"를 ".store-product-list"에 추가
                productList.appendChild(div);
              });
            });
        }
      });
    </script>
  </body>
</html>
