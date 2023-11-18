<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<jsp:include page="../header.jsp"></jsp:include>
<script src="/js/add_files.js"></script>
<title>Document</title>
</head>
<body>
	<div class="container">
		<div>
			<h3>상품 등록</h3>
		</div>
		<form method="post" enctype="multipart/form-data">
			<div>
				<div class="form-group mt-2">
					<label>상품명:</label> <input type="text" name="productName" />
				</div>

				<div>
					<label>카테고리1:</label><select name="category1Code">
						<c:forEach var="category1" items="${category1List}">
							<option value="${category1.category1Code}">${category1.name}</option>
						</c:forEach>
					</select>
				</div>
				<div>
					<label>카테고리2:</label> <select name="category2Code">
						<c:forEach var="category2" items="${category2List}">
							<option value="${category2.category2Code}">${category2.name}</option>
						</c:forEach>
					</select>
				</div>

				<div>
					<label>가격:</label> <input type="number" name="productPrice" />
				</div>

				<div>
					<label>수량:</label> <input type="number" name="productStock" />
				</div>

				<div>
					<label>상태:</label> <input type="radio" name="productStatus"
						value="0" checked />새상품 <input type="radio" name="productStatus"
						value="1" />중고
				</div>

				<div>
					<label>상세 설명:</label>
					<div>
						<textarea id="summernote" name="productDetail"></textarea>
					</div>
				</div>

				<div class="mt-2">
					<label class="col-1">제품 이미지:</label>
					<button type="button" class="btn btn-sm btn-primary" id="add">
						파일 추가</button>
					<ul id="files" class="col">
						<li class="mt-2 row">
							<div class="col-1"></div>
							<div class="col">
								<input name="uploadFile" type="file" class="form-control" />
							</div>
						</li>
					</ul>
				</div>
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
				<div>
					<button>등록</button>
					<a href="list">취소</a>
				</div>
			</div>
		</form>
	</div>
</body>
</html>
