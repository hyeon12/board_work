<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<%@ include file="/WEB-INF/views/common/nav.jsp" %>

<style>
    .layout-width {
        max-width: 1300px;
        min-width: 1000px;
        margin: 0 auto;
    }
</style>

<c:url var="action" value='/board/save' />
<div class="layout-width">
    <h1>게시글 수정</h1>
    <form action="${action}" method="post">
        <input type="hidden" id="bno" name="bno" value="${not empty bno ? bno : board.bno}" />
        <input type="hidden" name="mode" value="edit" />  	
        
	    <c:if test="${not empty errorMessage}">
	        <script type="text/javascript">
	            alert("${errorMessage}");
	            history.back();
	        </script>
	    </c:if>
       	
        <dl>
            <dt>제목</dt>
            <dd>
                <input type="text" name="title" class="form-control" value="${not empty title ? title : board.title}" />
            </dd>
        </dl>

        <dl>
            <dt>작성자</dt>
            <dd>
                <input type="text" name="writer" class="form-control" value="${not empty writer ? writer : board.writer}" />
            </dd>
        </dl>

        <dl>
            <dt>내용</dt>
            <dd>
                <textarea name="content" class="content form-control" style="height: 300px;">${not empty content ? content : board.content}</textarea>
            </dd>
        </dl>

        <button type="submit" class="btn btn-info">수정</button>
		<button type="button" class="btn btn-primary" onclick="location.href='<c:url value='/board/boardhome' />'">목록</button>
    </form>
</div>

