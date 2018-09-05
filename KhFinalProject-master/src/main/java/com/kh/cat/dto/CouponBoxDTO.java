package com.kh.cat.dto;

import java.sql.Date;

public class CouponBoxDTO {
	private int couponBox_code;
	private String id;
	private int couponBox_use;
	private Date couponBox_date;
	private String couponBox_name;
	private long couponBox_price;
	
	
	
	
	public long getCouponBox_price() {
		return couponBox_price;
	}
	public void setCouponBox_price(long couponBox_price) {
		this.couponBox_price = couponBox_price;
	}
	public String getCouponBox_name() {
		return couponBox_name;
	}
	public void setCouponBox_name(String couponBox_name) {
		this.couponBox_name = couponBox_name;
	}
	public Date getCouponBox_date() {
		return couponBox_date;
	}
	public void setCouponBox_date(Date couponBox_date) {
		this.couponBox_date = couponBox_date;
	}
	public int getCouponBox_use() {
		return couponBox_use;
	}
	public void setCouponBox_use(int couponBox_use) {
		this.couponBox_use = couponBox_use;
	}
	public int getCouponBox_code() {
		return couponBox_code;
	}
	public void setCouponBox_code(int couponBox_code) {
		this.couponBox_code = couponBox_code;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
}
