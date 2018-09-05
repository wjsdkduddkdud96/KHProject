package com.kh.cat.dto;

import java.sql.Date;

public class RevReplyDTO {
	private int revreply_idx;
	private int review_idx;
	private String id;
	private String revreply_content;
	private Date revreply_date;
	private String revreply_profile;
		
	public int getRevreply_idx() {
		return revreply_idx;
	}
	public void setRevreply_idx(int revreply_idx) {
		this.revreply_idx = revreply_idx;
	}
	public String getRevreply_content() {
		return revreply_content;
	}
	public void setRevreply_content(String revreply_content) {
		this.revreply_content = revreply_content;
	}
	public Date getRevreply_date() {
		return revreply_date;
	}
	public void setRevreply_date(Date revreply_date) {
		this.revreply_date = revreply_date;
	}
	public int getReview_idx() {
		return review_idx;
	}
	public void setReview_idx(int review_idx) {
		this.review_idx = review_idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRevreply_profile() {
		return revreply_profile;
	}
	public void setRevreply_profile(String revreply_profile) {
		this.revreply_profile = revreply_profile;
	}
	
	
	
}
