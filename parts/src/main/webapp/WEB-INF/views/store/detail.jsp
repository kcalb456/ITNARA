<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%> <%@ taglib uri="http://www.springframework.org/security/tags"
prefix="sec"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <script src="/js/price_format.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@fancyapps/ui@5.0/dist/fancybox/fancybox.umd.js"></script>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/@fancyapps/ui@5.0/dist/fancybox/fancybox.css"
    />
  </head>
  <body>
    <jsp:include page="../header.jsp"></jsp:include>
    <div class="container animate__fadeIn animate__animated">
      <section>
        <div class="detail-title">
          <div class="product-name productName"></div>
          <div class="product-date productDate"></div>
        </div>
        <div class="info">
          <div class="big-image">
            <a
              class="img-full"
              href=""
              data-fancybox="gallery"
              data-caption="${image.imageName}"
            >
              <img
                class="img-full"
                src=""
                alt="${image.imageName}"
                onerror="handleImageError(this)"
              />
            </a>
          </div>
          <div class="main">
            <div class="detail-form">
              <div class="detail-header">
                <div class="product-other-info">
                  <i class="bi-eyeglasses"><div class="views"></div></i
                  ><i class="bi-heart"><div class="likes"></div></i>
                </div>
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
                <div>
                  <button class="not-likes" onclick="likesButton(this)">
                    <i class="bi-heart font32"></i>
                  </button>
                </div>
              </div>
              <div class="detail-condition">
                <label>상품상태</label>
                <div class="productStatus"></div>
              </div>
              <div class="detail-stock">
                <label>수량</label>
                <div class="productStock"></div>
              </div>
              <div class="detail-delivery-price">
                <label>배송비</label>
                <div class="deliveryPrice"></div>
              </div>
              <div class="detail-address">
                <label>거래지역</label>
                <div class="productTradeAddress"></div>
              </div>
              <div class="detail-price">
                <div class="price"></div>
                <div>원</div>
              </div>
            </div>
            <div class="buttons">
              <sec:authentication property="principal" var="prc" />
              <sec:authorize access="isAuthenticated()">
                <a class="long-button c-orange" href="${productId}/update"
                  >변경</a
                >
                <button
                  class="long-button c-blue"
                  onclick="deleteThisProduct()"
                >
                  삭제
                </button>
              </sec:authorize>
            </div>
          </div>
        </div>
      </section>
      <section class="detail-bottom">
        <div class="detail-info">
          <h1>상세 설명</h1>
          <div class="detail"></div>
        </div>
        <div class="store-more">
          <label class="detail-title">판매자의 다른 상품</label>
          <a href="#">
            <div class="preview-image">
              <img
                class="img-full"
                src="/img"
                onerror="handleImageError(this)"
              />
            </div>
          </a>
        </div>
      </section>
    </div>
    <script>
      Fancybox.bind("[data-fancybox]", {
        // Your custom options
      });
    </script>
    <script>
      window.addEventListener("DOMContentLoaded", function () {
        var path = window.location.pathname;

        // 경로에서 userId 추출하기
        var userIdMatch = path.match(/\/store\/(\d+)/);
        var productIdMatch = path.match(/(\d+)$/);

        // userId가 존재하면 값을 추출
        userId = userIdMatch ? userIdMatch[1] : null;
        productId = productIdMatch ? productIdMatch[1] : null;

        getThisItem();
        getThisStore();
      });

      async function deleteThisProduct() {
        const csrfHeader = document.querySelector(
          'meta[name="_csrf_header"]'
        ).content;
        const csrfToken = document.querySelector('meta[name="_csrf"]').content;

        if (productId) {
          try {
            const response = await fetch(
              `/api/product/delete/` + userId + `?productId=` + productId,
              {
                method: "DELETE",
                headers: {
                  [csrfHeader]: csrfToken,
                  "Content-Type": "application/json",
                },
              }
            );

            if (!response.ok) {
              throw new Error(`HTTP error! Status: ` + response.status);
            }

            await response.text(); // 응답 텍스트를 소비
          } catch (error) {
            Swal.fire({
              title: "삭제 불가",
              text: "판매 된 물품은 삭제가 불가능 합니다.",
              icon: "error",
              confirmButtonColor: "#0080ff",
            });
            console.error("Error:", error.message);
          }
        }
      }

      let LikeStatus;

      function getThisItem() {
        const url = "/api/product?productId=" + productId;

        if (productId) {
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
              LikeStatus = result.likes;
              console.log(result);
              document.querySelector(".views").textContent = result.item.views;
              document.querySelector(".likes").textContent =
                result.item.likesCount;
              document.querySelector(".price").textContent =
                result.item.productPrice;
              document.querySelector(".detail").textContent =
                result.item.productDetail;

              document.querySelector(".productName").textContent =
                result.item.productName;
              document.querySelector(".productDate").textContent =
                result.item.productDate;

              const bigImage = document.querySelector(".big-image");

              result.item.images.forEach((item) => {
                const a = document.createElement("a");

                a.classList.add("img-full");
                a.dataset.fancybox = "gallery";
                a.dataset.caption = item.imageName;
                a.href = "/upload/" + item.uuid + "_" + item.imageName;

                const img = document.createElement("img");
                bigImage.appendChild(a);
                a.appendChild(img);

                const button = document.querySelector(
                  ".detail-header div button"
                );
                const heartIcon = button.querySelector("i");

                if (result.likes == null || !sessionStorage.getItem("userId")) {
                  button.classList.replace("likes", "not-likes");
                  heartIcon.classList.replace("bi-heart-fill", "bi-heart");
                } else {
                  button.classList.replace("not-likes", "likes");
                  heartIcon.classList.replace("bi-heart", "bi-heart-fill");
                }
              });

              switch (result.item.productStatus) {
                case 0:
                  document.querySelector(".productStatus").textContent =
                    "새 상품";
                  break;
                case 1:
                  document.querySelector(".productStatus").textContent = "중고";
                  break;

                default:
              }

              document.querySelector(".productStock").textContent =
                result.item.productStock;

              if (result.item.deliveryPrice == 0) {
                document.querySelector(".deliveryPrice").textContent =
                  "무료배송";
              } else {
                document.querySelector(".deliveryPrice").textContent =
                  result.item.deliveryPrice;
              }

              document.querySelector(".big-image a").href =
                "/upload/" +
                result.item.images[0].uuid +
                "_" +
                result.item.images[0].imageName;

              document.querySelector(".big-image img").src =
                "/upload/" +
                result.item.images[0].uuid +
                "_" +
                result.item.images[0].imageName;
              document.querySelector(".big-image img").dataset.caption =
                result.item.images[0].imageName;

              document.title = result.item.productName;
              productEditButton(result);
              priceFomatter();
            })
            .catch((error) => {
              console.error("Error fetching /api/product:", error.message);
            });
        }
      }
      function payButton() {
        var path = window.location.pathname;

        // 경로에서 userId와 productId 추출하기 (예: /store/123/456)
        var matches = path.match(/\/store\/(\d+)\/(\d+)/);

        // matches 배열에서 userId와 productId 추출
        var userId = matches ? matches[1] : null;
        var productId = matches ? matches[2] : null;

        if (!sessionStorage.getItem("userId")) {
          LoginModal();
        } else {
          window.location.href =
            "/store/" + userId + "/" + productId + "/order";
        }
      }

      function productEditButton(result) {
        var buttonsContainer = document.querySelector(".buttons");
        if (result.item.userId != sessionStorage.getItem("userId")) {
          while (buttonsContainer.firstChild) {
            buttonsContainer.removeChild(buttonsContainer.firstChild);
          }
          var button = document.createElement("button");
          button.classList = "long-button c-blue";
          button.textContent = "안전결제";
          buttonsContainer.appendChild(button);
          button.onclick = () => payButton();
        }

        if (
          buttonsContainer &&
          result.item.soldCheck &&
          result.item.userId != sessionStorage.getItem("userId")
        ) {
          // buttons 클래스 안에 있는 모든 자식 요소 삭제
          while (buttonsContainer.firstChild) {
            buttonsContainer.removeChild(buttonsContainer.firstChild);
          }

          var button = document.createElement("button");
          button.classList = "long-button c-gray";
          button.textContent = "판매완료";
          button.disabled;
          buttonsContainer.appendChild(button);
        }
      }

      function getThisStore() {
        const url = "/api/store/" + userId + "?soldCheck=0";
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
            });
        }
      }
    </script>

    <script>
      function likesButton(button) {
        // 버튼의 클래스명을 가져옵니다
        const buttonClass = button.classList.value;

        var path = window.location.pathname;

        // 경로에서 userId 추출하기
        var userIdMatch = path.match(/\/store\/(\d+)/);
        var productIdMatch = path.match(/(\d+)$/);

        // userId가 존재하면 값을 추출
        userId = userIdMatch ? userIdMatch[1] : null;
        productId = productIdMatch ? productIdMatch[1] : null;

        console.log(LikeStatus);
        if (!sessionStorage.getItem("userId")) {
          LoginModal();
        } else {
          const csrfHeader = document.querySelector(
            'meta[name="_csrf_header"]'
          ).content;
          const csrfToken =
            document.querySelector('meta[name="_csrf"]').content;

          fetch("/api/product/like", {
            method: "POST",
            headers: {
              [csrfHeader]: csrfToken,
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              productId: productId,
              LikeStatus: LikeStatus,
            }),
          })
            .then((response) => {
              if (!response.ok) {
                throw new Error(`HTTP error! Status: ` + response.status);
              }
              return response.text();
            })
            .then((result) => {
              location.reload();
            })
            .catch((error) => {
              // 에러 발생 시의 로직
            });
        }
      }
    </script>
  </body>
</html>
