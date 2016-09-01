package com.qian.shen.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.qian.shen.entity.Inventory;

public interface InventoryRepository extends JpaRepository<Inventory, Integer>,JpaSpecificationExecutor<Inventory>{
	@Modifying
	@Query(value="UPDATE store_inventory SET stock_number = stock_number + ?1 WHERE product_id = ?2", nativeQuery=true)
	void updateStockNumber(Integer id,Integer id2);
	
	
	@Query("SELECT i.stockNumber From Inventory i WHERE i.product.id = ?1")
	Integer getStockNumber(Integer productId);
	
	@Query("SELECT i FROM Inventory i WHERE i.product.id = ?1")
	Inventory getInventory(Integer productId);
	
}
