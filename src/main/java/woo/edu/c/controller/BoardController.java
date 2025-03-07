package woo.edu.c.controller;

import java.util.Arrays;
import java.util.List;


import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import woo.edu.c.service.BoardService;
import woo.edu.c.validator.BoardValidator;
import woo.edu.c.vo.Board;
import woo.edu.c.controller.BoardForm;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	private final BoardService boardService;
	private final BoardValidator validator;
	
	@ModelAttribute("addCss")
	public List<String> addCss() {
		return Arrays.asList("board/style");
	}
	
	// 게시글 목록
	@GetMapping("/list")
	public String list(Model model) {
		List<Board> items = boardService.getList();
		
		model.addAttribute("items", items);
		return "board/list";
	}
	
	
	// 게시글 상세 보기
	@GetMapping("/view/{bno}")
	public String view(@PathVariable("bno") Long bno, Model model) {
		Board item = boardService.get(bno).orElseThrow(RuntimeException::new);
		
		model.addAttribute("item", item);
		return "board/view";
	}
	
	@GetMapping("/write")
	public String write(@ModelAttribute BoardForm form) {
		form.setMode("write");
		
		return "board/write";
	}
	
	@GetMapping("/edit/{bno}")
	public String edit(@PathVariable("bno") Long bno, Model model) {
		BoardForm form = boardService.getForm(bno);
		
		model.addAttribute("boardForm", form);
		return "board/edit";
	}
	
	/**
	 * 게시글 등록, 수정
	 * @return
	 */
	@PostMapping("/save")
	public String save(@Valid BoardForm form, Errors errors) {
		
		validator.validate(form, errors);
		
		String mode = form.getMode();
		mode = StringUtils.hasText(mode) ? mode : "write";
		if (errors.hasErrors()) {
			return "board/" + mode;
		}
		
		boardService.update(form);
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/delete/{bno}")
	public String delete(@PathVariable("bno") Long bno) {
		
		boardService.delete(bno);
		
		return "redirect:/board/list";
	}
	/*
	// 硫붿씤 �솕硫�
	@RequestMapping(value = "/board/list")
	public String home(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {
		logger.info("/board/list");
		return "board/list";
	}
	
	// test
	@RequestMapping(value = "/board/test", method = RequestMethod.GET)
	public String boardList(Model model) throws Exception {
		logger.info("/board/test");
		List<testVo> test = boardService.test();
		model.addAttribute("boardList", test);
		return "/board/boardhome";
	}
	*/	
		
}




