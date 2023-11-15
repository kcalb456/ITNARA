<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%><%@ taglib uri="http://www.springframework.org/security/tags"
prefix="sec"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<section class="section-nav">
  <article class="nav-arti-left">
    <input
      class="searchbar"
      type="text"
      placeholder="검색어를 입력하세요 (예:Asrock B660 RS PRO D4)"
    />
    <div class="category-button row">
      <a href="" class="c-white">123</a> <a href="" class="c-white">123</a>
      <a href="" class="c-white">123</a> <a href="" class="c-white">123</a>
      <a href="" class="c-white">123</a>
    </div>
  </article>
  <article class="nav-arti-right">
    <div class="row">
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
  </article>
</section>
<script>
  function LoginCheck(clickedId) {
    var userId = null;
    <sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="prc" />
		userId = "${prc.userId}" 
	</sec:authorize>
    if (!userId) {
      swal(
        "로그인이 필요한 항목입니다.",
        "회원 가입 또는 로그인을 해주세요",
        "error"
      );
    } else {
      switch (clickedId) {
        case "mystore":
          location.replace("/store/"+ userId);
          break;
        case "new":
          location.replace("/products/new");
          break;
        default:
          location.replace("/");
          break;
      }
    }
  }
</script>
