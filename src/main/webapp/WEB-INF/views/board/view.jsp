<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<layout:main title="게시판" menuCode='board'>
	<div class="layout-width">
	<dl>
		<dt>번호</dt>
		<dd>${item.bno}</dd>
	</dl>
	<dl>
		<dt>제목</dt>
		<dd>${item.title}</dd>
	</dl>
	<dl>
		<dt>작성자</dt>
		<dd>${item.writer}</dd>
	</dl>
	<dl>
		<dt>내용</dt>
		<dd>${item.content}</dd>
	</dl>
	<a href="<c:url value='/board/edit/${item.bno}' />"><button type="button" class="btn btn-info">수정</button></a>
	<a href="<c:url value='/board/delete/${item.bno}' />"><button type="button" class="btn btn-danger">삭제</button>	</a>
	<a href="<c:url value='/board/list' />"><button type="button" class="btn btn-primary">목록</button></a>
	</div>
</layout:main>