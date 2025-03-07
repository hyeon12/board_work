package woo.edu.c.service;

import java.util.List;
import java.util.Optional;

import woo.edu.c.controller.BoardForm;
import woo.edu.c.vo.Board;

public interface BoardService {

	
	// �Խñ� ���
    List<Board> getList();
    
    // �Խñ� �� ����
    Optional<Board> get(Long bno);
    
    // �Խñ� ���� ���
    BoardForm getForm(Long bno);
    
    // �Խñ� ���� + ����
    boolean update(BoardForm form);
    
    // �Խñ� ����
    boolean delete(Long bno);
}
