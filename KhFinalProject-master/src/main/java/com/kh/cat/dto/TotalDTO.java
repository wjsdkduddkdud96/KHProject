package com.kh.cat.dto;

import java.sql.Date;

public class TotalDTO {
	private int store_idx;
	private Date total_date;
	private int total_revCnt;
	private int total_bhitCnt;
	private double total_starAvg;
	
	
	public int getStore_idx() {
		return store_idx;
	}
	public void setStore_idx(int store_idx) {
		this.store_idx = store_idx;
	}
	public Date getTotal_date() {
		return total_date;
	}
	public void setTotal_date(Date total_date) {
		this.total_date = total_date;
	}
	public int getTotal_revCnt() {
		return total_revCnt;
	}
	public void setTotal_revCnt(int total_revCnt) {
		this.total_revCnt = total_revCnt;
	}
	public int getTotal_bhitCnt() {
		return total_bhitCnt;
	}
	public void setTotal_bhitCnt(int total_bhitCnt) {
		this.total_bhitCnt = total_bhitCnt;
	}
	public double getTotal_starAvg() {
		return total_starAvg;
	}
	public void setTotal_starAvg(double total_starAvg) {
		this.total_starAvg = total_starAvg;
	}
	
	
}
