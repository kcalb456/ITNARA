<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%><%@ taglib uri="http://www.springframework.org/security/tags"
prefix="sec"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <jsp:include page="../header.jsp"></jsp:include>
    <script src="/js/category.js"></script>
    <title>Document</title>
  </head>
  <body>
    <sec:authorize access="isAuthenticated()">
      <sec:authentication property="principal" var="principal" />
    </sec:authorize>
    <div class="container">
      <form class="add-form" method="post" enctype="multipart/form-data">
        <div>
          <h2>기본 정보</h2>
        </div>
        <div class="mt-2">
          <label class="col-1">제품 이미지:</label>
          <input id="myfiles" multiple type="file" name="uploadFile" />
          <div id="output"></div>
        </div>
        <input
          type="hidden"
          name="${_csrf.parameterName}"
          value="${_csrf.token}"
        />
        <div class="inputbar">
          <input class="input_inner" type="text" name="productName" /><label
            class="input_label"
            >상품명:</label
          >
        </div>
        <div class="selector-box">
          <div>
            <label>카테고리1:</label>
            <select
              class="selector"
              id="category1"
              name="name"
              onchange="category1Changed()"
            >
              <c:forEach var="category" items="${category}">
                <option value="${category.name}">${category.name}</option>
              </c:forEach>
            </select>
          </div>
          <div>
            <label>카테고리2:</label>
            <select class="selector" id="category2" name="name2"></select>
          </div>
        </div>

        <div class="inputbar">
          <input
            class="input_inner"
            type="number"
            name="productPrice"
            min="0"
          /><label class="input_label">가격:</label>
        </div>

        <div class="inputbar">
          <input class="input_inner" type="number" name="productStock" />
          <label class="input_label">수량:</label>
        </div>

        <div class="inputbar row">
          <label>상태:</label>
          <div>
            <label
              >새상품<input type="radio" name="productStatus" value="0" checked
            /></label>
          </div>
          <div>
            <label
              >중고<input type="radio" name="productStatus" value="1"
            /></label>
          </div>
        </div>

        <div>
          <div class="inputbar">
            <textarea class="input_inner" name="productDetail"></textarea>
            <label class="input_label">상세 설명:</label>
          </div>
        </div>
        <div class="buttons">
          <button class="long-button c-blue">등록</button>
          <a href="/" class="long-button c-gray">취소</a>
        </div>
      </form>
    </div>
    <script>
      const output = document.getElementById("output");
      const fileInput = document.getElementById("myfiles");
      const principalUserId = `${principal.userId}`;

      fileInput.addEventListener("change", () => {
        const csrfHeader = document.querySelector(
          'meta[name="_csrf_header"]'
        ).content;
        const csrfToken = document.querySelector('meta[name="_csrf"]').content;

        const formData = new FormData();
        for (let i = 0; i < fileInput.files.length; i++) {
          formData.append("uploadFile", fileInput.files[i]);
        }
        formData.append("userId", principalUserId);

        fetch("/api/cache", {
          method: "POST",
          headers: {
            [csrfHeader]: csrfToken,
          },
          body: formData,
        })
          .then((resp) => resp.json())
          .then((result) => {
            console.log(result);
            displayFiles(result);
          });
      });

      function displayFiles(image) {
        output.innerHTML = "";
        for (let i = 0; i < image.length; i++) {
          var divContainer = document.createElement("div");
          var Fileimg = document.createElement("img");
          divContainer.classList.add("product-image");

          // 클로저 밖에서 변수로 선언
          let currentDivContainer = divContainer;

          divContainer.onclick = async () => {
            await imageDelete(image[i].uuid + "_" + image[i].imageName);
            currentDivContainer.remove();
          };

          Fileimg.classList.add("img-full");
          Fileimg.src =
            "/cache/" +
            principalUserId +
            "/" +
            image[i].uuid +
            "_" +
            image[i].imageName;

          Fileimg.dataset.imagename = image[i].uuid + "_" + image[i].imageName;
          divContainer.appendChild(Fileimg);
          output.appendChild(divContainer);
        }
      }

      function imageDelete(image, divContainer) {
        console.log(image);
        const csrfHeader = document.querySelector(
          'meta[name="_csrf_header"]'
        ).content;
        const csrfToken = document.querySelector('meta[name="_csrf"]').content;
        fetch("/api/cache/delete?imageName=" + image, {
          method: "DELETE",
          headers: {
            [csrfHeader]: csrfToken,
            "Content-Type": "application/json",
          },
        })
          .then((resp) => resp.text())
          .then((result) => {});
      }
    </script>
  </body>
</html>
