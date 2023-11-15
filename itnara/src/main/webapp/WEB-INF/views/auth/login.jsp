<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="/css/style.css" type="text/css" />
    <title>Document</title>
  </head>
  <body>
    <div id="container">
      <form method="post" id="signin_form">
        <div>이메일 <input type="text" name="email" /></div>
        <div>비밀번호 <input type="password" name="passwd" /></div>
        <input
          type="hidden"
          name="${_csrf.parameterName}"
          value="${_csrf.token}"
        />
        <button class="">로그인</button>
      </form>
    </div>
    ${SPRING_SECURITY_LAST_EXCEPTION.message}
    <a href="/signup">회원가입</a>
  </body>
</html>
