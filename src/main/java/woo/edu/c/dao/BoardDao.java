package woo.edu.c.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import woo.edu.c.vo.BoardVo;

@Mapper
public interface BoardDao {

	List<BoardVo> select();
	
	int register(BoardVo board);
	
	BoardVo select_one(Long bno);
	
	int update(BoardVo board);
	
	int delete(Long bno);
}
