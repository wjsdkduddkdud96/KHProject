package com.kh.cat.dto;

import java.sql.Date;

public class StoreLikeDTO {
	private int storeLike_idx;
	private int store_idx;
	private String id;
	private Date storeLike_date;
	
	public int getStoreLike_idx() {
		return storeLike_idx;
	}
	public void setStoreLike_idx(int storeLike_idx) {
		this.storeLike_idx = storeLike_idx;
	}
	public int getStore_idx() {
		return store_idx;
	}
	public void setStore_idx(int store_idx) {
		this.store_idx = store_idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getStoreLike_date() {
		return storeLike_date;
	}
	public void setStoreLike_date(Date storeLike_date) {
		this.storeLike_date = storeLike_date;
	}
	
	
}
