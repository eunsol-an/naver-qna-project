<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="common/header.jsp" />
<jsp:include page="common/nav.jsp" />

<div class="d-flex text-center" style="height:60vh;">
<div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column justify-content-center">
  <main class="px-3">
    <h1>네이버 지식 iN</h1>
    <p class="lead">지식iN에 지금 바로 질문하세요!</p>
    <p class="lead">
      <a href="/board/list" class="btn btn-lg btn-secondary fw-bold">질문 보러가기</a>
    </p>
  </main>
</div>
</div>

<!-- <div class="container mt-3">
  <div class="mt-4 p-5 bg-primary text-white rounded">
    <h1>네이버 지식iN</h1> 
    <P>지금 바로 질문해보세요!</P>
  </div>
</div> -->

<script>
let isLogin = '<c:out value="${isLogin}"/>';
let isLogout = '<c:out value="${isLogout}"/>';
if (parseInt(isLogin)) {
alert("로그인 성공");
}
if (parseInt(isLogout)) {
	alert('로그아웃 되었습니다');
}
</script>

<jsp:include page="common/footer.jsp" />