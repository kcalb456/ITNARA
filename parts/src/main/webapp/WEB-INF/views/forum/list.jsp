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
        <div>
          <div class="profile-img">
            <img class="img-full" src="" onerror="handleImageError(this)" />
          </div>
          <div class="post-writer">홍길동</div>
          <div class="post-date">2023-10-23</div>
          <div class="post-title">요즘 세상이 막막해</div>
          <div class="post-view">0</div>
        </div>
      </section>
    </div>
  </body>
</html>
