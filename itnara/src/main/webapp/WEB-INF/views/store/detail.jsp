<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
  </head>
  <body>
    <jsp:include page="../header.jsp"></jsp:include>
    ${product.productName}dsds

    <c:forEach var="image" items="${product.images}">
      <li>
        <img
          src="/upload/${image.uuid}_${image.imageName}"
          alt="${image.imageName}"
        />
      </li>
    </c:forEach>
  </body>
</html>
