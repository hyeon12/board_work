package woo.edu.c.service;

import java.util.List;
import java.util.Optional;
import woo.edu.c.vo.BoardVo;

public interface BoardService {

	// 게시글 목록
    List<BoardVo> getList();
    
    // 게시글 상세 보기
    Optional<BoardVo> get(Long bno);
    
    // 게시글 쓰기 + 수정
    boolean update(Long bno, String title, String writer, String content, String mode);
    
    // 게시글 삭제
    boolean delete(Long bno);
}
