<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<dl>
	<dt>제목</dt>
	<dd>
		<form:input type="text" path="title" cssClass="form-control" />
		<form:errors path="title" />
	</dd>
</dl>
<dl>
	<dt>작성자</dt>
	<dd>
		<form:input type="text" path="writer" cssClass="form-control" />
		<form:errors path="writer" />
	</dd>
</dl>
<dl>
	<dt>내용</dt>
	<dd>
		<form:textarea name="content" path="content" cssClass="form-control" />
		<form:errors path="content" />
	</dd>
</dl>