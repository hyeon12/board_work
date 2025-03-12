package woo.edu.c.service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import woo.edu.c.dao.BoardDao;
import woo.edu.c.vo.BoardVo;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	// 게시글 목록
	@Override
	public List<BoardVo> getList() {
		// TODO Auto-generated method stub
		
		List<BoardVo> items = boardDao.select();
		items.forEach(this::addInfo);
		
		return items;
	}

	// 게시글 상세보기
	@Override
	public Optional<BoardVo> get(Long bno) {
		BoardVo board = boardDao.select_one(bno);
		
		addInfo(board);
		
		return Optional.ofNullable(board);
	}
	
	// 게시글 작성 및 수정
	@Override
	public boolean update(Long bno, String title, String writer, String content, String mode) {
		// TODO Auto-generated method stub
		BoardVo board = new BoardVo();
		board.setBno(bno);
		board.setTitle(title);
		board.setContent(content);
		board.setWriter(writer);
		
		if ("edit".equals(mode)) { // 수정
			board.setUpdateDate(LocalDateTime.now());
			return boardDao.update(board) > 0;
		} else { // 추가 
			return boardDao.register(board) > 0;
		}
		
	}

	// 게시글 삭제
	@Override
	public boolean delete(Long bno) {
		// TODO Auto-generated method stub
		return boardDao.delete(bno) > 0;
	}
	
	// 추가 정보 처리 
	private void addInfo(BoardVo item) {
		if (item == null) {
			return;
		}
		
		
		if (item.getRegDate() != null) {
			
			DateTimeFormatter formatter = DateTimeFormatter.ISO_DATE_TIME;
			item.setRegDateStr(formatter.format(item.getRegDate()));
			
        LocalDateTime regDate = item.getRegDate();
        Date date = Date.from(regDate.atZone(ZoneId.systemDefault()).toInstant());
        item.setFormattedRegDate(date); // 변환된 Date를 Board 객체에 설정
		}
	}
}
