package com.qian.shen.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "CATEGORY")
@Entity
public class Category {

	private Integer id;
	private String categoryId;
	private String fatherCategoryId;
	private String categoryLevel;
	private String state;

	@GeneratedValue
	@Id
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(unique = true, name = "CATEGORY_ID")
	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public String getFatherCategoryId() {
		return fatherCategoryId;
	}

	public void setFatherCategoryId(String fatherCategoryId) {
		this.fatherCategoryId = fatherCategoryId;
	}

	public String getCategoryLevel() {
		return categoryLevel;
	}

	public void setCategoryLevel(String categoryLevel) {
		this.categoryLevel = categoryLevel;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Category(Integer id, String categoryId, String fatherCategoryId,
			String categoryLevel, String state) {
		super();
		this.id = id;
		this.categoryId = categoryId;
		this.fatherCategoryId = fatherCategoryId;
		this.categoryLevel = categoryLevel;
		this.state = state;
	}

	public Category() {
		super();
	}

}
