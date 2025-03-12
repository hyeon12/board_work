<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<ul class="nav nav-tabs" id="myTab">
    <li class="${menuCode == 'home' ? 'active' : ''}" id="home">
        <a href="<c:url value='/' />">HOME</a>
    </li>
    <li class="${menuCode == 'board' ? 'active' : ''}" id="board">
        <a href="#" class="dropdown-toggle">게시판 ▾</a> 
        <ul class="dropdown-menu">
            <li><a href="<c:url value='/board/boardhome' />">게시글 목록</a></li>
            <li><a href="<c:url value='/board/ajax/list' />">게시판 목록 ajax</a></li>
        </ul>
    </li>
</ul>

<script>
$(document).ready(function() {
    console.log("[네비게이션바] 적용 jsp");

    var loc = location.pathname.split("/"); // 현재 페이지 URL에서 경로 추출
    console.log("loc => " + loc);
    
    if (loc.length > 2) {
        if (loc[1] === "board") {
            $("#board").addClass("active");
        } else if (loc[1] === "") {
            $("#home").addClass("active");
        }
    } else if (loc[1] === "") {
        $("#home").addClass("active");
    }

    // 게시판 메뉴 클릭 시 드롭다운 메뉴 표시/숨김
    $("#board .dropdown-toggle").click(function(e) {
        e.preventDefault(); // 링크 이동 방지
        $(".dropdown-menu").slideToggle(); // 메뉴 토글
    });

    // 다른 곳 클릭하면 드롭다운 숨기기
    $(document).click(function(event) {
        if (!$(event.target).closest("#board").length) {
            $(".dropdown-menu").slideUp();
        }
    });
});
</script>