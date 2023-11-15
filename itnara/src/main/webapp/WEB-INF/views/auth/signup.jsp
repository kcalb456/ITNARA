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
<script>
	function signup() {
		const form = document.signup_form;
		const regExp = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/; // new RegExp('');

		if (!form.email.value || form.email.value == "") {
			alert("아이디는 필수 입니다");
			form.email.focus();
			return;
		}

		if (!regExp.test(form.email.value)) {
			alert("아이디는 이메일 형식으로 입력하셔야 합니다");
			form.email.focus();
			return;
		}

		if (!form.passwd.value || form.passwd.value == "") {
			alert("비밀번호를 입력 해 주세요");
			form.passwd.focus();
			return;
		}

		if (!form.passwd_confirm.value || form.passwd_confirm.value == "") {
			alert("비밀번호 확인을 입력 해 주세요");
			form.passwd_confirm.focus();
			return;
		}

		if (form.passwd.value != form.passwd_confirm.value) {
			alert("비밀번호와 비밀번호 확인이 일치하지 않습니다");
			form.passwd_confirm.focus();
			return;
		}

		if (!form.nickName.value || form.nickName.value == "") {
			alert("닉네임을 입력 해 주세요");
			form.nickName.focus();
			return;
		}

		form.submit();
	}
</script>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="container center">
		<div>
			<form method="post" name="signup_form" id="signup_form">
				<div>
					<div>
						닉네임 <input class="inputbar" type="text" name="nickName" />
					</div>
					<div>
						이메일 <input class="inputbar" type="email" name="email" />
					</div>
					<div>
						비밀번호 <input class="inputbar" type="text" name="passwd" />
					</div>
					<div>
						비밀번호 확인 <input class="inputbar" type="text" name="passwd_confirm" />
					</div>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
				</div>
				<button type="button" class="long-button c-blue" onclick="signup()">확인</button>
			</form>
		</div>
	</div>
</body>
</html>
