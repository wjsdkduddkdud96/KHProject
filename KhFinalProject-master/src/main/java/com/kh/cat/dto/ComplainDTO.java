package com.kh.cat.dto;

import java.sql.Date;

public class ComplainDTO {
	private int complain_idx;
	private String id;
	private String complain_id;
	private String complain_type;
	private String complain_content;
	private String complain_cate;
	private Date complain_date;
	private int complain_black;
	private int review_idx;
	private int revReply_idx;
	
	public int getComplain_idx() {
		return complain_idx;
	}
	public void setComplain_idx(int complain_idx) {
		this.complain_idx = complain_idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getComplain_id() {
		return complain_id;
	}
	public void setComplain_id(String complain_id) {
		this.complain_id = complain_id;
	}
	public String getComplain_type() {
		return complain_type;
	}
	public void setComplain_type(String complain_type) {
		this.complain_type = complain_type;
	}
	public String getComplain_content() {
		return complain_content;
	}
	public void setComplain_content(String complain_content) {
		this.complain_content = complain_content;
	}
	public String getComplain_cate() {
		return complain_cate;
	}
	public void setComplain_cate(String complain_cate) {
		this.complain_cate = complain_cate;
	}
	public Date getComplain_date() {
		return complain_date;
	}
	public void setComplain_date(Date complain_date) {
		this.complain_date = complain_date;
	}
	public int getComplain_black() {
		return complain_black;
	}
	public void setComplain_black(int complain_black) {
		this.complain_black = complain_black;
	}
	public int getReview_idx() {
		return review_idx;
	}
	public void setReview_idx(int review_idx) {
		this.review_idx = review_idx;
	}
	public int getRevReply_idx() {
		return revReply_idx;
	}
	public void setRevReply_idx(int revReply_idx) {
		this.revReply_idx = revReply_idx;
	}
	
	
	
}
