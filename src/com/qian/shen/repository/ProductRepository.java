package com.qian.shen.repository;

import java.util.List;

import javax.persistence.QueryHint;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.QueryHints;

import com.qian.shen.entity.Product;

public interface ProductRepository extends JpaRepository<Product, Integer> {

	@QueryHints({@QueryHint(name=org.hibernate.ejb.QueryHints.HINT_CACHEABLE,value="true")})
	@Query("SELECT p FROM Product p")
	List<Product> getAll();
	
	Product getByProductName(String productName);
	
	Product getById(Integer Id);
	
	@Query("SELECT p.salePrice FROM Product p WHERE p.id = ?1")
	Integer getSalePrice(Integer productId);
}
