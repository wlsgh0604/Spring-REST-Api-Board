package board.service;

import java.util.List;

import board.dto.BoardDTO;
import board.dto.SearchDTO;

public interface BoardService {

	List<BoardDTO> selectBoardList(SearchDTO dto) throws Exception;

	BoardDTO getBoard(int no) throws Exception;

	void deleteBoard(int no) throws Exception;

	void writeBoard(BoardDTO dto);

	void updateBoard(BoardDTO dto);

	int countBoard(SearchDTO param);

	int passwordCheck(int no, String password);

	int hitboard(int no);
	
}
