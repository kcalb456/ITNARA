<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%><%@ taglib uri="http://www.springframework.org/security/tags"
prefix="sec"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="EUC-KR" />
    <title>Insert title here</title>
  </head>
  <body>
    <jsp:include page="../header.jsp"></jsp:include>
    <div class="container">
      <section>
        <a href="forum/new">글 작성</a>
        <div class="forum-board"></div>
      </section>
    </div>
  </body>
  <script>
    window.addEventListener("DOMContentLoaded", () => {
      fetch("/api/forum/list", {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
        },
      })
        .then((resp) => resp.json())
        .then((result) => {
          console.log(result);

          result.forEach((item) => {
            console.log(item);

            const forumList = document.querySelector(".forum-board");

            const a = document.createElement("a");
            a.href = "test";
            const div1 = document.createElement("div");
            div1.classList.add("post-list");
            const div11 = document.createElement("div");
            div11.classList.add("profile");
            const div121 = document.createElement("div");
            div121.classList.add("profile-img");
            const img = document.createElement("img");
            img.classList.add("img-full");
            img.src = "123";
            img.onerror = () => handleImageError(img);
            const div122 = document.createElement("div");
            div122.classList.add("post-writer");
            div122.textContent = item.storeName;
            const div123 = document.createElement("div");
            div123.classList.add("post-date");
            div123.textContent = item.postDate;

            const div2 = document.createElement("div");
            div2.classList.add("post-title");
            div2.textContent = item.postHeader;

            const div3 = document.createElement("div");
            div3.classList.add("post-info");
            const div31 = document.createElement("div");
            div31.classList.add("post-view");
            const i1 = document.createElement("i");
            i1.classList.add("bi-eyeglasses");

            const div32 = document.createElement("div");
            div32.classList.add("post-reply-count");
            const i2 = document.createElement("i");
            i2.classList.add("bi-chat-right-text");

            forumList.appendChild(a);
            a.appendChild(div1);
            div1.appendChild(div11);
            div11.appendChild(div121);
            div121.appendChild(img);
            div11.appendChild(div122);
            div11.appendChild(div123);

            div1.appendChild(div2);
            div1.appendChild(div3);
            div3.appendChild(div31);
            div31.appendChild(i1);
            div3.appendChild(div32);
            div32.appendChild(i2);
          });
        });
    });
  </script>
</html>
