<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<c:url var="rootUrl" value="/" /> <%-- 컨택스트 경로 고려 --%>
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
        <tbody id="ajax-item"></tbody>
	</table>
	<button type="button" id="write-btn">글쓰기</button>
	<div id="ajax-bottom"></div>
</div>

<script>
const ajaxBoard = {
	/**
	* 초기화 작업 - DOM 로드 후 처음 처리될 작업
	* 1. 게시판 목록 출력
	* 2. 글쓰기 버튼 이벤트 처리
	*/
	init() {
		// 화면 출력
		this.render();

		const writeEl = document.getElementById("write-btn");
		writeEl.addEventListener("click", () => {
			this.write();
		});
	},
	/**
	* 화면 렌더링 
	*
	* 추가, 삭제 등 목록 출력에 변경사항이 발생하면 이 함수를 호출해서 화면 출력을 갱신한다.
	*/
	render() {
		// 1. 목록 출력 템플릿 가져오기
		const tpl = this.getTpl("item");
		const targetEl = document.getElementById("ajax-item");
		const domParser = new DOMParser();


		// 화면 초기화
		targetEl.innerHTML = '<tr><td colspan="4">게시글을 조회하고 있습니다...</td></tr>';
		
		// 목록 데이터 조회 하기 
		(async() => {
			const res = await fetch(this.getApiUrl('/api/board/list'));
			if (res.status === 200) {
				targetEl.innerHTML = "";
				const items = await res.json();
				items.forEach(item => {
					let html = tpl; 
					const date = new Date(item.regDateStr);
					const year = date.getFullYear();
					const month = ("" + date.getMonth()).padStart(2, '0');
					const day = ("" + date.getDate()).padStart(2, '0');
					const hour = ("" + date.getHours()).padStart(2, '0');
					const min = ("" + date.getMinutes()).padStart(2, '0');

					const regDate = year + "-" + month + "-" + day + " " + hour + ":" + min;

					html = html.replace(/\[\[bno\]\]/g, item.bno)
								.replace(/\[\[title\]\]/g, item.title)
								.replace(/\[\[writer\]\]/g, item.writer)
								.replace(/\[\[regDate\]\]/g, regDate);

					const dom = domParser.parseFromString(html, "text/html");
					const itemEl = dom.querySelector("tr");
					targetEl.append(itemEl);

					// 글 보기 이벤트 처리 S 
					const viewEl = itemEl.querySelector(".view-content");
					viewEl.addEventListener("click", () => this.view(item.bno));
					// 글보기 이벤트 처리 E

					// 글 삭제 이벤트 처리 S
					const deleteEl = itemEl.querySelector(".delete");
					deleteEl.addEventListener("click", () => this.delete(item.bno));
					// 글 삭제 이벤트 처리 E
				});
			}
		})();
		
		
	},
	/**
	* fetch 사용시 전체 URL이 칠요하므로 변환한다.
	* 
	*/
	getApiUrl(url) {
		const rootUrl = "${rootUrl}";
		const { origin } = location;
		return origin + rootUrl + url;
	},
	/**
	* 게시글 등록 처리 
	* 
	* 둥록이 완료 되면 화면 갱신 
	*/
	write() {
		// 처리 로직 
		const tpl = this.getTpl("write");

		//타겟 가져와서 템플릿 치환
		const targetEl = document.getElementById("ajax-bottom");
		targetEl.append(tpl);

		const domParser = new DOMParser();

		const dom = domParser.parseFromString(tpl,"text/html");
		
		const formEl = dom.querySelector("form");
		targetEl.innerHTML = "";
		targetEl.append(formEl);

		// 양식 처리 
		formEl.addEventListener("submit", (e) => {
			e.preventDefault(); // 양식 제출 기본 동작 차단 (ajax 처리 위함)
			const requiredField = {
					title: '제목을 입력하세요.',
					content: '내용을 입력하세요.',
					writer: '작성자를 입력하세요.',
			};
				
			try {
				for (const [key, msg] of Object.entries(requiredField)) {
					const value = formEl[key].value;
					if (!value || !value.trim()) {
						throw new Error(msg);
					}
				}
			} catch (err) {
				alert(err.message);
				return;
			}

			// 전송 데이터 가공
			//  body의 데이터 유형은 반드시 "Content-Type" 헤더와 일치해야 함 - mdn
			const body = JSON.stringify({
				title: formEl.title.value,
				content: formEl.content.value,
				writer: formEl.writer.value,
			});

			// 요청 처리
			(async() => {
				const res = await fetch(this.getApiUrl('/api/board/create'), {
					method: "POST",
					headers: {
						"Content-Type": "application/json",
					},
					body,
				});


				if (res.status === 200) {
					this.render();
					targetEl.innerHTML = "";
				} else {
					const result = await res.json();
					if (result.error) {
						alert(result.message);
					}
				} 
				
			})();
			
		});

	},
	/**
	* 게시글 보기
	*
	*/
	view(bno) {
		// 템플릿 가져오기 
		let html = this.getTpl("view");

		// 출력 target 요소 선택
		const targetEl = document.getElementById("ajax-bottom");

		const domParser = new DOMParser();

		targetEl.innerHTML = "";
		
		// 데이터 조회
		(async() => {
			const res = await fetch(this.getApiUrl("/api/board/view/" + bno));
			if (res.status == 200) {
				const item = await res.json();

				html = html.replace(/\[\[bno\]\]/g, item.bno)
							.replace(/\[\[title\]\]/g, item.title)
							.replace(/\[\[writer\]\]/g, item.writer)
							.replace(/\[\[content\]\]/g, item.content);

				const dom = domParser.parseFromString(html, 'text/html');
				const layout = dom.querySelector(".view-layout");
				targetEl.append(layout);

				// 닫기
				const closeEl = layout.querySelector(".close");
				closeEl.addEventListener("click", () => {
						targetEl.innerHTML = "";
				})
			}
		})();

	},
	/**
	* 게시글 삭제
	*
	* 삭제가 완료되면 화면 갱신
	*/
	delete(bno) {
		// 처리 로직 
		if (!confirm('정말 삭제하겠습니까?')) {
			return;
		}

		(async() => {
			const res = await fetch(this.getApiUrl("/api/board/delete/" + bno));
			if (res.status === 204) {
				// 화면 갱신 
				this.render();
			}
		})();
		
		
	},
	/**
	* 템플릿 조회
	*
	*/
	getTpl(tplName) {
		const tplId = "tpl-" + tplName;
		const el = document.getElementById(tplId);
		if (el) return el.innerHTML;
	}
}

window.addEventListener("DOMContentLoaded", function() {
	ajaxBoard.init();
});
</script>


<%-- 게시글 목록 템플릿 --%>
<jsp:include page="tpl/_item.jsp" />

<%-- 글보기 템플릿 --%>
<jsp:include page="tpl/_view.jsp" />

<%-- 글작성 템플릿 --%>
<jsp:include page="tpl/_write.jsp" />