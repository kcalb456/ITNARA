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
					<div class="inputbar" id="id_field">
						<input class="input_inner" type="text" name="email" /> <label
							class="input_label">아이디/이메일</label>
					</div>
					<div class="inputbar" id="pw_field">
						<input class="input_inner" type="password" name="passwd" /> <label
							class="input_label">비밀번호</label>
					</div>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
				</div>
				${SPRING_SECURITY_LAST_EXCEPTION.message}
				<button class="long-button c-blue">로그인</button>
			</form>
			<div>
				<a href="/auth/signup">회원가입</a>
			</div>
		</div>
	</div>
	<script>
		var myInput;
		var inputLabels;
		var inputs;
	
		document.addEventListener('input', function() {
			inputLabels = document.querySelectorAll('form .input_label');
			inputs = document.querySelectorAll('form .input_inner');
	
			inputs.forEach(function(input, index) {
				var inputLabel = inputLabels[index];
	
				if (input.value !== '') {
					inputAnime(inputLabel);
				} else {
					inputLabel.style.top = '18px';
					inputLabel.style.fontSize = '16px';
					inputLabel.style.color = 'black';
				}
			});
		});
	
		document.addEventListener('focus', function(event) {
			myInput = document.activeElement;
			if (myInput.tagName === 'INPUT') {
				var inputLabel = myInput.parentElement.querySelector('.input_label');
				inputAnime(inputLabel);
				myInput.addEventListener('blur', function() {
					// 포커스가 해제되었을 때 애니메이션을 되돌림
					if (myInput.value === '') {
						inputLabel.style.top = '18px';
						inputLabel.style.fontSize = '16px';
						inputLabel.style.color = 'black';
					}
				});
			}
		}, true);
	
		function inputAnime(label) {
			label.style.transitionProperty = 'top, font-size, color';
			label.style.transitionDuration = '0.2s';
			label.style.transitionTimingFunction = 'ease-in-out';
	
			label.style.top = '2px';
			label.style.fontSize = '12px';
			label.style.color = '#0080ff';
		}
	</script>
</body>
</html>
