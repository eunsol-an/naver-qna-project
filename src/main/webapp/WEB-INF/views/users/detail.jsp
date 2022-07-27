<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<div class="container mt-3">
	<h2>회원 정보</h2>
	<div class="card mt-4">
		<div class="card-body p-5">
			<h4 class="card-title" id="emVal">${uvo.email }</h4>
			<div class="card-text">
				<ul class="list-group list-group-flush my-4">
					<li class="list-group-item">닉네임 : ${uvo.nickName }</li>
					<li class="list-group-item">등급 : ${uvo.grade }</li>
					<li class="list-group-item">가입일자 : ${uvo.regAt }</li>
				</ul>
				<div class="d-flex">
				<a href="/users/list?email=${uvo.email }&pageNo=${pgvo.pageNo }&qty=${pgvo.qty }&type=${pgvo.type }&kw=${pgvo.kw }" class="btn btn-primary me-3">회원목록</a>
				<a href="/users/modify?email=${uvo.email }&pageNo=${pgvo.pageNo }&qty=${pgvo.qty }&type=${pgvo.type }&kw=${pgvo.kw }" class="btn btn-primary me-3">회원수정</a>
				<a id="usersRemove" class="btn btn-outline-danger">회원탈퇴</a>
				<form action="" id="usersRmForm" method="post" style="display:none;">
					<input type="hidden" id="em" value="" name="email">
					<input type="hidden" value="${pgvo.pageNo }" name="pageNo">
					<input type="hidden" value="${pgvo.qty }" name="qty">
				</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="/resources/js/users.detail.js"></script>
<jsp:include page="../common/footer.jsp" />