<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<!-- Button to Open the Modal -->
<button type="button" class="btn btn-primary" style="display:none;" id="modalThumbBtn"
data-bs-toggle="modal" data-bs-target="#myModalThumb">
  Open modal
</button>

<!-- The Modal -->
<div class="modal" id="myModalThumb">
  <div class="modal-dialog modal-dialog-centered modal-xl">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">이미지 상세보기</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body thumb-modal">
        Modal body..
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
      </div>

    </div>
  </div>
</div>

<c:set var="bvo" value="${bdto.bvo }" />
<div class="container mt-5">
	<div class="row justify-content-center">
		<div class="col-sm-6 mb-4">
			<h5 id="bnoVal">${bvo.bno }</h5>
			<h5>${bvo.category }</h5>
			<h2>${bvo.title }(${bvo.cmtQty })</h2>
			<p>작성자 : ${bvo.writer } | 조회수 : ${bvo.readCount } | ${bvo.modAt }</p>
			<p>Description : ${bvo.description }</p>
			<div class="d-flex mb-3">
			<c:forEach var="fvo" items="${bdto.fileList }">
			<c:choose>
				<c:when test="${fvo ne null }">
				    <div class="p-2">
			    		<img src="/upload/${fn:replace(fvo.saveDir, '\\', '/') }/${fvo.uuid }_th_${fvo.fileName }" 
			    		class="rounded th-img" style="cursor:pointer;">
				    </div>
				</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>
		    </c:forEach>
			</div>
			<div class="d-flex">
				<a href="/board/list?pageNo=${pgvo.pageNo }&qty=${pgvo.qty }&type=${pgvo.type}&kw=${pgvo.kw }"
					class="btn btn-primary me-3">Board List</a>
				<a href="/board/modify?bno=${bvo.bno }&pageNo=${pgvo.pageNo }&qty=${pgvo.qty }"
					class="btn btn-primary me-3">Board Modify</a> <a
					id="boardRemove" class="btn btn-outline-danger">Board
					Remove</a>
				<form action="" id="boardRmForm" method="post"
					style="display: none;">
					<input type="hidden" value="${bvo.bno }" name="bno">
					<input type="hidden" value="${pgvo.pageNo }" name="pageNo">
					<input type="hidden" value="${pgvo.qty }" name="qty">
					<input type="hidden" value="${pgvo.type }" name="type">
					<input type="hidden" value="${pgvo.kw }" name="kw">
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Button to Open the Modal -->
<button type="button" class="btn btn-primary" style="display:none;" id="modalModBtn"
data-bs-toggle="modal" data-bs-target="#myModalMod">
  Open modal
</button>


<!-- The Modal -->
<div class="modal" id="myModalMod">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">댓글 수정</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body mod-modal">
        Modal body..
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-success modSbmBtn" data-bs-dismiss="modal" data-cno="">Modify</button>
      </div>

    </div>
  </div>
</div>

<div class="container mt-3">
	<div class="row justify-content-center">
		<div class="col-sm-6">
			<h2>Comment</h2>
			<c:if test="${ses.email ne null and ses.email ne '' }">
				<div class="input-group mb-3">
					<span class="input-group-text" id="cmtWriter">${ses.email }</span> <input
						type="text" class="form-control" placeholder="Add comment"
						id="cmtText">
					<button type="button" class="btn btn-primary" id="cmtSbmBtn">ADD</button>
				</div>
			</c:if>
			<table class="table" id="cmtTable" style="display:none;">
				<thead>
					<tr>
						<th>Writer</th>
						<th>Content</th>
						<th>Mod At</th>
						<th>Feat</th>
					</tr>
				</thead>
				<tbody id="cmtZone"></tbody>
			</table>
			<div id="cmtEmpty" style="display:none;">
				<p class="text-center">댓글을 남겨주세요!</p>
			</div>
			<div class="text-center" id="moreBtnZone"></div>
		</div>
	</div>
</div>

<script>
	let msg_mod = '<c:out value="${msg_mod}"/>';
	if (parseInt(msg_mod)) {
		alert('상품 수정이 완료되었습니다');
	}
</script>
<script src="/resources/js/board.detail.js"></script>
<script src="/resources/js/board.comment.js"></script>
<jsp:include page="../common/footer.jsp" />