package board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import board.dto.CommentDTO;

@Mapper
public interface CommentMapper {

	void insertComment(CommentDTO dto);

	void deleteComment(int no);

	int replyPasswordCheck(@Param("no") int no, @Param("password") String password);

	List<CommentDTO> selectCommentList(int no);

	void updateGroupId(@Param("no") int no, @Param("groupId") int groupId);

	CommentDTO selectCommentById(int parent);

	int getNextOrderNo(@Param("groupId")int groupId,@Param("order_no") int order_no);

}
