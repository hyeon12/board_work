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
	
	// �Խñ� ���
	@Override
	public List<BoardVo> getList() {
		// TODO Auto-generated method stub
		
		List<BoardVo> items = boardDao.select();
		items.forEach(this::addInfo);
		
		return items;
	}

	// �Խñ� �󼼺���
	@Override
	public Optional<BoardVo> get(Long bno) {
		BoardVo board = boardDao.select_one(bno);
		
		addInfo(board);
		
		return Optional.ofNullable(board);
	}
	
	// �Խñ� �ۼ� �� ����
	@Override
	public boolean update(Long bno, String title, String writer, String content, String mode) {
		// TODO Auto-generated method stub
		BoardVo board = new BoardVo();
		board.setBno(bno);
		board.setTitle(title);
		board.setContent(content);
		board.setWriter(writer);
		
		if ("edit".equals(mode)) { // ����
			board.setUpdateDate(LocalDateTime.now());
			return boardDao.update(board) > 0;
		} else { // �߰� 
			return boardDao.register(board) > 0;
		}
		
	}

	// �Խñ� ����
	@Override
	public boolean delete(Long bno) {
		// TODO Auto-generated method stub
		return boardDao.delete(bno) > 0;
	}
	
	// �߰� ���� ó�� 
	private void addInfo(BoardVo item) {
		if (item == null) {
			return;
		}
		
		
		if (item.getRegDate() != null) {
			
			DateTimeFormatter formatter = DateTimeFormatter.ISO_DATE_TIME;
			item.setRegDateStr(formatter.format(item.getRegDate()));
			
        LocalDateTime regDate = item.getRegDate();
        Date date = Date.from(regDate.atZone(ZoneId.systemDefault()).toInstant());
        item.setFormattedRegDate(date); // ��ȯ�� Date�� Board ��ü�� ����
		}
	}
}
