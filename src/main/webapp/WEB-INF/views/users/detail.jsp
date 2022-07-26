<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<div class="container mt-3">
	<h2>Member Detail</h2>
	<div class="card mt-4">
		<div class="card-body p-5">
			<h4 class="card-title" id="emVal">${uvo.email }</h4>
			<div class="card-text">
				<ul class="list-group list-group-flush my-4">
					<li class="list-group-item">Nickname : ${uvo.nickName }</li>
					<li class="list-group-item">Reg At : ${uvo.regAt }</li>
					<li class="list-group-item">Grade : ${uvo.grade }</li>
				</ul>
				<div class="d-flex">
				<a href="/users/list?email=${uvo.email }&pageNo=${pgvo.pageNo }&qty=${pgvo.qty }&type=${pgvo.type }&kw=${pgvo.kw }" class="btn btn-primary me-3">Member
					List</a>
				<a href="/users/modify?email=${uvo.email }&pageNo=${pgvo.pageNo }&qty=${pgvo.qty }&type=${pgvo.type }&kw=${pgvo.kw }" class="btn btn-primary me-3">Member
					Modify</a>
				<a id="usersRemove" class="btn btn-outline-danger">Member
					Remove</a>
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