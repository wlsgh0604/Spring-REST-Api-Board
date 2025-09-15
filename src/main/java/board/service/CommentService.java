package board.service;

import java.util.List;

import board.dto.CommentDTO;

public interface CommentService {
	void insertComment(CommentDTO dto);
	void deleteComment(int no);
	int replyPasswordCheck(int no, String password);
	List<CommentDTO> selectCommentList(int no);
}
