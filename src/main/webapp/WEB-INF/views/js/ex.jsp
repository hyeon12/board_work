<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<%@ include file="/WEB-INF/views/common/nav.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>javascript_ex</title>
		<style>
		    .multi {
				margin: 30px;
		    }
		    
		    .col {
		    	margin: 30px;
		    }
	    </style>	
	</head>
	<body>
		<nav>
			<div class="multi">
				<jsp:include page="multiplication.jsp" />
			</div>
			<div class="col">
				<jsp:include page="color.jsp" />
			</div>
		</nav>
	</body>
</html>
