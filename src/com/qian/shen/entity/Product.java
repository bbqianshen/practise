package com.qian.shen.entity;

import javax.persistence.Cacheable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Cacheable
@Table(name = "STORE_PRODUCT")
@Entity
public class Product {

	private Integer id;
	private String productName;

	private float costPrice;
	private float salePrice;

	@GeneratedValue
	@Id
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public float getCostPrice() {
		return costPrice;
	}

	public void setCostPrice(float costPrice) {
		this.costPrice = costPrice;
	}

	public float getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(float salePrice) {
		this.salePrice = salePrice;
	}

	@Override
	public String toString() {
		return "Product [id=" + id + ", productName=" + productName
				+ ", costPrice=" + costPrice + ", salePrice=" + salePrice + "]";
	}

	public Product(Integer id, String productName, float costPrice,
			float salePrice) {
		super();
		this.id = id;
		this.productName = productName;
		this.costPrice = costPrice;
		this.salePrice = salePrice;
	}

	public Product() {
		super();
	}

}
