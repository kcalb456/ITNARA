<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<!DOCTYPE html>
<html>
  <head>
    <jsp:include page="../header.jsp"></jsp:include>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
  </head>
  <body>
    <div>상점명: ${item.storeName }</div>
    <c:if test="${item.userId eq sessionScope.member.userId}">
      <a href="/products/new">상품 등록</a>
    </c:if>
    <c:forEach var="item" items="${list}"> ${item.productName}</c:forEach>
  </body>
</html>
