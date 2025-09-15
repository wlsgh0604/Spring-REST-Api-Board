package board.dto;

import java.util.Date;

public class CommentDTO {

	private int no;
	private int board_no;
	private String contents;
	private int parent;
	private int groupId;
	private int order_no;
	private String nickname;
	private String password;
	private Date reg_date;
	private int hidden;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getParent() {
		return parent;
	}
	public void setParent(int parent) {
		this.parent = parent;
	}
	public int getGroupId() {
		return groupId;
	}
	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}
	public int getOrder_no() {
		return order_no;
	}
	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public int gethidden() {
		return hidden;
	}
	public void sethiddene(int hidden) {
		this.hidden = hidden;
	}
	@Override
	public String toString() {
		return "CommentDTO [no=" + no + ", board_no=" + board_no + ", contents=" + contents + ", parent=" + parent
				+ ", groupId=" + groupId + ", order_no=" + order_no + ", nickname=" + nickname + ", password="
				+ password + ", reg_date=" + reg_date + ", hidden=" + hidden + "]";
	}
}
