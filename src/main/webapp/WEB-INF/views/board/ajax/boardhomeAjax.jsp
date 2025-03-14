<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<%@ include file="/WEB-INF/views/common/nav.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
    <style>
		.layout-width {
				max-width: 1300px;
				min-width: 1000px;
				margin: 0 auto;
				
			a {
			    text-decoration: none;
			}
		}
		
		.layout-bottom {
			padding: 20px 10px;
		}
		
		dt {
			margin-bottom: 7px;
		}
		/*
		th:nth-child(1) {
			width: 5%;
		}
		
	    th:nth-child(2) {
	        width: 15%;
	    }
	
	    th:nth-child(3) {
	        width: 40%; 
	    }
	
	    th:nth-child(4) {
	        width: 20%;
	    }
	
	    th:nth-child(5) {
	        width: 20%;
	    }*/
	</style>
</head>
<body>
<div class="layout-width">
    <h1>게시판</h1>
    <table class="table table-striped">
        <thead>
            <tr>
	            <th><input type="checkbox"/> 전체선택</th>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>날짜</th>
            </tr>
        </thead>
        <tbody id="ajax-item"></tbody>
	</table>
	<button type="button" id="write-btn" class="btn btn-success">글쓰기</button>
	<div id="ajax-bottom" class="layout-bottom"></div>
</div>
</body>

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
			  this.toggleWriteForm();
        });
    },

    // 글쓰기 양식 토글 처리
    toggleWriteForm() {
        const targetEl = document.getElementById("ajax-bottom");

        if (this.isWriteFormVisible) {
            // 글쓰기 양식이 이미 보이고 있으면 숨김
            targetEl.innerHTML = "";
        } else {
            // 글쓰기 양식이 보이지 않으면 표시
            this.write();
        }

        // 글쓰기 양식 상태를 토글
        this.isWriteFormVisible = !this.isWriteFormVisible;
    },
	/**
	* 화면 렌더링 
	* 추가, 삭제 등 목록 출력에 변경사항이 발생하면 이 함수를 호출해서 화면 출력을 갱신
	*/
	render() {
		// 1. 목록 출력 템플릿 가져오기
		const tpl = this.getTpl("item");
		const targetEl = document.getElementById("ajax-item");
		const domParser = new DOMParser();
		
		// 목록 데이터 조회 하기 
		(async() => {
			const res = await fetch(this.getApiUrl('/api/board/list')); //비동기 작업 먼저
			if (res.status === 200) {
				const items = await res.json();
				targetEl.innerHTML = `
					<tr>
	                    <td colspan="5" style="text-align: left;">
	                    <button class="btn btn-danger">선택삭제</button>
	                	</td>
            		</tr>`;
				items.forEach(item => {
					let html = tpl; 
					
					// 날짜 형식화
					const date = new Date(item.regDateStr);
					const year = date.getFullYear();
					const month = ("" + (date.getMonth() +1)).padStart(2, '0');
					const day = ("" + date.getDate()).padStart(2, '0');
					const hour = ("" + date.getHours()).padStart(2, '0');
					const min = ("" + date.getMinutes()).padStart(2, '0');
					const sec = ("" + date.getSeconds()).padStart(2, '0');

					const regDate = year + "-" + month + "-" + day + " " + hour + ":" + min + ":" + sec;
					
					// 정규표현식 패턴과 데이터 치환
					html = html.replace(/\[\[bno\]\]/g, item.bno)
								.replace(/\[\[title\]\]/g, item.title)
								.replace(/\[\[writer\]\]/g, item.writer)
								.replace(/\[\[regDate\]\]/g, regDate);

					const dom = domParser.parseFromString(html, "text/html");
					const itemEl = dom.querySelector("tr");

					targetEl.append(itemEl);
					
					
					//글 보기 이벤트 처리 S 
					const viewEl = itemEl.querySelector(".view-content a");
					viewEl.addEventListener("click", () => {
						event.preventDefault();
						this.view(item.bno);
					});
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
	* 게시글 등록 처리 
	* 둥록이 완료 되면 화면 갱신 
	*/
	write() {
	    const tpl = this.getTpl("write");

	    const targetEl = document.getElementById("ajax-bottom");
	    targetEl.innerHTML = tpl;

	    const formEl = targetEl.querySelector("form");

	    // 폼 검증 함수
	    const validateForm = (formEl) => {
	        const requiredField = {
	            title: '제목을 입력하세요.',
	            writer: '작성자를 입력하세요.',
	            content: '내용을 입력하세요.',
	        };

	        for (const [key, msg] of Object.entries(requiredField)) {
	            const value = formEl[key].value;
	            if (!value.trim()) return msg;  // 필수 항목이 비어 있으면 메시지 반환
	        }
	        return null;  // 검증 성공
	    };

	    formEl.addEventListener("submit", async (e) => {
	        e.preventDefault();  // 폼 제출 기본 동작 차단
	
	        // 폼 검증
	        const validationError = validateForm(formEl); // 직접 함수 호출
	        if (validationError) {
	            alert(validationError);
	            return;
	        }
	        
	        // 요청 처리
	        try {
	            const res = await fetch(this.getApiUrl('/api/board/create'), {
	                method: "POST",
	                headers: { "Content-Type": "application/json" },
	                body: JSON.stringify({  // body에 전송할 데이터 객체를 JSON.stringify로 전달
	                    title: formEl.title.value,
	                    content: formEl.content.value,
	                    writer: formEl.writer.value,
	                }),
	            });
	
	            if (res.status === 200) {
	                this.render();  // 게시글 작성 후 화면 갱신
	                targetEl.innerHTML = ""; // 폼을 제거하고 새로 렌더링
	                
	                this.isWriteFormVisible = false;  // 토글 초기화               	                
	            } else {
	                const result = await res.json();
	                if (result.error) alert(result.message);
	            }
	        } catch (err) {
	            console.error("글 작성 실패", err);
	            alert("게시글 작성 중 오류가 발생했습니다.");
	        }
	    });
	},

	/**
	* 게시글 보기
	*/
	view(bno) {
		// 템플릿 가져오기 
		let html = this.getTpl("view");

		// 출력 target 요소 선택
		const targetEl = document.getElementById("ajax-bottom");

		const domParser = new DOMParser();
		
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

				targetEl.innerHTML = ''; // 기존 로딩 상태를 제거
				targetEl.append(layout);

				// 닫기
				const closeEl = layout.querySelector("#close");
				closeEl.addEventListener("click", () => {
						targetEl.innerHTML = "";
				})
			}
		})();

	},
	
	/**
	* 게시글 삭제
	* 삭제가 완료되면 화면 갱신
	*/
	delete(bno) {
		// 처리 로직 
		if (!confirm('삭제하겠습니까?')) {
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
	*/
	getTpl(tplName) {
		const el = document.getElementById(tplName);
		if (el) return el.innerHTML;
	},

	/**
	* fetch 사용시 필요한 url
	*/
	getApiUrl(url) {
		const { origin } = location;

		return origin + url;
	},
}	

window.addEventListener("DOMContentLoaded", function() {
	ajaxBoard.init();
});
</script>


<%-- 게시글 목록 --%>
<jsp:include page="_item.jsp" />

<%-- 글보기 --%>
<jsp:include page="_view.jsp" />

<%-- 글작성 --%>
<jsp:include page="_write.jsp" />