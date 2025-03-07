package woo.edu.c.service;

import java.util.List;
import java.util.Optional;

import woo.edu.c.controller.BoardForm;
import woo.edu.c.vo.Board;

public interface BoardService {

	
	// 게시글 목록
    List<Board> getList();
    
    // 게시글 상세 보기
    Optional<Board> get(Long bno);
    
    // 게시글 수정 양식
    BoardForm getForm(Long bno);
    
    // 게시글 쓰기 + 수정
    boolean update(BoardForm form);
    
    // 게시글 삭제
    boolean delete(Long bno);
}
