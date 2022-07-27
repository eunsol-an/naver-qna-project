<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/nav.jsp"/>

<div class="container mt-5">
<c:choose>
	<c:when test="${ses.grade == 99 }">
<div class="row">
	<div class="col-sm-12 col-md-6">
		<h2>회원 목록</h2>
	</div>
	<div class="col-sm-12 col-md-6">
		<form class="d-flex" action="/users/list" method="get">
		<input type="hidden" name="pageNo" value="1">
		<input type="hidden" name="qty" value="${pgn.pgvo.qty }">
			<div class="input-group">
			<c:set value="${pgn.pgvo.type }" var="typed" />
				<select class="form-select" name="type">
				  <option ${typed eq null ? 'selected':'' }>선택</option>
				  <option value="eng" ${typed eq 'eng' ? 'selected':'' }>전체</option>
				  <option value="e" ${typed eq 'e' ? 'selected':'' }>이메일</option>
				  <option value="n" ${typed eq 'n' ? 'selected':'' }>닉네임</option>
				  <option value="g" ${typed eq 'g' ? 'selected':'' }>등급</option>
				  <option value="en" ${typed eq 'en' ? 'selected':'' }>이메일+닉네임</option>
				</select>
				<input class="form-control me-2" type="search" 
					aria-label="Search" name="kw" value="${pgn.pgvo.kw }">
				<button class="btn btn-outline-success" type="submit">검색</button>
			</div>
		</form>
	</div>
</div>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>이메일</th>
				<th>닉네임</th>
				<th>가입일자</th>
				<th>등급</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="uvo" items="${list }">
				<tr>
					<td>${uvo.email }</td>
					<td><a href="/users/detail?email=${uvo.email }&pageNo=${pgn.pgvo.pageNo }&qty=${pgn.pgvo.qty }&type=${pgn.pgvo.type }&kw=${pgn.pgvo.kw }">${uvo.nickName }</a></td>
					<td>${uvo.regAt }</td>
					<td>${uvo.grade }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<ul class="pagination justify-content-center">
		<c:if test="${pgn.prev }">
	    <li class="page-item"><a class="page-link" href="/users/list?pageNo=${pgn.startPage-1 }&qty=${pgn.pgvo.qty}&type=${pgn.pgvo.type }&kw=${pgn.pgvo.kw }">Prev</a></li>
	    </c:if>
	    <c:forEach begin="${pgn.startPage }" end="${pgn.endPage }" var="i">
	    <li class="page-item ${pgn.pgvo.pageNo == i ? 'active' : '' }"><a class="page-link" href="/users/list?pageNo=${i }&qty=${pgn.pgvo.qty }&type=${pgn.pgvo.type }&kw=${pgn.pgvo.kw }">${i }</a></li>
	    </c:forEach>
	    <c:if test="${pgn.next }">
	    <li class="page-item"><a class="page-link" href="/users/list?pageNo=${pgn.endPage+1 }&qty=${pgn.pgvo.qty }&type=${pgn.pgvo.type }&kw=${pgn.pgvo.kw }">Next</a></li>
	    </c:if>
  	</ul>
	</c:when>
	<c:otherwise>
		<h2>권한이 필요한 페이지 입니다.</h2>
	</c:otherwise>
</c:choose>
</div>

<jsp:include page="../common/footer.jsp"/>