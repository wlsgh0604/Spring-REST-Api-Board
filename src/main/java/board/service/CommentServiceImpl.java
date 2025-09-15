package board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import board.dto.CommentDTO;
import board.mapper.CommentMapper;

@Service
public class CommentServiceImpl implements CommentService{

	@Autowired
	private CommentMapper commentMapper;
	
	 @Override
	 @Transactional
	 public void insertComment(CommentDTO comment) {
		 // case 1: 최상위 댓글
		 if (comment.getParent() == 0) {
			// 일단 저장
			commentMapper.insertComment(comment);
			// 방금 insert된 댓글의 no를 groupId로 업데이트
			int newId = comment.getNo(); // MyBatis에서 selectKey로 no 가져오게 해야 함
			commentMapper.updateGroupId(newId, newId);
			//case 2: 대댓글
		 }else{
			// 부모 댓글 정보 가져오기
			CommentDTO parent = commentMapper.selectCommentById(comment.getParent());
			// 대댓글은 부모의 groupId를 이어받음
			comment.setGroupId(parent.getGroupId());
            // order_no 는 부모 기준으로 +1 (혹은 동일 레벨 댓글들 중 맨 마지막)
			int nextOrderNo = commentMapper.getNextOrderNo(parent.getGroupId(), parent.getOrder_no());
			comment.setOrder_no(nextOrderNo);
			// 저장
			commentMapper.insertComment(comment);
		 }
	 }

	 @Override
	 public void deleteComment(int no) {
		 commentMapper.deleteComment(no);
	 }

	@Override
	public int replyPasswordCheck(int no, String password) {
		return commentMapper.replyPasswordCheck(no,password);
	}

	@Override
	public List<CommentDTO> selectCommentList(int no) {
		return commentMapper.selectCommentList(no);
	}


}
