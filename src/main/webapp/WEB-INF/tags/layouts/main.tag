<%@ tag body-content="scriptless" %>
<%@ tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ attribute name="title" %>
<%@ attribute name="menuCode" %>

<layout:common title="${title}">
    <jsp:attribute name="header">
        <ul class="nav nav-tabs" id="myTab">
		    <li class="${menuCode == 'home' ? 'active': ''}"><a href="<c:url value='/' />">HOME</a></li>
		    <li class="${menuCode == 'board' ? 'active': ''}"><a href="<c:url value='/board/list' />">게시판</a></li>
		</ul>
    </jsp:attribute>
    <jsp:attribute name="footer">
      
    </jsp:attribute>
    <jsp:body>
        <jsp:doBody />
    </jsp:body>
   
</layout:common>