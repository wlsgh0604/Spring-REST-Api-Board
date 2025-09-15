package board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import board.dto.BoardDTO;
import board.dto.SearchDTO;

@Mapper
public interface BoardMapper {
	List<BoardDTO> selectBoardList(SearchDTO dto) throws Exception;
	BoardDTO selectBoard(int no);
	void deleteBoard(int no);
	void writeBoard(BoardDTO dto);
	void updateBoard(BoardDTO dto);
	int countBoard(SearchDTO param);
	int hitboard(int no);
	int passwordCheck(@Param("no") int no, @Param("password") String password);
	
}
