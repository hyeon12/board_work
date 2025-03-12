<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script>
$(document).ready(function() {
    loadBoardList(); // 페이지 로드 시 게시글 목록 가져오기

    function loadBoardList() {
        $.ajax({
            url: "/board/list",  // 서버에서 게시글 목록을 불러올 URL
            type: "GET",
            success: function(data) {
                $("#boardListContainer").html(data); // 게시글 목록 삽입
            },
            error: function() {
                alert("게시글 목록을 불러오는 중 오류가 발생했습니다.");
            }
        });
    }
});
</script>

<div id="boardListContainer">
    <!-- AJAX로 불러온 게시글 목록이 여기에 들어감 -->
</div>
