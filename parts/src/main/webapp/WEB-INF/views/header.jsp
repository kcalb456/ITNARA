<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%><%@ taglib uri="http://www.springframework.org/security/tags"
prefix="sec"%>
<link rel="stylesheet" href="/css/style.css" type="text/css" />
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="
https://cdn.jsdelivr.net/npm/sweetalert2@11.10.0/dist/sweetalert2.all.min.js
"></script>
<link
  href="
https://cdn.jsdelivr.net/npm/sweetalert2@11.10.0/dist/sweetalert2.min.css
"
  rel="stylesheet"
/>
<link
  rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"
/>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<script src="/js/image_error.js"></script>
<script>
  function LoginModal() {
    const login = document.querySelector(".login");
    const modalBody = document.querySelector(".modal_body");

    // 이벤트 전파 방지 함수
    function stopPropagation(e) {
      e.stopPropagation();
    }

    login.classList.toggle("show");

    inputNullCheck();

    login.addEventListener("mousedown", () => {
      if (!modalBody.contains(event.target)) {
        login.classList.remove("show");
      }
    });
  }
</script>
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
/>
<nav class="nav">
  <a href="/" class="logo">pArtS</a>
  <div class="header-menu">
    <a href="/products/list">장터</a> <a href="/forum">게시판</a>
  </div>

  <div class="login-box">
    <sec:authorize access="isAnonymous()">
      <button onclick="LoginModal()" class="loginBtn">로그인</button>
    </sec:authorize>
    <sec:authorize access="isAuthenticated()">
      <sec:authentication property="principal" var="prc" />
      <a href="/logout" class="logoutBtn" onclick="logout()">로그아웃</a>
    </sec:authorize>
  </div>
</nav>
<script>
  function logout() {
    sessionStorage.clear();
  }
</script>

<script>
  window.addEventListener("DOMContentLoaded", () => {
    fetch("/api/auth", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
      },
    })
      .then((res) => {
        if (!res.ok) {
          throw new Error(`HTTP error! Status: ` + res.status);
        }
        return res.json();
      })
      .then((result) => {
        Object.keys(result).forEach((key) => {
          sessionStorage.setItem(key, JSON.stringify(result[key]));
        });
      })
      .catch((error) => {
        console.error("Fetch error:", error.message);
        sessionStorage.clear();
      });
  });
</script>

<jsp:include page="auth/login.jsp"></jsp:include>
