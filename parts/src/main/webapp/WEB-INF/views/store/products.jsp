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
  </head>
  <body>
    <div class="container">
      <section>
        <div class="store-name"></div>
      </section>
      <section>
        <div class="row center">
          <button onclick="categories(99)">전체</button>
          <button onclick="categories(0)">판매중</button>
          <button onclick="categories(1)">판매완료</button>
          <button onclick="categories(2)">구매내역</button>
        </div>
      </section>
      <section>
        <div class="store-product-list"></div>
      </section>
    </div>
    <script>
      var soldCheck = 99;
      var userId;

      window.addEventListener("DOMContentLoaded", function () {
        var path = window.location.pathname;

        // 경로에서 userId 추출하기
        var userIdMatch = path.match(/\/store\/(\d+)/);

        // userId가 존재하면 값을 추출
        userId = userIdMatch ? userIdMatch[1] : null;

        getList();
      });

      function categories(e) {
        soldCheck = e;
        getList();
      }

      function getList() {
        console.log(soldCheck);
        const url = "/api/store/" + userId + "?soldCheck=" + soldCheck;
        if (userId) {
          fetch(url, {
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
              document.querySelector(".store-name").textContent =
                result.item.storeName;
              result = result.list;
              listUI(result); //listUI 함수에 전달
              // API 응답에서 가져온 각 항목에 대해 새 "product" 요소를 생성하고 추가
            });
        }
      }
    </script>
  </body>
</html>
