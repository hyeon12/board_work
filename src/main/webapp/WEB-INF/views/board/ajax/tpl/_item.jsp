<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/html" id="tpl-item">
<table>
<tr id='item-[[bno]]'>
	<td>[[bno]]</td>
    <td class='view-content'>
   		[[title]]
    </td>
    <td>[[writer]]</td>
	<td>
		[[regDate]]
		<button type='button' class="delete">삭제</button>
	</td>
</tr>
</table>
</script>