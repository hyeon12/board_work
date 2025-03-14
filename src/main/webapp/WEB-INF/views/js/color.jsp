<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<style>
			select {
				padding: 2px;
			}
		</style>
	</head>
	<body>
		<h3>TEST4 - 색상변경</h3>
		<div id="result1">
			<div>첫번째</div>
			<div>두번째</div>
			<div>세번째</div>
			<div>네번째</div>
		</div>
		<select class="seq-sel" id="seqSelect">
			<option id="sel" value="sel">선택</option>
			<option value="all">전체</option>
			<option value="첫번째">첫번째</option>
			<option value="두번째">두번째</option>
			<option value="세번째">세번째</option>
			<option value="네번째">네번째</option>
		</select>
		<select class="color-sel" id="colorSelect">
			<option value="sel">선택</option>
			<option value="red">빨강</option>
			<option value="blue">파랑</option>
			<option value="yellow">노랑</option>
			<option value="green">초록</option>
		</select>
		<button id="change">변경</button>
		
		<script>
		document.getElementById('change').addEventListener('click', function() {
			var selectedOption = document.getElementById('seqSelect').value;
			var selectedColor = document.getElementById('colorSelect').value;
			
			// 색상 선택 안했을 때 경고 메시지
			if (selectedColor === "sel") {
				alert("변경할 색상을 선택해주세요");
				return;
			}
			
			 // 모든 div의 색상 초기화
		    var allDivs = document.querySelectorAll('#result1 div');
		    allDivs.forEach(function(div) {
		        div.style.color = ''; // 초기화
		    });
			
			// 선택된 항목에 해당하는 div를 찾아 색상 변경
			var targetDiv = null;
			if (selectedOption === "all") {
				// "전체"가 선택되었을 경우, 모든 항목의 색상을 변경
				var allDivs = document.querySelectorAll('#result1 div');
				allDivs.forEach(function(div) {
					div.style.color = '';
					div.style.color = selectedColor;
				});
			} else if (selectedOption !== "sel") {
				// "첫번째", "두번째", "세번째", "네번째" 선택 시 해당하는 div의 색상만 변경
				targetDiv = document.querySelector('#result1 div:nth-child(' + (["첫번째", "두번째", "세번째", "네번째"].indexOf(selectedOption) + 1) + ')');
				if (targetDiv) {
					
					targetDiv.style.color = selectedColor;
				}
			}
		});
		</script>
	</body>
</html>
