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
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<script src="/js/image_error.js"></script>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    const login = document.querySelector(".login");
    const modalBody = document.querySelector(".modal_body");
    const loginBtn = document.querySelector(".loginBtn");

    loginBtn.addEventListener("click", (e) => {
      e.stopPropagation(); // 모달 내부를 클릭한 경우 이벤트 전파 방지
      login.classList.toggle("show");
    });

    login.addEventListener("click", () => {
      login.classList.remove("show");
    });

    modalBody.addEventListener("click", (e) => {
      e.stopPropagation(); // 모달 내부를 클릭한 경우 이벤트 전파 방지
    });
  });
</script>
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
/>
<nav class="nav">
  <a href="/" class="logo">pArtS</a>
  <div class="header-menu">
    <a href="/products/list">장터</a> <a href="/board">게시판</a>
  </div>

  <div class="login-box">
    <sec:authorize access="isAnonymous()">
      <button class="loginBtn">로그인</button>
    </sec:authorize>
    <sec:authorize access="isAuthenticated()">
      <sec:authentication property="principal" var="prc" />
      <a href="/logout" class="">로그아웃</a>
      ${prc.authorities}
    </sec:authorize>
  </div>
</nav>

<jsp:include page="auth/login.jsp"></jsp:include>
