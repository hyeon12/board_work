package woo.edu.c.vo;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class Board {
    private Long bno;
    private String title;
    private String content;
    private String writer;
    private LocalDateTime regDate;
    private LocalDateTime updateDate;
	
}
