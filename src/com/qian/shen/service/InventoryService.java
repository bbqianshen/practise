package com.qian.shen.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qian.shen.entity.Inventory;
import com.qian.shen.repository.InventoryRepository;

@Service
public class InventoryService {

	@Autowired
	private InventoryRepository inventoryRepository;
	
	@Transactional
	public void update(Integer id, Integer id2){
		inventoryRepository.updateStockNumber(id, id2);
	}
	
	@Transactional(readOnly=true)
	public Inventory getInventory(Integer productId){
		return inventoryRepository.getInventory(productId);
	}
	
	@Transactional
	public void save(Inventory inventory){
		inventoryRepository.saveAndFlush(inventory);
	}
	
	@Transactional(readOnly=true)
	public Integer getStockNumber(Integer productId){
		return inventoryRepository.getStockNumber(productId);
	}
	
}
