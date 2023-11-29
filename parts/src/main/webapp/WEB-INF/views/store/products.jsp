<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<!DOCTYPE html>
<html>
  <head>
    <jsp:include page="../header.jsp"></jsp:include>
    <meta charset="UTF-8" />
    <title>상점</title>
    <script defer src="/js/price_format.js"></script>
    <script src="/js/card_ui.js"></script>
    <link rel="stylesheet" href="/css/butterup.min.css" />
    <script src="/js/butterup.min.js"></script>
  </head>
  <body>
    <div class="container">
      <section class="section-profile">
        <div class="profile">
          <div class="profile-img">
            <img
              class="img-full"
              src="/"
              alt="프로필 사진"
              onerror="handleImageError(this)"
            />
          </div>
          <div class="profile-name"></div>
        </div>
        <div class="section-profile-info">
          <h2>소개</h2>
          <p>
            - 이러쿵 저러쿵 하지 않는 쿨거래 선호합니다. - 입금, 결제 후 1~5시간
            이내 택배 접수해드립니다. - 사기, 허위 매물 혐오합니다. 그래서
            하지도 않습니다.
          </p>
        </div>
      </section>
      <section>
        <div class="row center">
          <button onclick="getList()">상품</button>
          <button onclick="ratingList()">상점후기</button>
          <button onclick="orderList()">주문확인</button>
          <button onclick="purchaseList()">구매내역</button>
        </div>
        <div class="store-product-list"></div>
      </section>
    </div>

    <div class="modal"><div class="modal_body"></div></div>
    <script>
      var soldCheck = 99;
      var userId;
      let orderInfo;

      window.addEventListener("DOMContentLoaded", function () {
        var path = window.location.pathname;

        // 경로에서 userId 추출하기
        var userIdMatch = path.match(/\/store\/(\d+)/);

        // userId가 존재하면 값을 추출
        userId = userIdMatch ? userIdMatch[1] : null;

        getList();
      });

      function orderList() {
        const url = "/api/store/order?userId=" + userId;
        if (userId) {
          fetch(url, {
            method: "GET",
            headers: {
              "Content-Type": "application/json",
            },
            // query string을 사용하여 userId를 전달합니다.
          })
            .then((resp) => {
              if (!resp.ok) {
                throw new Error(`HTTP error! status: ` + resp.status);
              }
              return resp.json();
            })
            .then((result) => {
              orderInfo = result;
              console.log(result);
              orderListUI(result);
            })
            .catch((error) => {
              console.error("Error fetching /api/store/order:", error.message);
            });
        }
      }

      function purchaseList() {
        const url = "/api/store/order/purchase?userId=" + userId;
        if (userId) {
          fetch(url, {
            method: "GET",
            headers: {
              "Content-Type": "application/json",
            },
            // query string을 사용하여 userId를 전달합니다.
          })
            .then((resp) => {
              if (!resp.ok) {
                throw new Error(`HTTP error! status: ` + resp.status);
              }
              return resp.json();
            })
            .then((result) => {
              orderInfo = result;
              console.log(result);
              orderListUI(result);
            })
            .catch((error) => {
              console.error("Error fetching /api/store/order:", error.message);
            });
        }
      }

      function ratingList() {
        const productList = document.querySelector(".store-product-list");

        // 모든 "product" 요소를 제거
        productList.querySelectorAll(".product").forEach((item, index) => {
          item.remove();
        });
      }

      function getList() {
        const url = "/api/store/" + userId;
        if (userId) {
          fetch(url, {
            method: "GET",
            headers: {
              "Content-Type": "application/json",
            },
          })
            .then((resp) => {
              if (!resp.ok) {
                throw new Error(`HTTP error! Status: ` + resp.status);
              }
              return resp.json();
            })
            .then((result) => {
              console.log(result);
              document.querySelector(".profile-name").textContent =
                result.item.storeName;
              result = result.list;
              listUI(result); //listUI 함수에 전달
              // API 응답에서 가져온 각 항목에 대해 새 "product" 요소를 생성하고 추가
            });
        }
      }

      function orderListUI(result) {
        // 어느 태그에 이 UI를 붙일지 선택
        const productList = document.querySelector(".store-product-list");

        // 모든 "product" 요소를 제거
        productList.querySelectorAll(".product").forEach((item, index) => {
          item.remove();
        });

        result.forEach((item) => {
          const div = document.createElement("div");
          div.classList.add("product");

          const div2 = document.createElement("div");
          div2.classList.add("preview-image");

          // "a" 요소를 생성하고 href 속성을 설정
          const a = document.createElement("a");
          a.classList.add("orderBtn");
          a.id = item.productId;
          div.onclick = () => modal(a.id);

          const div3 = document.createElement("div");
          div3.classList.add("preview-info");
          const div4 = document.createElement("div");
          div4.classList.add("privew-title");
          div4.textContent = item.productName;
          const div5 = document.createElement("div");
          div5.classList.add("preview-price");
          const div6 = document.createElement("div");
          div6.classList.add("price");
          div6.textContent = item.productPrice;
          const div7 = document.createElement("div");
          div7.textContent = "원";

          // 이미지 처리를 위한 코드
          const img = document.createElement("img");
          img.classList = "img-full";
          img.src =
            "/upload/" + item.images[0].uuid + "_" + item.images[0].imageName;
          img.alt = item.images[0].imageName;
          img.onerror = () => handleImageError(img);
          div2.appendChild(img);

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

          console.log(item.userId + "" + userId);

          if (item.tracking == null && item.userId2 != userId) {
            div.classList.add(
              "product",
              "animate__animated",
              "animate__pulse",
              "animate__infinite"
            );
          } else {
            div.classList.add("product");
          }

          // "div"를 ".store-product-list"에 추가
          productList.appendChild(div);
        });
        priceFomatter();
      }
    </script>

    <jsp:include page="history/sell.jsp"></jsp:include>
  </body>
</html>
