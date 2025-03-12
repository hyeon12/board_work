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
	
	// �Խñ� ��� ��ȯ (JSON ����)
    @GetMapping("/list")
    public List<BoardVo> getBoardList() {
        
        List<BoardVo> items = boardService.getList();
        
        items.forEach(System.out::println);
        return items; // ��ȯ�� ����Ʈ�� ��ȯ
    }
    	
    	//return boardService.getList(); // Board �����͸� JSON �������� ��ȯ
    
	// �Խñ� �� ����
	@GetMapping("/view/{bno}")
	public BoardVo getOne(@PathVariable("bno") Long bno) {
		BoardVo item = boardService.get(bno).orElseThrow(() -> new IllegalArgumentException("�Խñ��� ã�� �� �����ϴ�."));
		
		return item;
	}    

    // �Խñ� �ۼ� (JSON ��û �� ����)
    @PostMapping("/create")
    public BoardVo createBoard(@RequestBody BoardVo board) {
         // mode�� "edit"�̸� ����, �ƴϸ� ���� �ۼ�
        String mode = board.getBno() != null ? "edit" : "create";
        // ��ȿ�� �˻�
        validate(board, mode);
        
        boolean success = boardService.update(board.getBno(), board.getTitle(), board.getWriter(), board.getContent(), mode);
        
        if (success) {
            
            return board;  
        } else {
            return null;  
        }
    }
    
	// �Խñ� ����
    @ResponseStatus(HttpStatus.NO_CONTENT)
	@GetMapping("/delete/{bno}")
	public void delete(@PathVariable("bno") Long bno) {
    	boardService.get(bno).orElseThrow(() -> new IllegalArgumentException("�Խñ��� ã�� �� �����ϴ�."));
    	
		boardService.delete(bno);
	}
    
    /**
     * �� �ۼ�, ������ ��ȿ�� �˻�
     * @param data
     */
    private void validate(BoardVo data, String mode) {
    	checkRequired(data.getTitle(), "������ �Է��ϼ���.");
    	checkRequired(data.getContent(), "������ �Է��ϼ���.");
    	checkRequired(data.getWriter(), "�ۼ��ڸ� �Է��ϼ���.");
    	
    	/* bno ������ ���� �����Ǵ� mode -> ���� ���ʿ�! => ���� ��, checkRequired �Ű����� Object�� ����ȯ �ʿ�
    	if (mode != null && mode.equals("edit")) {
    		checkRequired(data.getBno(), "�߸��� �����Դϴ�.");
    	}*/
    	
    }
    
    private void checkRequired(String str, String message) {
    	if (str == null || str.trim().isEmpty()) {
    		throw new IllegalArgumentException(message);
    	}
    }
    
    @ExceptionHandler(Exception.class)
    public ResponseEntity<Map<String, Object>> errorHandler(Exception e) {
		
    	HttpStatus status = HttpStatus.INTERNAL_SERVER_ERROR; // �⺻ ���� �ڵ� 500
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

