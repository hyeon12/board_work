package woo.edu.c.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mappers.BoardMapper;
import woo.edu.c.controller.BoardForm;
import woo.edu.c.vo.Board;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardMapper mapper;
	
	@Override
	public List<Board> getList() {
		// TODO Auto-generated method stub
		
		return mapper.select();
	}

	@Override
	public Optional<Board> get(Long bno) {
		Board board = mapper.select_one(bno);
		return Optional.ofNullable(board);
	}

	@Override
	public BoardForm getForm(Long bno) {
		Board board = get(bno).orElseThrow(RuntimeException::new);
		BoardForm form = new BoardForm();
		
		form.setMode("edit");
		form.setBno(board.getBno());
		form.setTitle(board.getTitle());
		form.setWriter(board.getWriter());
		form.setContent(board.getContent());
	
		return form;
	}
	
	@Override
	public boolean update(BoardForm form) {
		// TODO Auto-generated method stub
		Board board = new Board();
		board.setBno(form.getBno());
		board.setTitle(form.getTitle());
		board.setContent(form.getContent());
		board.setWriter(form.getWriter());
		
		String mode = form.getMode();
		if (mode != null && mode.equals("edit")) { // 수정
			board.setUpdateDate(LocalDateTime.now());
			
			return mapper.update(board) > 0;
		} else { // 추가 
			return mapper.register(board) > 0;
		}
		
	}

	@Override
	public boolean delete(Long bno) {
		// TODO Auto-generated method stub
		return mapper.delete(bno) > 0;
	}

}
