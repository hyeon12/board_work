<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>javascript_ex</title>
		<style>    
			.multi-sel {
		    	padding: 2px;
		    }
		    
		    ul {
		    	padding: 0;
		    	list-style: none;
		    }
		</style>
	</head>
	<body>
		<h3>TEST2 - 구구단</h3>
		<select class="multi-sel" id="danSelect">
			<option value="">선택</option>
			<option value="1">1단</option>
			<option value="2">2단</option>
			<option value="3">3단</option>
			<option value="4">4단</option>
			<option value="5">5단</option>
			<option value="6">6단</option>
			<option value="7">7단</option>
			<option value="8">8단</option>
			<option value="9">9단</option>
		</select>
		<button id="view">계산</button>
		<div id="result"></div>

		<script>
			document.getElementById('view').addEventListener('click', function() {

				var selectedDan = document.getElementById('danSelect').value;
				var resultDiv = document.getElementById('result');

				if (selectedDan === ""){
					resultDiv.innerHTML = "";
					return;
				}

				var result = "<ul>";
				for (var i = 1; i <= 9; i++) {
						result += "<li>" + selectedDan + "X" + i + "=" + (selectedDan * i) + "</li>";
				}
				result += "</ul>";

				resultDiv.innerHTML = result;
				});
		</script>
	</body>
</html>
