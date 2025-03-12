<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<%@ include file="/WEB-INF/views/common/nav.jsp" %>

<style>
    .layout-width {
		max-width: 1300px;
		min-width: 1000px;
		margin: 0 auto;
    }
    
    .leftdt {
    	float: left;
    	margin-right: 5px;
    }
</style>

<div class="layout-width">
	<h1>게시글 상세</h1>
	<dl>
		<dt class="leftdt">번호</dt>
		<dd>${item.bno}</dd>
	</dl>
	<dl>
		<dt class="leftdt">제목</dt>
		<dd>${item.title}</dd>
	</dl>
	<dl>
		<dt class="leftdt">작성자</dt>
		<dd>${item.writer}</dd>
	</dl>
	<dl>
		<dt>내용</dt>
		<dd>${item.content}</dd>
	</dl>
	
	<button type="button" class="btn btn-info" onclick="location.href='<c:url value='/board/edit/${item.bno}' />'">수정</button>
	<button type="button" class="btn btn-danger" onclick="location.href='<c:url value='/board/delete/${item.bno}' />'">삭제</button>
	<button type="button" class="btn btn-primary" onclick="location.href='<c:url value='/board/boardhome' />'">목록</button>
</div>
