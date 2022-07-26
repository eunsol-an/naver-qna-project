<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<header class="p-3 mb-3 border-bottom">
	<div class="container">
		<div
			class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
			<a href="/"
				class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
				NAVER </a>

			<ul
				class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
				<li><a href="/" class="nav-link px-2 link-secondary">홈</a></li>
				<li><a href="#" class="nav-link px-2 link-dark">Q&A</a></li>
				<li><a href="#" class="nav-link px-2 link-dark">답변하기</a></li>
				<li><a href="#" class="nav-link px-2 link-dark">지식기부</a></li>
			</ul>

			<form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3">
				<input type="search" class="form-control" placeholder="Search..."
					aria-label="Search">
			</form>
			<c:choose>
				<c:when test="${ses.email ne null && ses.email ne '' }">
					<div class="dropdown text-end">
						<a href="#"
							class="d-block link-dark text-decoration-none dropdown-toggle"
							id="dropdownUser1" data-bs-toggle="dropdown"
							aria-expanded="false"> <img src="https://github.com/mdo.png"
							alt="mdo" width="32" height="32" class="rounded-circle">
						</a>
						<ul class="dropdown-menu text-small"
							aria-labelledby="dropdownUser1">
							<li><a class="dropdown-item" href="/users/detail?email=${ses.email }">${ses.nickName }님<br>
							(${ses.email })</a></li>
							<c:if test="${ses.grade == 99 }">
							<li><a class="dropdown-item" href="/users/list">회원관리</a></li>
							</c:if>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="/users/logout">Logout</a></li>
						</ul>
					</div>
				</c:when>
				<c:otherwise>
					<div class="text-end">
						<a class="btn btn-light text-dark me-2" href="/users/login">Login</a>
						<a class="btn btn-primary" href="/users/register">Sign-up</a>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</header>