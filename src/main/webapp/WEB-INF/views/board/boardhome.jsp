<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<%@ include file="/WEB-INF/views/common/nav.jsp" %>

<style>
    .layout-width {
		max-width: 1300px;
		min-width: 1000px;
		margin: 0 auto;
    }
</style>

<div class="layout-width">
    <h1>게시판</h1>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>날짜</th>
            </tr>
        </thead>
        <tbody>
        <c:if test="${items == null || empty items}">
            <tr>
                <td colspan="4">등록된 게시글이 없습니다.</td>
            </tr>
        </c:if>
        <c:if test="${items != null && !empty items}">
            <c:forEach var="item" items="${items}">
            <tr>
                <td>${item.bno}</td>
                <td>
                    <a href="<c:url value='/board/view/${item.bno}' />">
                    ${item.title}
                    </a>
                </td>
                <td>${item.writer}</td>
                <td>
                    <c:if test="${item.formattedRegDate != null}">
                        <!-- 변환된 Date를 출력 -->
                        <fmt:formatDate value="${item.formattedRegDate}" pattern="yyyy-MM-dd HH:mm:ss" />
                    </c:if>       
                </td>
            </tr>
            </c:forEach>
        </c:if>
        </tbody>
    </table>
    <a href="<c:url value='/board/write' />">
    	<button type="button" class="btn btn-success">글쓰기</button>
   	</a>
</div>
