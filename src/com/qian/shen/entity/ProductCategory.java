package com.qian.shen.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "PRODUCT_CATEGORY")
@Entity
public class ProductCategory {

	private Integer id;
	private String text;
	private String parent;

	@GeneratedValue
	@Id
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getParent() {
		return parent;
	}

	public void setParent(String parent) {
		this.parent = parent;
	}

	
	public ProductCategory() {
		super();
	}

	public ProductCategory(Integer id, String text, String parent) {
		super();
		this.id = id;
		this.text = text;
		this.parent = parent;
	}
	
	
	
}
