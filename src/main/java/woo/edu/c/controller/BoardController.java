package woo.edu.c.controller;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import lombok.RequiredArgsConstructor;

import woo.edu.c.service.BoardService;
import woo.edu.c.vo.BoardVo;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {
	

	private final BoardService boardService;

	// 게시글 목록
	@GetMapping("/boardhome")
	public String list(Model model) {
		List<BoardVo> items = boardService.getList();
				
		model.addAttribute("items", items);
		model.addAttribute("menuCode", "board");
		
		return "board/boardhome";
	}
	
	// 게시글 상세 보기
	@GetMapping("/view/{bno}")
	public String view(@PathVariable("bno") Long bno, Model model) {
		BoardVo item = boardService.get(bno).orElseThrow(RuntimeException::new);
		
		model.addAttribute("item", item);
		
		return "board/view";
	}
	
	// 게시글 작성 페이지로 이동
	@GetMapping("/write")
	public String write(Model model) {
		
		model.addAttribute("mode", "write"); // 작성
		
		return "board/write"; // write.jsp
		
	}
	
	// 게시글 수정 페이지로 이동
	@GetMapping("/edit/{bno}")
	public String edit(@PathVariable("bno") Long bno, Model model) {
		
		BoardVo board = boardService.get(bno).orElseThrow(RuntimeException::new); // bno로 게시글 조회
		
		model.addAttribute("board", board); // 게시글 데이터 전달
		model.addAttribute("mode", "edit");
		
		return "board/edit"; // edit.jsp
		
	}
	
	// 게시글 저장(등록 또는 수정)
	@PostMapping("/save")
	public String save(@RequestParam(value="bno", required = false) Long bno,
	                   @RequestParam String title,
	                   @RequestParam String writer,
	                   @RequestParam String content,
	                   @RequestParam(required = false) String mode,
	                   Model model) {

	    // mode가 없으면 기본값 "write"로 설정
	    mode = StringUtils.hasText(mode) ? mode : "write";

	    // 유효성 검사 수행
	    if (title.trim().isEmpty()) {
	        model.addAttribute("errorMessage", "제목을 입력하세요.");
	    } else if (writer.trim().isEmpty()) {
	        model.addAttribute("errorMessage", "작성자를 입력하세요.");
	    } else if (content.trim().isEmpty()) {
	        model.addAttribute("errorMessage", "내용을 입력하세요.");
	    }

	    // 에러 메시지가 있으면 작성/수정 폼으로 돌아감
	    if (model.containsAttribute("errorMessage")) {
	        model.addAttribute("title", title);
	        model.addAttribute("writer", writer);  
	        model.addAttribute("content", content);
	        model.addAttribute("mode", mode);
	        return "board/" + mode;  // 작성 또는 수정 페이지로 리턴
	    }

	    // 게시글 저장 또는 수정
	    boolean success = boardService.update(bno, title, writer, content, mode);
	    
	    if (!success) {
	    	
	        model.addAttribute("errorMessage", "게시글 저장에 실패했습니다.");
	        model.addAttribute("mode", mode);
	        
	        return "board/" + mode;  // 실패 시 동일 폼으로 리다이렉트
	    }

	    return "redirect:/board/boardhome";  // 게시판 목록으로 리다이렉트
	}
	
	// 게시글 삭제
	@GetMapping("/delete/{bno}")
	public String delete(@PathVariable("bno") Long bno) {
		
		boardService.delete(bno);
		
		return "redirect:/board/boardhome";
	}
	
	// ajax
	@GetMapping("/ajax/boardhomeAjax")
	public String ajaxList(){
		
		return "board/ajax/boardhomeAjax";
	}
	
	// javaScript_Ex
	@GetMapping("/ex")
	public String multiplication(Model model){
		
		model.addAttribute("menuCode", "ex");
		
		return "js/ex";
	}
}



