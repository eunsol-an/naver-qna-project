<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<div class="container mt-5">
	<h2>QnA 질문 
		<c:if test="${ses.email ne null && ses.email ne '' }">
			<a href="/board/write" class="btn btn-primary ms-3">질문하기</a>
		</c:if>
	</h2>
	<table class="table table-hover mt-5">
		<thead>
			<tr>
				<th>글번호</th>
				<th>카테고리</th>
				<th>제목</th>
				<th>답변</th>
				<th>조회수</th>
				<th>작성시간</th>
				<th>첨부파일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="bvo" items="${list }">
				<tr>
					<td>${bvo.bno }</td>
					<td>${bvo.category }</td>
					<td><a href="/board/detail?bno=${bvo.bno}&pageNo=${pgn.pgvo.pageNo }&qty=${pgn.pgvo.qty }&type=${pgn.pgvo.type}&kw=${pgn.pgvo.kw }">${bvo.title }</a></td>
					<td>${bvo.cmtQty }</td>
					<td>${bvo.readCount }</td>
					<td>${bvo.modAt }</td>
					<td>
						<c:if test="${bvo.fileCount > 0 }">
						<i class="material-icons">attachment</i>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<ul class="pagination justify-content-center">
		<c:if test="${pgn.prev }">
	    	<li class="page-item"><a class="page-link" href="/board/list?pageNo=${pgn.startPage-1 }&qty=${pgn.pgvo.qty }&type=${pgn.pgvo.type}&kw=${pgn.pgvo.kw }">이전</a></li>
	    </c:if>
    	<c:forEach begin="${pgn.startPage }" end="${pgn.endPage }" var="i">
		    <li class="page-item ${pgn.pgvo.pageNo == i ? 'active' : '' }"><a class="page-link" href="/board/list?pageNo=${i }&qty=${pgn.pgvo.qty}&type=${pgn.pgvo.type}&kw=${pgn.pgvo.kw }">${i }</a></li>
	    </c:forEach>
	    <c:if test="${pgn.next }">
	    	<li class="page-item"><a class="page-link" href="/board/list?pageNo=${pgn.endPage+1 }&qty=${pgn.pgvo.qty }&type=${pgn.pgvo.type}&kw=${pgn.pgvo.kw }">다음</a></li>
	    </c:if>
  	</ul>
  	<form class="d-flex col-sm-12 col-md-6 mx-auto" action="/board/list" method="get">
  		<input type="hidden" name="pageNo" value="1">
  		<input type="hidden" name="qty" value="${pgn.pgvo.qty }">
  		<div class="input-group">
  		<c:set value="${pgn.pgvo.type }" var="typed" />
		<select class="form-select" name="type">
		  <option ${typed eq null ? 'selected':'' }>선택</option>
		  <option value="twc" ${typed eq 'twc' ? 'selected':'' }>전체</option>
		  <option value="t" ${typed eq 't' ? 'selected':'' }>제목</option>
		  <option value="w" ${typed eq 'w' ? 'selected':'' }>작성자</option>
		  <option value="c" ${typed eq 'c' ? 'selected':'' }>내용</option>
		  <option value="tw" ${typed eq 'tw' ? 'selected':'' }>제목+작성자</option>
		  <option value="tc" ${typed eq 'tc' ? 'selected':'' }>제목+내용</option>
		  <option value="wc" ${typed eq 'wc' ? 'selected':'' }>작성자+내용</option>
		</select>
        <input class="form-control me-2" type="search" aria-label="Search" name="kw" value="${pgn.pgvo.kw }">
        <button class="btn btn-outline-success" type="submit">검색 
        <span class="badge bg-danger">${pgn.totalCount }</span></button>
        </div>
    </form>
</div>

<script>
let msg_del = '<c:out value="${msg_del}"/>';
if (parseInt(msg_del)) {
	alert('질문 삭제가 완료되었습니다');
}
</script>
<jsp:include page="../common/footer.jsp" />