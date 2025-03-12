package woo.edu.c.vo;

import java.time.LocalDateTime;
import java.util.Date;

public class BoardVo {
    private Long bno;
    private String title;
    private String content;
    private String writer;
    
    private LocalDateTime regDate;
    private String regDateStr;
    
    private LocalDateTime updateDate;
    private Date formattedRegDate;
    
	public Long getBno() {
		return bno;
	}
	public void setBno(Long bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public LocalDateTime getRegDate() {
		return regDate;
	}
		
	public void setRegDate(LocalDateTime regDate) {
		this.regDate = regDate;
	}
	
	public void setRegDateStr(String regDateStr) {
		this.regDateStr = regDateStr;
	}
	
	public String getRegDateStr() { 
	
		return regDateStr;
	}
	
	public LocalDateTime getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(LocalDateTime updateDate) {
		this.updateDate = updateDate;
	}
	public Date getFormattedRegDate() {
		return formattedRegDate;
	}
	public void setFormattedRegDate(Date formattedRegDate) {
		this.formattedRegDate = formattedRegDate;
	}
	
	@Override
	public String toString() {
		return "Board [bno=" + bno + ", title=" + title + ", content=" + content + ", writer=" + writer + ", regDate="
				+ regDate + ", updateDate=" + updateDate + ", formattedRegDate=" + formattedRegDate + ", regDateStr=" + regDateStr + "]";
	}
}
