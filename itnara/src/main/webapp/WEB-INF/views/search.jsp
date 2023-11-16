<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib
	uri="http://www.springframework.org/security/tags" prefix="sec"%>
<section class="section-nav">
	<article class="nav-arti-left">
		<input class="inputbar" type="text"
			placeholder="검색어를 입력하세요 (예:Asrock B660 RS PRO D4)" />
		<div class="category-button row">
			<a href="" class="c-white"><i class="bi-pc-display"></i>데스크탑</a> <a
				href="" class="c-white"><i class="bi-laptop"></i>노트북</a> <a
				href="" class="c-white"><i class="bi-phone"></i>모바일</a> <a
				href="" class="c-white"><i class="bi-house"></i>가전제품</a> <a
				href="" class="c-white"><i class="bi-motherboard"></i>기타</a>
		</div>
	</article>
	<article class="nav-arti-right">
		<div class="row">
			<a id="mystore" href="#" onclick="LoginCheck(this.id)"
				class="long-button c-white">내 상점</a><a id="new" href="#"
				onclick="LoginCheck(this.id)" class="long-button c-blue">내 물건 팔기</a>
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
      swal(
        "로그인이 필요한 항목입니다.",
        "회원 가입 또는 로그인을 해주세요",
        "error"
      ).then((result) => {
        if (result) location.replace("/auth/login");
      });
    } else {
      switch (clickedId) {
        case "mystore":
          location.replace("/store/" + userId);
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
<script>
  window.onload = function () {
    document.querySelector(".category-button").lastElementChild.style.margin =
      "0px";
    console.log(document.querySelector(".category-button").lastElementChild);
  };
</script>
