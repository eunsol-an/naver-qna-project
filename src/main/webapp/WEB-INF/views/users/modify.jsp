<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/nav.jsp"/>

<div class="container mt-3 col-sm-12 col-lg-4">
  <h2>회원 수정</h2>
  <form action="/users/modify" method="post">
  <input type="hidden" name="pageNo" value="${pgvo.pageNo }">
  <input type="hidden" name="qty" value="${pgvo.qty }">
    <div class="mb-3 mt-3">
      <label for="email">이메일:</label>
      <input type="email" class="form-control" id="email" placeholder="Enter email" name="email" value="${uvo.email }" readonly>
    </div>
    <div class="mb-3">
      <label for="pwd">비밀번호:</label>
      <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="pwd" value="${uvo.pwd }">
    </div>
    <div class="mb-3">
      <label for="nickName">닉네임:</label>
      <input type="text" class="form-control" id="nickName" placeholder="Enter nickname" name="nickName" value="${uvo.nickName }">
    </div>
    <c:if test="${ses.grade == 99 }">
    <div class="mb-3">
      <label for="grade">등급:</label>
      <input type="number" class="form-control" id="grade" placeholder="Enter grade" name="grade" value="${uvo.grade }">
    </div>
    </c:if>
    <button type="submit" class="btn btn-primary">수정하기</button>
  </form>
</div>

<jsp:include page="../common/footer.jsp"/>