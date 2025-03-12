<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <h1>게시글 목록</h1>

    <!-- 게시글 목록을 표시할 테이블 -->
    <table class="table table-striped">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
            </tr>
        </thead>
        <tbody id="board-list">
            <!-- AJAX를 통해 게시글 목록이 동적으로 추가됩니다 -->
        </tbody>
    </table>

    <script>
        // 페이지 로드 후, 게시글 목록을 AJAX로 불러오기
(async () => { 
    const res = await fetch('/api/board/list');
    if (res.status === 200) {
        const items = await res.json(); // 서버로부터 받은 JSON 데이터
        const targetEl = document.querySelector('#board-list'); // 테이블의 tbody를 선택

        targetEl.innerHTML = ""; // 기존 데이터를 초기화

        // 항목마다 반복
        items.forEach(item => {
            // 날짜 포맷 변환
            const date = new Date(item.regDateStr);
            const year = date.getFullYear();
            const month = ("" + (date.getMonth() + 1)).padStart(2, '0');
            const day = ("" + date.getDate()).padStart(2, '0');
            const hour = ("" + date.getHours()).padStart(2, '0');
            const min = ("" + date.getMinutes()).padStart(2, '0');

            const regDate = year + "-" + month + "-" + day + " " + hour + ":" + min; // 날짜 형식

            // tr 엘리먼트 생성
            const row = document.createElement('tr');

            // td 엘리먼트 생성 및 데이터 삽입
            const tdBno = document.createElement('td');
            tdBno.textContent = item.bno;
            row.appendChild(tdBno);

            const tdTitle = document.createElement('td');
            tdTitle.textContent = item.title;
            row.appendChild(tdTitle);

            const tdWriter = document.createElement('td');
            tdWriter.textContent = item.writer;
            row.appendChild(tdWriter);

            const tdRegDate = document.createElement('td');
            tdRegDate.textContent = regDate;
            row.appendChild(tdRegDate);

            // 행을 tbody에 추가
            targetEl.appendChild(row);

            // '보기' 버튼 클릭 이벤트 처리
            const viewEl = row.querySelector(".view-content");
            if (viewEl) {
                viewEl.addEventListener("click", () => view(item.bno));
            }

            // '삭제' 버튼 클릭 이벤트 처리
            const deleteEl = row.querySelector(".delete");
            if (deleteEl) {
                deleteEl.addEventListener("click", () => deletePost(item.bno));
            }
        });
    }
})();
    </script>
</div>
