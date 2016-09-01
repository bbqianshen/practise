package com.qian.shen.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Table(name = "STORE_SALERECORD")
@Entity
public class SaleRecord {

	private Integer id;
	private Integer productId;
	private String productName;
	private float soldPrice;
	private float costPrice;

	private Integer soldNumber;
	private float countPrice;
	private Date buyTime;

	public float getCostPrice() {
		return costPrice;
	}

	public void setCostPrice(float costPrice) {
		this.costPrice = costPrice;
	}

	@GeneratedValue
	@Id
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public Integer getSoldNumber() {
		return soldNumber;
	}

	public void setSoldNumber(Integer soldNumber) {
		this.soldNumber = soldNumber;
	}

	public float getCountPrice() {
		return countPrice;
	}

	public void setCountPrice(float countPrice) {
		this.countPrice = countPrice;
	}

	@Temporal(TemporalType.TIMESTAMP)
	public Date getBuyTime() {
		return buyTime;
	}

	public void setBuyTime(Date buyTime) {
		this.buyTime = buyTime;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public float getSoldPrice() {
		return soldPrice;
	}

	public void setSoldPrice(float soldPrice) {
		this.soldPrice = soldPrice;
	}

	@Override
	public String toString() {
		return "SaleRecord [id=" + id + ", productId=" + productId
				+ ", productName=" + productName + ", soldPrice=" + soldPrice
				+ ", soldNumber=" + soldNumber + ", countPrice=" + countPrice
				+ ", buyTime=" + buyTime + "]";
	}

}
