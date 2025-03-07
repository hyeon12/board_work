<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:url var="action" value='/board/save' />
<layout:main title="게시판" menuCode='board'>
<div class="layout-width">
	<h1>게시글 작성</h1>
	<form:form action="${action}" modelAttribute="boardForm" autocomplete="off">
		<form:hidden path="mode" />
		<form:errors />
		<jsp:include page="_form.jsp" />
		<button type="submit" class="btn btn-info">작성</button>
		<a href="<c:url value='/board/list' />"><button type="button" class="btn btn-primary">목록</button></a>
	</form:form>
</div>
</layout:main>