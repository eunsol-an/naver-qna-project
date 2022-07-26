<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/nav.jsp"/>

<c:set var="bvo" value="${bdto.bvo }" />
<div class="container mt-3">
  <h2>질문 수정</h2>
  <form action="/board/modify" method="post" enctype="multipart/form-data">
  <input type="hidden" name="bno" value="${bvo.bno }">
  <input type="hidden" name="pageNo" value="${pgvo.pageNo }">
  <input type="hidden" name="qty" value="${pgvo.qty }">
  <input type="hidden" name="type" value="${pgvo.type }">
  <input type="hidden" name="kw" value="${pgvo.kw }">
    <div class="mb-3 mt-3">
      <label for="category">카테고리:</label>
   	  <input type="text" class="form-control" id="category" placeholder="Enter category" name="category" value="${bvo.category }">
    </div>
    <div class="mb-3">
      <label for="pname">제목:</label>
      <input type="text" class="form-control" id="title" placeholder="Enter title" name="title" value="${bvo.title }">
    </div>
    <div class="mb-3">
      <label for="writer">작성자:</label>
      <input type="text" class="form-control" id="writer" placeholder="Enter writer" name="writer" value="${bvo.writer }" readonly>
    </div>
    <div class="mb-3">
      <label for="description">질문:</label>
      <textarea class="form-control" id="description" placeholder="Enter description" name="description">${bvo.description }</textarea>
    </div>
    <div class="mb-3">
      <label for="files">파일첨부:</label>
      <input type="file" class="form-control" style="display:none;" id="files" name="fileAttached" accept="image/jpg, image/jpeg, image/png, image/gif" multiple>
      <div class="d-grid">
      <button type="button" id="attachTrigger" class="btn btn-outline-primary btn-block d-block">Attach Files</button>
      </div>
      <div class="my-3" id="fileZone"></div>
    </div>
    <button type="submit" class="btn btn-primary" id="writeBtn">수정하기</button>
  </form>
</div>
<hr>
<div class="container mt-3">
  <ul class="list-group list-group-flush">
  <c:forEach var="fvo" items="${bdto.fileList }">
    <li class="list-group-item d-flex justify-content-between align-items-center">
    ${fvo.fileName }
    <span class="badge bg-primary rounded-pill">${fvo.fileSize }</span>
    <button type="button" data-uuid="${fvo.uuid }" 
    class="btn btn-outline-danger btn-sm fileDelBtn">X</button>
  	</li>
  </c:forEach>
  </ul>
</div>

<script>
	 document.getElementById('attachTrigger').addEventListener('click', () => {
		 document.getElementById('files').click();
	 });
</script>
<script src="/resources/js/board.write.js"></script>
<script src="/resources/js/board.modify.js"></script>
<jsp:include page="../common/footer.jsp"/>