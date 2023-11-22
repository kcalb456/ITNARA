<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<!DOCTYPE html>
<html>
  <head>
    <jsp:include page="../header.jsp"></jsp:include>
    <meta charset="UTF-8" />
    <title>상점</title>
    <script src="/js/price_format.js"></script>
    <script src="/js/card_ui.js"></script>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"
    />
  </head>
  <body>
    <div class="container">
      <section>
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
      </section>
      <section>
        <div class="row center">
          <button onclick="getList()">상품</button>
          <button onclick="">상점후기</button>
          <button onclick="orderList()">주문확인</button>
          <button onclick="">구매내역</button>
        </div>
      </section>
      <section>
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

        result.orders.forEach((item, index) => {
          const div = document.createElement("div");
          div.classList.add("product");

          const div2 = document.createElement("div");
          div2.classList.add("preview-image");

          // "a" 요소를 생성하고 href 속성을 설정
          const a = document.createElement("div");
          a.classList.add("orderBtn");
          a.id = result.products[index].productId;
          div.onclick = () => modal(a.id);

          const div3 = document.createElement("div");
          div3.classList.add("privew-info");
          const div4 = document.createElement("div");
          div4.classList.add("privew-title");
          div4.textContent = result.products[index].productName;
          const div5 = document.createElement("div");
          div5.classList.add("privew-price");
          const div6 = document.createElement("div");
          div6.classList.add("price");
          div6.textContent = result.products[index].productPrice;
          const div7 = document.createElement("div");
          div7.textContent = "원";

          // 이미지 처리를 위한 코드
          const img = document.createElement("img");
          img.classList = "img-full";
          img.src =
            "/upload/" +
            result.products[index].uuid +
            "_" +
            result.products[index].images[0].imageName;
          img.alt = result.products[index].images[0].imageName;
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

          if (result.products[index].traking == null) {
            div.classList.add(
              "product",
              "animate__animated",
              "animate__bounce",
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
    <script>
      function modal(id) {
        const order = document.querySelector(".order");
        const modalBody = document.querySelector(".modal_body");
        order.classList.toggle("show");
        console.log(orderInfo);

        const orderList = orderInfo.orders.find(
          (order) => order.productId == id
        );

        const productList = orderInfo.products.find(
          (product) => product.productId == id
        );

        document.querySelector(".orderId").textContent = orderList.orderId;
        document.querySelector(".orderDate").textContent = orderList.orderDate;
        document.querySelector(".productName").textContent =
          productList.productName;

        order.addEventListener("click", (e) => {
          if (e.target.classList.contains("modal_body")) {
            e.stopPropagation();
          } else {
            if (e.target.classList.contains("order")) {
              order.classList.remove("show");
            }
          }
        });
      }
    </script>

    <div class="modal order">
      <div id="order-form" class="modal_body">
        <div>
          <div class="order-title">
            <h2>거래정보</h2>
          </div>
          <div class="order-number">
            <div>
              <label>거래번호 : </label>
              <div class="orderId"></div>
            </div>
            <div class="orderDate"></div>
          </div>
          <div class="productName"></div>
          <div class="inputbar">
            <input class="input_inner" /><label class="input_label"
              >송장번호 입력</label
            >
          </div>
          <button class="long-button c-blue">확인</button>
        </div>
      </div>
    </div>
  </body>
</html>
