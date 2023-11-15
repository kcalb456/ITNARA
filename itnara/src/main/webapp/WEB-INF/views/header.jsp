<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib
	uri="http://www.springframework.org/security/tags" prefix="sec"%>
<link rel="stylesheet" href="/css/style.css" type="text/css" />
<nav class="nav">
	<a href="/"><img class="logo" alt="로고"
		src="https://upload.wikimedia.org/wikipedia/commons/9/92/%EC%9A%94%EC%A6%98IT_%EB%A1%9C%EA%B3%A0.png" /></a>
	<div class="header-menu">
		<a href="/products/list">장터</a> <a href="/board">게시판</a>
	</div>

	<div class="login-box">
		<sec:authorize access="isAnonymous()">
			<a href="/auth/login">로그인</a>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal" var="prc" />
			<a href="/logout" class="">로그아웃</a>
			${prc.authorities} 
		</sec:authorize>
	</div>
</nav>
