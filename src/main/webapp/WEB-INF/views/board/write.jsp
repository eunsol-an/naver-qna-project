<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/nav.jsp"/>

<div class="container mt-3">
  <h2>질문 등록</h2>
  <form action="/board/write" method="post" enctype="multipart/form-data">
    <div class="mb-3 mt-3">
      <label for="category">카테고리:</label>
   	  <input type="text" class="form-control" id="category" name="category">
    </div>
    <div class="mb-3">
      <label for="title">제목:</label>
      <input type="text" class="form-control" id="title" name="title">
    </div>
    <div class="mb-3">
      <label for="writer">작성자:</label>
      <input type="text" class="form-control" id="writer" name="writer" value="${ses.email }" readonly>
    </div>
    <div class="mb-3">
      <label for="description">질문:</label>
      <textarea class="form-control" id="description" name="description"></textarea>
    </div>
    <div class="mb-3">
      <label for="files">파일첨부:</label>
      <input type="file" class="form-control" style="display:none;" id="files" name="fileAttached" accept="image/jpg, image/jpeg, image/png, image/gif" multiple>
      <div class="d-grid">
      <button type="button" id="attachTrigger" class="btn btn-outline-primary btn-block d-block">Attach Files</button>
      </div>
      <div class="my-3" id="fileZone"></div>
    </div>
    <button type="submit" class="btn btn-primary" id="writeBtn">등록하기</button>
  </form>
</div>

<script>
	 document.getElementById('attachTrigger').addEventListener('click', () => {
		 document.getElementById('files').click();
	 });
</script>
<script src="/resources/js/board.write.js"></script>
<jsp:include page="../common/footer.jsp"/>