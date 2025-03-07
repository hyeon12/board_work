package mappers;

import java.util.List;

import woo.edu.c.vo.Board;

public interface BoardMapper {

	List<Board> select();
	
	int register(Board board);
	
	Board select_one(Long bno);
	
	int update(Board board);
	
	int delete(Long bno);
}
