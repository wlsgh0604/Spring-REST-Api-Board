package board.dto;

import java.util.Date;

public class BoardDTO {

	private int no;
	private String subject;
	private String password;
	private String contents;
	private int hit;
	private String nickname;
	private String source;
	private Date regist_time;
	private String regist_id;
	private Date update_time;
	private String update_id;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public Date getRegist_time() {
		return regist_time;
	}
	public void setRegist_time(Date regist_time) {
		this.regist_time = regist_time;
	}
	public String getRegist_id() {
		return regist_id;
	}
	public void setRegist_id(String regist_id) {
		this.regist_id = regist_id;
	}
	public Date getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	public String getUpdate_id() {
		return update_id;
	}
	public void setUpdate_id(String update_id) {
		this.update_id = update_id;
	}
	
	
	@Override
	public String toString() {
		return "BoardDTO [no=" + no + ", subject=" + subject + ", password=" + password + ", contents=" + contents
				+ ", hit=" + hit + ", nickname=" + nickname + ", source=" + source + ", regist_time=" + regist_time
				+ ", regist_id=" + regist_id + ", update_time=" + update_time + ", update_id=" + update_id + "]";
	}
	
	

	
}
