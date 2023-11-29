<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%><%@ taglib uri="http://www.springframework.org/security/tags"
prefix="sec"%>
<section class="section-nav">
  <article class="nav-arti-left">
    <input
      id="search"
      type="text"
      placeholder="검색어를 입력하세요 (예:Asrock B660 RS PRO D4)"
      onKeypress="if(window.event.keyCode==13){search_onclick_submit()}"
    />
    <div class="category-button row">
      <a
        href="javascript:void(0);"
        onclick="search_onclick_submit('데스크탑')"
        class="c-white"
        ><i class="bi-pc-display"></i>데스크탑</a
      >
      <a
        href="javascript:void(0);"
        onclick="search_onclick_submit('노트북')"
        class="c-white"
        ><i class="bi-laptop"></i>노트북</a
      >
      <a
        href="javascript:void(0);"
        onclick="search_onclick_submit('모바일')"
        class="c-white"
        ><i class="bi-phone"></i>모바일</a
      >
      <a
        href="javascript:void(0);"
        onclick="search_onclick_submit('가전제품')"
        class="c-white"
        ><i class="bi-house"></i>가전제품</a
      >
      <a
        href="javascript:void(0);"
        onclick="search_onclick_submit('기타')"
        class="c-white"
        ><i class="bi-motherboard"></i>기타</a
      >
    </div>
  </article>
  <article class="nav-arti-right">
    <div>
      <div class="buttons">
        <a
          id="mystore"
          href="#"
          onclick="LoginCheck(this.id)"
          class="long-button c-white"
          >내 상점</a
        ><a
          id="new"
          href="#"
          onclick="LoginCheck(this.id)"
          class="long-button c-blue"
          >내 물건 팔기</a
        >
      </div>
    </div>
    <div class="sell-info row">
      <div>
        <label>나의 찜</label>
        <div class="like">-</div>
      </div>
      <div>
        <label>나의 판매중인 물품</label>
        <div class="sale-count">-</div>
      </div>
      <div>
        <label>나의 구매한 물품</label>
        <div class="purchase-count">-</div>
      </div>
    </div>
  </article>
</section>
<script>
  function LoginCheck(clickedId) {
    var userId = null;
    <sec:authorize access="isAuthenticated()">
      <sec:authentication property="principal" var="prc" />
      userId = "${prc.userId}"
    </sec:authorize>;
    if (!userId) {
      LoginModal();
    } else {
      switch (clickedId) {
        case "mystore":
          window.location.href = "/store/" + userId;
          break;
        case "new":
          window.location.href = "/products/new";
          break;
        default:
          window.location.href = "/";
          break;
      }
    }
  }

  function search_onclick_submit(category) {
    const searchResult = document.getElementById("search").value;

    if (category === undefined) {
      category = "";
    }
    location.href =
      "/products/list?search=" + searchResult + "&name=" + category;
  }
</script>
<script>
  window.addEventListener("DOMContentLoaded", function () {
    urlSearch = new URLSearchParams(location.search);
    searchText = urlSearch.get("search");
    document.getElementById("search").value = searchText;
  });
</script>

<script>
  window.addEventListener("DOMContentLoaded", function () {
    urlSearch = new URLSearchParams(location.search);
    searchText = urlSearch.get("name");

    switch (urlSearch.get("name")) {
      case "데스크탑":
        searchText = 0;
        break;
      case "노트북":
        searchText = 1;
        break;
      case "모바일":
        searchText = 2;
        break;
      case "가전제품":
        searchText = 3;
        break;
      case "기타":
        searchText = 4;
        break;
    }

    const sels = document.querySelectorAll(".category-button a");

    sels.forEach(function (sel, index) {
      if (index == searchText) {
        sel.style.color = "white";
        sel.style.backgroundColor = "#0080ff";
        sel.style.top = "10px";
        sel.style.boxShadow = "0px 5px 10px rgba(0, 0, 0, 0.1)";
      }
    });
  });
</script>

<script>
  document.addEventListener("DOMContentLoaded", function () {
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
      .then((result) => {
        console.log(result);

        if (result.userId) {
          // 인증 성공 시
          document.querySelector(".like").textContent = result.countLike;
          document.querySelector(".sale-count").textContent = result.countSell;
          document.querySelector(".purchase-count").textContent =
            result.countPurchase;
        } else {
          // 인증 실패 시
          console.error("Authentication failed.");
          // 실패에 대한 추가적인 처리를 여기에 추가할 수 있습니다.
          sessionStorage.clear();
        }
      })
      .then((error) => {
        sessionStorage.clear();
      });
  });
</script>
