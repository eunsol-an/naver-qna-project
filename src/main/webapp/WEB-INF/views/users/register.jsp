<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/nav.jsp"/>

<div class="container mt-3 col-sm-12 col-lg-4">
  <h2>회원가입</h2>
  <form action="/users/register" method="post">
    <div class="mb-3 mt-3">
      <label for="email">이메일:</label>
      <div class="input-group">
      	<input type="email" class="form-control" id="email" placeholder="Enter email" name="email">
      	<button type="button" class="btn btn-success" id="dupleCheck">중복확인</button>
      </div>
    </div>
    <div class="mb-3">
      <label for="pwd">비밀번호:</label>
      <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="pwd">
    </div>
    <div class="mb-3">
      <label for="nickName">닉네임:</label>
      <input type="text" class="form-control" id="nickName" placeholder="Enter nickname" name="nickName">
    </div>
    <button type="submit" class="btn btn-primary" id="regBtn" disabled>회원가입하기</button>
  </form>
</div>

<script>
let isLogin = '<c:out value="${isLogin}"/>';
if (parseInt(isLogin)) {
alert("로그인 실패");
}
</script>
<script src="/resources/js/users.register.js"></script>

<jsp:include page="../common/footer.jsp"/>