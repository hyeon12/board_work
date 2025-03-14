<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<script type="text/html" id="item">
<table>
	<tr id='item-[[bno]]'>
		<td><input type="checkbox"/></td>
		<td>[[bno]]</td>
		<td class='view-content'>
        <a href>
   			[[title]]
		</a>
   		</td>
   		<td>[[writer]]</td>
		<td>
			[[regDate]]
		<button type="button" class="delete btn btn-danger">삭제</button>
		</td>
	</tr>
</table>
</script>