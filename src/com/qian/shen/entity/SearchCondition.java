package com.qian.shen.entity;

import java.util.Date;

public class SearchCondition {

	private String title;
	private String userName;
	private Date startDate;
	private Date endDate;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public SearchCondition(String title, String userName, Date startDate,
			Date endDate) {
		super();
		this.title = title;
		this.userName = userName;
		this.startDate = startDate;
		this.endDate = endDate;
	}

	public SearchCondition() {
		super();
	}

}
