package com.kh.cat.dto;

import java.sql.Date;

public class DMDTO {
	private int dm_idx;
	private String id;
	private String dm_id;
	private String dm_content;
	private Date dm_date;
	
	public int getDm_idx() {
		return dm_idx;
	}
	public void setDm_idx(int dm_idx) {
		this.dm_idx = dm_idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDm_id() {
		return dm_id;
	}
	public void setDm_id(String dm_id) {
		this.dm_id = dm_id;
	}
	public String getDm_content() {
		return dm_content;
	}
	public void setDm_content(String dm_content) {
		this.dm_content = dm_content;
	}
	public Date getDm_date() {
		return dm_date;
	}
	public void setDm_date(Date dm_date) {
		this.dm_date = dm_date;
	}
	
	
}
