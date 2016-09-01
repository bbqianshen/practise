package com.qian.shen.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Table(name = "STORE_INVENTORY")
@Entity
public class Inventory {

	private Integer id;
	private Product product;
	private int stockNumber;

	@GeneratedValue
	@Id
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@JoinColumn(name = "PRODUCT_ID")
	@OneToOne
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public int getStockNumber() {
		return stockNumber;
	}

	public void setStockNumber(int stockNumber) {
		this.stockNumber = stockNumber;
	}

	@Override
	public String toString() {
		return "Inventory [id=" + id + ", product=" + product
				+ ", stockNumber=" + stockNumber + "]";
	}

	public Inventory(Integer id, Product product, int stockNumber) {
		super();
		this.id = id;
		this.product = product;
		this.stockNumber = stockNumber;
	}

	public Inventory() {
		super();
	}

}
