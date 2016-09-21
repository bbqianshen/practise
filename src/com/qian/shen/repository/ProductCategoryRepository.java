package com.qian.shen.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.qian.shen.entity.ProductCategory;

public interface ProductCategoryRepository extends JpaRepository<ProductCategory, Integer> {

	List<ProductCategory> getByParent(String parentId);
	
	@Modifying
	@Query(value="DELETE FROM product_category WHERE id = ?1 ", nativeQuery=true)
	void deleteTreeNode(String nodeId);
	
	@Query(value="SELECT Max(id) FROM product_category" ,nativeQuery=true)
	Integer getMaxId();
	
}
