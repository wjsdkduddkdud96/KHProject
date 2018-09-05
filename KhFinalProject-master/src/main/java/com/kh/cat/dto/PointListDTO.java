package com.kh.cat.dto;

import java.sql.Date;

public class PointListDTO {
	private int pointList_idx;
	private String id;
	private long pointList_point;
	private String pointList_type;
	private String pointList_cate;
	private Date pointList_date;
	
	public Date getPointList_date() {
		return pointList_date;
	}
	public void setPointList_date(Date pointList_date) {
		this.pointList_date = pointList_date;
	}
	public int getPointList_idx() {
		return pointList_idx;
	}
	public void setPointList_idx(int pointList_idx) {
		this.pointList_idx = pointList_idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public long getPointList_point() {
		return pointList_point;
	}
	public void setPointList_point(long pointList_point) {
		this.pointList_point = pointList_point;
	}
	public String getPointList_type() {
		return pointList_type;
	}
	public void setPointList_type(String pointList_type) {
		this.pointList_type = pointList_type;
	}
	public String getPointList_cate() {
		return pointList_cate;
	}
	public void setPointList_cate(String pointList_cate) {
		this.pointList_cate = pointList_cate;
	}
	
	
}
