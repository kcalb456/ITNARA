<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="/js/price_format.js"></script>
    <script src="/js/card_ui.js"></script>
    <title>pArtS</title>
  </head>
  <body>
    <jsp:include page="header.jsp"></jsp:include>
    <div class="container">
      <jsp:include page="search.jsp"></jsp:include>
      <section class="section-board">
        <h1>신규 등록</h1>
        <div class="store-product-list"></div>
      </section>
    </div>
    <script>
      window.addEventListener("DOMContentLoaded", function () {
        getNewList();
      });

      function getNewList() {
        fetch("/api/newlist?row=8", {
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
            listUI(result); //listUI 함수에 전달
            // API 응답에서 가져온 각 항목에 대해 새 "product" 요소를 생성하고 추가
          });
      }
    </script>
  </body>
</html>
