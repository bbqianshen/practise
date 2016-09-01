package com.qian.shen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qian.shen.entity.Product;
import com.qian.shen.repository.ProductRepository;

@Service
public class ProductService {

	@Autowired
	private ProductRepository productRepository;
	
	@Transactional
	public List<Product> getAll(){
		return productRepository.getAll();
	}
	
	@Transactional
	public Product getProduct(String productName){
		return productRepository.getByProductName(productName);
	}
	
	@Transactional
	public Product getProductById(Integer id){
		return productRepository.getById(id);
	}
	
	@Transactional
	public void save(Product product){
		productRepository.saveAndFlush(product);
	}
	
	
	@Transactional
	public Integer getSalePrice(Integer productId){
		return productRepository.getSalePrice(productId);
	}
	
}
