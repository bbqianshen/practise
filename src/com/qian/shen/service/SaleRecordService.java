package com.qian.shen.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qian.shen.entity.Inventory;
import com.qian.shen.entity.SaleRecord;
import com.qian.shen.repository.SaleRecordRepository;

@Service
public class SaleRecordService {

	@Autowired
	private SaleRecordRepository saleRecordRepository;
	
	@Autowired
	private InventoryService inventoryService;
	
	@Autowired
	private ProductService productService;
	
	@Transactional
	public Map<String,String> save(List<SaleRecord> saleRecords){
		
		Map<Integer,SaleRecord> map = new HashMap<>();
				
		for(SaleRecord saleRecord:saleRecords){
			
			Integer productId = saleRecord.getProductId();
			Integer mapSoldNumber = null;
			Float mapCountPrice = null;
			
			if(map.get(productId) == null){
				mapSoldNumber = 0;
				mapCountPrice = 0f;
			}else{
				mapSoldNumber = map.get(productId).getSoldNumber();
				mapCountPrice = map.get(productId).getCountPrice();
			}
			
			Integer sumSoldNumber = mapSoldNumber + saleRecord.getSoldNumber();
			Float sumCountPrice = mapCountPrice + saleRecord.getCountPrice();
			saleRecord.setSoldNumber(sumSoldNumber);
			saleRecord.setCountPrice(sumCountPrice);
			saleRecord.setCostPrice(productService.getProduct(saleRecord.getProductName()).getCostPrice());
			map.put(productId, saleRecord);
		}
		
		boolean flag = true;
		Map<String,String> errormsg = new HashMap<>();
		
		for (Map.Entry<Integer, SaleRecord> entry : map.entrySet()) {
			
			Inventory inventory = inventoryService.getInventory(entry.getKey());
			Integer stockNumber = inventory.getStockNumber();
			
			Integer soldNumber = entry.getValue().getSoldNumber();
			
			if(soldNumber > stockNumber){
				flag = false;
				errormsg.put(entry.getValue().getProductName()  + "商品库存不足!", 
						"现有库存:" + stockNumber + " 购买数量:" + soldNumber);
			}
		}
		
		
		if(flag){
			for (Map.Entry<Integer, SaleRecord> entry : map.entrySet()) {
				
				Inventory inventory = inventoryService.getInventory(entry.getKey());
				Integer stockNumber = inventory.getStockNumber();
				Integer soldNumber = entry.getValue().getSoldNumber();
				
				inventory.setStockNumber(stockNumber - soldNumber);
				inventoryService.save(inventory);
				
				//有问题
				saleRecordRepository.saveAndFlush(entry.getValue());
			}
		}
		
		return errormsg;
	}
	
	
	@Transactional(readOnly=true)
	public Page<SaleRecord> getPage(int pageNo,int pageSize){
		PageRequest pageable = new PageRequest(pageNo -1, pageSize);
		return saleRecordRepository.findAll(pageable);
	}
	
	
	@Transactional(readOnly=true)
	public List<SaleRecord> getAll(){
		return saleRecordRepository.findAll();
	}
	
	
}
