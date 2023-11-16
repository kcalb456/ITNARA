<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/css/style.css" type="text/css" />
<title>pArtS</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
		<jsp:include page="search.jsp"></jsp:include>
		<section class="section-board">

			<h1>데스크탑</h1>
			<div>
				<c:forEach var="item" items="${list1}">
					${item.productName }
				</c:forEach>
			</div>
		</section>
		<section class="section-board">
			<h1>노트북</h1>
			<div>
				<c:forEach var="item" items="${list2}">
					${item.productName }
				</c:forEach>
			</div>
		</section>
		<section class="section-board">
			<h1>모바일</h1>
			<div>
				<c:forEach var="item" items="${list3}">
					${item.productName }
				</c:forEach>
			</div>


		</section>
	</div>
</body>
</html>
