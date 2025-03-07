package woo.edu.c.controller;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class BoardForm {
	
	private String mode;
	
	private Long bno;

	@NotBlank
	private String title;
	@NotBlank
    private String content;
	@NotBlank
    private String writer;
}

