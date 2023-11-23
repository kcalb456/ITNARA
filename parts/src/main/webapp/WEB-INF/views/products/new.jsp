<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <jsp:include page="../header.jsp"></jsp:include>
    <script src="/js/add_files.js"></script>
    <script src="/js/category.js"></script>
    <title>Document</title>
  </head>
  <body>
    <div class="container">
      <div>
        <h3>상품 등록</h3>
      </div>
      <form class="add-form" method="post" enctype="multipart/form-data">
        <div class="mt-2">
          <label class="col-1">제품 이미지:</label>
          <button type="button" class="btn btn-sm btn-primary" id="add">
            파일 추가
          </button>
          <ul id="files" class="col">
            <li class="mt-2 row">
              <div class="col-1"></div>
              <div class="col">
                <input name="uploadFile" type="file" class="form-control" />
              </div>
            </li>
          </ul>
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
              onchange="getCategory()"
            >
              <c:forEach var="category" items="${category}">
                <option value="${category.name}">${category.name}</option>
              </c:forEach>
            </select>
          </div>
          <div>
            <label>카테고리2:</label>
            <select class="selector" id="category2" name="name2">
              <c:forEach var="category2" items="${category}">
                <option value="${category2.name2}">${category2.name2}</option>
              </c:forEach>
            </select>
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
            <input type="radio" name="productStatus" value="0" checked /><label
              >새상품</label
            >
          </div>
          <div>
            <input type="radio" name="productStatus" value="1" /><label
              >중고</label
            >
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
      var myInput;
      var inputLabels;
      var inputs;

      document.addEventListener("input", function () {
        inputLabels = document.querySelectorAll("form .input_label");
        inputs = document.querySelectorAll("form .input_inner");

        inputs.forEach(function (input, index) {
          var inputLabel = inputLabels[index];

          if (input.value !== "") {
            inputAnime(inputLabel);
          } else {
            inputLabel.style.top = "18px";
            inputLabel.style.fontSize = "16px";
            inputLabel.style.color = "black";
          }
        });
      });

      document.addEventListener(
        "focus",
        function (event) {
          myInput = document.activeElement;
          if (myInput.tagName === "INPUT") {
            var inputLabel =
              myInput.parentElement.querySelector(".input_label");
            inputAnime(inputLabel);
            myInput.addEventListener("blur", function () {
              // 포커스가 해제되었을 때 애니메이션을 되돌림
              if (myInput.value === "") {
                inputLabel.style.top = "18px";
                inputLabel.style.fontSize = "16px";
                inputLabel.style.color = "black";
              }
            });
          }
        },
        true
      );

      function inputAnime(label) {
        label.style.transitionProperty = "top, font-size, color";
        label.style.transitionDuration = "0.2s";
        label.style.transitionTimingFunction = "ease-in-out";

        label.style.top = "2px";
        label.style.fontSize = "12px";
        label.style.color = "#0080ff";
      }
    </script>
  </body>
</html>
