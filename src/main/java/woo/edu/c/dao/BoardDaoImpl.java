package woo.edu.c.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import mappers.BoardMapper;
import woo.edu.c.controller.HomeController;
import woo.edu.c.vo.testVo;

@Repository
public class BoardDaoImpl implements BoardDao {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	// mybatis
	//@Inject
	//private BoardMapper mapper;
	
	//private static String namespace = "boardMapper";

	//@Override
	//public List<testVo> test() {
	//	return sql.selectList(namespace + ".test");
	//}
	
}
