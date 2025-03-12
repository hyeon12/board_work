package woo.edu.c.service;

import java.util.List;
import java.util.Optional;
import woo.edu.c.vo.BoardVo;

public interface BoardService {

	// �Խñ� ���
    List<BoardVo> getList();
    
    // �Խñ� �� ����
    Optional<BoardVo> get(Long bno);
    
    // �Խñ� ���� + ����
    boolean update(Long bno, String title, String writer, String content, String mode);
    
    // �Խñ� ����
    boolean delete(Long bno);
}
