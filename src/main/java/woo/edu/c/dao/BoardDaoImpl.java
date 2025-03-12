package woo.edu.c.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import woo.edu.c.vo.BoardVo;

@Repository
public class BoardDaoImpl implements BoardDao {
	@Inject
	private SqlSession sql;
	
	private static String namespace = "mappers.BoardMapper";

	@Override
	public List<BoardVo> select() {
		// TODO Auto-generated method stub
		return sql.selectList(namespace + ".select");
	}

	@Override
	public int register(BoardVo board) {
		// TODO Auto-generated method stub
		return sql.insert(namespace + ".register", board);
	}

	@Override
	public BoardVo select_one(Long bno) {
		// TODO Auto-generated method stub
		return sql.selectOne(namespace + ".select_one", bno);
	}

	@Override
	public int update(BoardVo board) {
		// TODO Auto-generated method stub
        return sql.update(namespace + ".update", board);
	}

	@Override
	public int delete(Long bno) {
		// TODO Auto-generated method stub
        return sql.delete(namespace + ".delete", bno);
	}
	
}
