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
    <h1>게시글 작성</h1>

    <c:if test="${not empty errorMessage}">
        <script type="text/javascript">
            alert("${errorMessage}");
        </script>
    </c:if>

    <form action="${action}" method="post">
        <input type="hidden" name="mode" value="${mode}" />

        <dl>
            <dt>제목</dt>
            <dd>
                <input type="text" name="title" class="form-control" placeholder="제목을 입력해주세요" value="${title}" />
            </dd>
        </dl>

        <dl>
            <dt>작성자</dt>
            <dd>
                <input type="text" name="writer" class="form-control" placeholder="작성자를 입력해주세요" value="${writer}" />
            </dd>
        </dl>

        <dl>
            <dt>내용</dt>
            <dd>
                <textarea name="content" class="content form-control" placeholder="내용을 입력해주세요" style="height: 300px;">${content}</textarea>
            </dd>
        </dl>

        <button type="submit" class="btn btn-info">작성</button>
		<button type="button" class="btn btn-primary" onclick="location.href='<c:url value='/board/boardhome' />'">목록</button>
    </form>
</div>


