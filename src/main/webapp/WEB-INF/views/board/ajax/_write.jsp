<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<script type="text/html" id="write">
<form autocomplete="off">
	<input type="hidden" name="mode" value="write" />
        <dl>
            <dt>제목</dt>
            <dd>
                <input type="text" name="title" class="form-control" placeholder="제목을 입력해주세요" value="${title}" />
            </dd>
        </dl>

        <dl>
            <dt>작성자</dt>
            <dd>
                <input type="text" name="writer" class="form-control" placeholder="작성자를 입력해주세요" value="${writer}" />
            </dd>
        </dl>
        <dl>
        	<dt>내용</dt>
       		<dd>
        		<textarea name="content" class="content form-control" placeholder="내용을 입력해주세요" style="height: 300px;">${content}</textarea>
    		</dd>
    	</dl>
	<button type="submit" class="btn btn-info">작성</button>
</form>
</script>