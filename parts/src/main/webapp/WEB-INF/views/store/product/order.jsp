<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="/js/add_files.js"></script>
<script src="/js/category.js"></script>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<title>Document</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	<div class="container">
		<div>
			<h3>결제</h3>
		</div>
		<form method="post" enctype="multipart/form-data">
			<div>
				<div class="form-group mt-2">
					<label>상품명:</label> <input type="text" name="productName"
						value="${item.productName}" readonly/>
				</div>

				<div>
					<label>가격:</label> <input type="number" name="productPrice"
						value="${item.productPrice}" readonly/>
				</div>

				<div>
					<label>수량:</label> <input type="number" name="productStock"
						value="${item.productStock}" readonly/>
				</div>

				<div>
					<label>상태:</label>
				</div>

				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
				<div>
					<button>결제 하기</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>
