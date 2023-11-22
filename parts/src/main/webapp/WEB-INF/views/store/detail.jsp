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
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
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
            <div class="detail">
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
              <div class="detail-condition">
                <label>상품상태</label>
              </div>
              <div class="detail-delivery-price">
                <label>배송비</label>
              </div>
              <div class="detail-address">
                <label>거래지역</label>
              </div>
              <div class="detail-price">
                <div class="price">${product.productPrice}</div>
                <div>원</div>
              </div>
            </div>
            <div class="buttons">
              <sec:authentication property="principal" var="prc" />
              <sec:authorize access="isAuthenticated()">
                <c:choose>
                  <c:when test="${product.userId == prc.userId}">
                    <a class="long-button c-orange" href="${productId}/update"
                      >변경</a
                    >
                    <button
                      class="long-button c-blue"
                      onclick="deleteThisProduct()"
                    >
                      삭제
                    </button>
                  </c:when>
                  <c:otherwise>
                    <a
                      href="${product.productId}/order"
                      class="long-button c-blue"
                      >안전결제</a
                    >
                  </c:otherwise>
                </c:choose>
              </sec:authorize>
              <sec:authorize access="isAnonymous()">
                <a href="${product.productId}/order" class="long-button c-blue"
                  >안전결제</a
                >
              </sec:authorize>
            </div>
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
      <section class="detail-bottom">
        <div class="detail-info">
          <h1>상세 설명</h1>
          <div>${product.productDetail}</div>
        </div>
        <div class="store-more">
          <label class="title">판매자의 다른 상품</label>
        </div>
      </section>
    </div>
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
              `/api/product/delete/` + userId + `?productId=${productId}`,
              {
                method: "DELETE",
                headers: {
                  [csrfHeader]: csrfToken,
                  "Content-Type": "application/json",
                },
              }
            );

            if (!response.ok) {
              throw new Error(`HTTP error! Status: ${response.status}`);
            }

            await response.text(); // 응답 텍스트를 소비
            Swal.fire("SweetAlert2 is working!");
          } catch (error) {
            console.error("Error:", error.message);
          }
        }
      }

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
              // fetch("/api/auth")의 결과를 사용하는 코드도 then 블록 내부로 이동
              fetch("/api/auth", {
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
                .then((LoginUser) => {
                  const loginUserId = LoginUser.userId;
                  if (LoginUser.userId != userId) {
                    productEditButton(result);
                  }
                })
                .catch((error) => {
                  console.error("Error fetching /api/auth:", error.message);
                  productEditButton(result);
                });
            })
            .catch((error) => {
              console.error("Error fetching /api/product:", error.message);
            });
        }
      }

      function productEditButton(result) {
        var buttonsContainer = document.querySelector(".buttons");
        if (buttonsContainer && result.soldCheck) {
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
  </body>
</html>
