package board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.dto.BoardDTO;
import board.dto.SearchDTO;
import board.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardMapper boardMapper;

	@Override
	public List<BoardDTO> selectBoardList(SearchDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.selectBoardList(dto);
	}

	@Override
	public BoardDTO getBoard(int no) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.selectBoard(no);
	}

	@Override
	public void deleteBoard(int no) throws Exception {
		boardMapper.deleteBoard(no);
	}

	@Override
	public void writeBoard(BoardDTO dto) {
		boardMapper.writeBoard(dto);
		
	}

	@Override
	public void updateBoard(BoardDTO dto) {
		boardMapper.updateBoard(dto);
		
	}

	@Override
	public int countBoard(SearchDTO param) {
		// TODO Auto-generated method stub
		return boardMapper.countBoard(param);
	}

	@Override
	public int passwordCheck(int no, String password) {
		return boardMapper.passwordCheck(no,password);
	}

	@Override
	public int hitboard(int no) {
		boardMapper.hitboard(no);
		return 0;
	}


	
}
