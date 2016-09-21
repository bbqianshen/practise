package com.qian.shen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qian.shen.entity.ProductCategory;
import com.qian.shen.repository.ProductCategoryRepository;

@Service
public class ProductManagementService {

	@Autowired
	private ProductCategoryRepository productCategoryRepository;
	
	@Transactional(readOnly=true)
	public List<ProductCategory> getByParentId(String parentId){
		return productCategoryRepository.getByParent(parentId);
	}
	
	@Transactional(readOnly=true)
	public Integer getMaxId(){
		return productCategoryRepository.getMaxId();
	}
	
	
	@Transactional(readOnly=true)
	public List<ProductCategory> getAll(){
		return productCategoryRepository.findAll();
	}
	
	@Transactional
	public void deleteTreeNodeWithChildNode(Integer nodeId){
		if(productCategoryRepository.getByParent(nodeId.toString()).size() == 0){
			productCategoryRepository.deleteTreeNode(nodeId.toString());
		}else{
			for(ProductCategory productCategory : productCategoryRepository.getByParent(nodeId.toString())){
				deleteTreeNodeWithChildNode(productCategory.getId());
			}
			productCategoryRepository.deleteTreeNode(nodeId.toString());
		}
	}
	
	@Transactional
	public void saveTreeNode(ProductCategory productCategory){
		productCategoryRepository.saveAndFlush(productCategory);
	}
}
