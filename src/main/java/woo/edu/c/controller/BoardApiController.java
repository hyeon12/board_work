package woo.edu.c.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import woo.edu.c.service.BoardService;
import woo.edu.c.vo.BoardVo;

@RestController
@RequestMapping("/api/board")
@RequiredArgsConstructor
public class BoardApiController {

	private final BoardService boardService;
	
	// 게시글 목록 반환 (JSON 형태)
    @GetMapping("/list")
    public List<BoardVo> getBoardList() {
        
        List<BoardVo> items = boardService.getList();
        
        items.forEach(System.out::println);
        return items; // 변환된 리스트를 반환
    }
    	
    	//return boardService.getList(); // Board 데이터를 JSON 형식으로 반환
    
	// 게시글 상세 보기
	@GetMapping("/view/{bno}")
	public BoardVo getOne(@PathVariable("bno") Long bno) {
		BoardVo item = boardService.get(bno).orElseThrow(() -> new IllegalArgumentException("게시글을 찾을 수 없습니다."));
		
		return item;
	}    

    // 게시글 작성 (JSON 요청 및 응답)
    @PostMapping("/create")
    public BoardVo createBoard(@RequestBody BoardVo board) {
         // mode가 "edit"이면 수정, 아니면 새로 작성
        String mode = board.getBno() != null ? "edit" : "create";
        // 유효성 검사
        validate(board, mode);
        
        boolean success = boardService.update(board.getBno(), board.getTitle(), board.getWriter(), board.getContent(), mode);
        
        if (success) {
            
            return board;  
        } else {
            return null;  
        }
    }
    
	// 게시글 삭제
    @ResponseStatus(HttpStatus.NO_CONTENT)
	@GetMapping("/delete/{bno}")
	public void delete(@PathVariable("bno") Long bno) {
    	boardService.get(bno).orElseThrow(() -> new IllegalArgumentException("게시글을 찾을 수 없습니다."));
    	
		boardService.delete(bno);
	}
    
    /**
     * 글 작성, 수정시 유효성 검사
     * @param data
     */
    private void validate(BoardVo data, String mode) {
    	checkRequired(data.getTitle(), "제목을 입력하세요.");
    	checkRequired(data.getContent(), "내용을 입력하세요.");
    	checkRequired(data.getWriter(), "작성자를 입력하세요.");
    	
    	/* bno 유무에 따라 결정되는 mode -> 검증 불필요! => 접근 시, checkRequired 매개변수 Object로 형변환 필요
    	if (mode != null && mode.equals("edit")) {
    		checkRequired(data.getBno(), "잘못된 접근입니다.");
    	}*/
    	
    }
    
    private void checkRequired(String str, String message) {
    	if (str == null || str.trim().isEmpty()) {
    		throw new IllegalArgumentException(message);
    	}
    }
    
    @ExceptionHandler(Exception.class)
    public ResponseEntity<Map<String, Object>> errorHandler(Exception e) {
		
    	HttpStatus status = HttpStatus.INTERNAL_SERVER_ERROR; // 기본 응답 코드 500
    	if (e instanceof IllegalArgumentException) {
    		status = HttpStatus.BAD_REQUEST;
    	}
    	
    	Map<String, Object> data = new HashMap<>();
    	data.put("error", true);
    	data.put("message", e.getMessage());
    	data.put("status", status);
    	
    	return ResponseEntity.status(status).body(data);
    }
}

