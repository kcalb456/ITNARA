<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/css/style.css" type="text/css" />
<title>Document</title>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="center container">
		<div>
			<form method="post" id="signin_form">
				<div>
					<input class="inputbar" type="text" name="email" placeholder="아이디" /> <input
						class="inputbar" type="password" name="passwd" placeholder="비밀번호" /> <input
						type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</div>
				${SPRING_SECURITY_LAST_EXCEPTION.message}
				<button class="long-button c-blue">로그인</button>
			</form>
			<div>
				<a href="/auth/signup">회원가입</a>
			</div>
		</div>
	</div>
</body>
</html>
