package board.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import board.dto.BoardDTO;
import board.dto.CommentDTO;
import board.dto.SearchDTO;
import board.service.BoardService;
import board.service.CommentService;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private CommentService commentService;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView board_front(@ModelAttribute("params") final  SearchDTO param) throws Exception {
	    ModelAndView mv = new ModelAndView("/mainBoard");

	    // 전체 게시글 수 (mapper에서 만든 countBoard 호출)
	    int totalCount = boardService.countBoard(param);

	    // 게시글 목록
	    List<BoardDTO> list = boardService.selectBoardList(param);

	    // 페이지당 글 수
	    int recordSize = param.getRecordSize(); 

	    // 블록당 페이지 수 (ex. 10개씩 보여주기)
	    int pageSize = param.getPageSize(); 

	    // 전체 페이지 수
	    int totalPage = (int) Math.ceil((double) totalCount / recordSize);

	    // 현재 페이지
	    int currentPage = param.getPage();

	    // 현재 블록 번호
	    int currentBlock = (int) Math.ceil((double) currentPage / pageSize);

	    // 블록 시작 페이지
	    int startPage = (currentBlock - 1) * pageSize + 1;

	    // 블록 끝 페이지
	    int endPage = startPage + pageSize - 1;

	    // endPage 보정 (전체 페이지보다 클 수 없음)
	    if (endPage > totalPage) {
	        endPage = totalPage;
	    }
	    
	    // 페이징 객체 생성
	    Pagination pagination = new Pagination(totalCount, param);
	    param.setPagination(pagination);

	    // JSP로 전달
	    mv.addObject("list", list);
	    mv.addObject("pagination", pagination);
	    mv.addObject("totalCount", totalCount);
	    mv.addObject("currentPage", currentPage);
	    mv.addObject("startPage", startPage);
	    mv.addObject("endPage", endPage);
	    mv.addObject("totalPage", totalPage);
	    mv.addObject("params", param);

	    return mv;
	}
	
	@RequestMapping(value="/write", method=RequestMethod.GET)
	public String write() {
		
		return "/writeBoard";
	}
	@RequestMapping(value="/writeBoard", method=RequestMethod.POST)
	public String writeBoard(BoardDTO dto) {
		Map<String, Object> result = new HashMap<>();
		System.out.println("insert dto = "+dto.toString());
		boardService.writeBoard(dto);

        result.put("status", "success");
        result.put("no", dto.getNo());
	
		return "redirect:/read?no=" + dto.getNo();
	}

	@RequestMapping(value="/read", method=RequestMethod.GET)
	public ModelAndView read(@RequestParam("no") int no) throws Exception {

		ModelAndView mv = new ModelAndView("/readBoard");
		BoardDTO board = boardService.getBoard(no);
		boardService.hitboard(no);
		System.out.println("board read = "+board.toString());
		mv.addObject("board",board);
		
		List<CommentDTO> commentList = commentService.selectCommentList(no);
		
		mv.addObject("commentList",commentList);
		
		return mv;
	}
	
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public ModelAndView update(int no) throws Exception{
		
		ModelAndView mv = new ModelAndView("/updateBoard");
		BoardDTO board = boardService.getBoard(no);
		System.out.println("board read = "+board.toString());
		mv.addObject("board",board);
		
		return mv;
	}

	@RequestMapping(value="/updateBoard", method=RequestMethod.POST)
	public String updateBoard(BoardDTO dto,
            RedirectAttributes rttr) throws Exception{
		Map<String, Object> result = new HashMap<>();
		System.out.println("insert dto = "+dto.toString());

		if(boardService.passwordCheck(dto.getNo(),dto.getPassword()) != 1) {
		    rttr.addFlashAttribute("msg", "비밀번호가 틀렸습니다.");
		    return "redirect:/read?no=" + dto.getNo();
		}
		boardService.updateBoard(dto);

        result.put("status", "success");
        result.put("no", dto.getNo());
	
		return "redirect:/read?no=" + dto.getNo();
	}
	
	
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delete(@RequestParam("no") int no,
	                     @RequestParam(value="password", required=false) String password,
	                     RedirectAttributes rttr/*,
	                     HttpSession session*/) throws Exception {
		if(boardService.passwordCheck(no,password) != 1) {
		    rttr.addFlashAttribute("msg", "비밀번호가 틀렸습니다.");
		    return "redirect:/read?no=" + no;
		}
	    //String loginUser = (String) session.getAttribute("loginUser");
		/*
		 * if (loginUser != null) { if (!loginUser.equals(board.getRegist_id())) {
		 * rttr.addFlashAttribute("msg", "삭제 할 수 없습니다."); return "redirect:/read?no=" +
		 * no; } } else { if (password == null || !password.equals(board.getPassword()))
		 * { rttr.addFlashAttribute("msg", "삭제 할 수 없습니다."); return "redirect:/read?no="
		 * + no; } }
		 */

	    boardService.deleteBoard(no);
	    rttr.addFlashAttribute("msg", "게시글이 삭제되었습니다.");
	    return "redirect:/";
	}
	@RequestMapping(value="/reply", method=RequestMethod.POST)
	public String reply(CommentDTO comment) {
		System.out.println("insert dto = "+comment.toString());
		commentService.insertComment(comment);

	
		return "redirect:/read?no=" + comment.getBoard_no();
	}
	
	@RequestMapping(value="/replyDelete", method=RequestMethod.POST)
	public String replydelete(@RequestParam("no") int no,
	                     @RequestParam(value="password", required=false) String password,
	                     @RequestParam("board_no") int board_no,
	                     RedirectAttributes rttr/*,
	                     HttpSession session*/) throws Exception {
		if(commentService.replyPasswordCheck(no,password) != 1) {
		    rttr.addFlashAttribute("msg", "비밀번호가 틀렸습니다.");
		    return "redirect:/read?no=" + board_no;
		}
	    //String loginUser = (String) session.getAttribute("loginUser");
		/*
		 * if (loginUser != null) { if (!loginUser.equals(board.getRegist_id())) {
		 * rttr.addFlashAttribute("msg", "삭제 할 수 없습니다."); return "redirect:/read?no=" +
		 * no; } } else { if (password == null || !password.equals(board.getPassword()))
		 * { rttr.addFlashAttribute("msg", "삭제 할 수 없습니다."); return "redirect:/read?no="
		 * + no; } }
		 */

		commentService.deleteComment(no);
	    rttr.addFlashAttribute("msg", "댓글이 삭제되었습니다.");
	    return "redirect:/read?no=" + board_no;
	}
}
