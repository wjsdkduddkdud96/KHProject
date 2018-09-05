package com.kh.cat.dto;

import java.sql.Date;

public class RevLikeDTO {
	private int revLike_idx;
	private int review_idx;
	private String id;
	private Date revLike_date;
	
	public int getRevLike_idx() {
		return revLike_idx;
	}
	public void setRevLike_idx(int revLike_idx) {
		this.revLike_idx = revLike_idx;
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
	public Date getRevLike_date() {
		return revLike_date;
	}
	public void setRevLike_date(Date revLike_date) {
		this.revLike_date = revLike_date;
	}
	
	
	
}
