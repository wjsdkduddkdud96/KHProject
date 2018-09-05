package com.kh.cat.dto;

import java.sql.Date;

public class BoardReplyDTO {
	private int boardReply_idx;
	private int board_idx;
	private String id;
	private String boardReply_content;
	private Date boardReply_date;
	
	public int getBoardReply_idx() {
		return boardReply_idx;
	}
	public void setBoardReply_idx(int boardReply_idx) {
		this.boardReply_idx = boardReply_idx;
	}
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
	public String getBoardReply_content() {
		return boardReply_content;
	}
	public void setBoardReply_content(String boardReply_content) {
		this.boardReply_content = boardReply_content;
	}
	public Date getBoardReply_date() {
		return boardReply_date;
	}
	public void setBoardReply_date(Date boardReply_date) {
		this.boardReply_date = boardReply_date;
	}
	
	
	
}
