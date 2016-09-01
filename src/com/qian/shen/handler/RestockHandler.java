package com.qian.shen.handler;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qian.shen.entity.Inventory;
import com.qian.shen.entity.Product;
import com.qian.shen.entity.SaleRecord;
import com.qian.shen.service.InventoryService;
import com.qian.shen.service.ProductService;
import com.qian.shen.service.SaleRecordService;

@Controller
public class RestockHandler {
	
	@Autowired
	private InventoryService inventoryService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private SaleRecordService saleRecordService;
	
	
	@RequestMapping("/analyze")
	public String viewRecord(@RequestParam(value="pageNo", required=false, defaultValue = "1") String pageNoStr,
			Map<String,Object> map){
		int pageNo = 1;
		try {
			pageNo = Integer.parseInt(pageNoStr);
			if(pageNo < 1){
				pageNo = 1;
			}
		} catch (NumberFormatException e) {}
		
		Page<SaleRecord> page = saleRecordService.getPage(pageNo, 5);
		map.put("page", page);
		
		Double totalProfit = 0.00;
		List<SaleRecord> saleRecords = saleRecordService.getAll();
		for(SaleRecord saleRecord:saleRecords){
			totalProfit += saleRecord.getSoldNumber()*(saleRecord.getSoldPrice() - saleRecord.getCostPrice());
		}
		map.put("totalProfit", totalProfit);
		
		return "analytical";
	}
	
	@RequestMapping(value="/sale",method=RequestMethod.POST)
	public String sale(
			@RequestParam(value="product.id",required=false) Integer[] productId,
			@RequestParam(value="itemNumber",required=false) Integer[] itemNumber,
			@RequestParam(value="salePrice",required=false) Float[] salePrice,
			@RequestParam(value="countPrice") Float[] countPrice,
			Map<String,Object> map
			){
		List<SaleRecord> saleRecords = new ArrayList<>();
		for(int i = 0 ; i < itemNumber.length ; i ++){
			SaleRecord saleRecord = new SaleRecord();
			saleRecord.setProductId(productId[i]);
			saleRecord.setProductName(productService.getProductById(productId[i]).getProductName());
			saleRecord.setSoldNumber(itemNumber[i]);
			saleRecord.setSoldPrice(salePrice[i]);
			saleRecord.setCountPrice(countPrice[i]);
			saleRecord.setBuyTime(new Date());
			saleRecords.add(saleRecord);
		}
		//返回错误信息
		Map<String,String> errormsg = saleRecordService.save(saleRecords);
		
		if(errormsg.size() == 0){
			return "success";
		}else{
			map.put("errormsg", errormsg);
			return "error";
		}
		
	}
	
	
	@ResponseBody
	@RequestMapping(value="/ajaxGetStockNumber",method=RequestMethod.POST)
	public Map<String,Integer> getStockNumber(@RequestParam(value="productId",required=true) Integer productId){
		Integer stockNumber = inventoryService.getStockNumber(productId);
		Integer salePrice = productService.getSalePrice(productId);
		Map<String,Integer> number = new HashMap<String, Integer>();
		number.put("stockNumber", stockNumber);
		number.put("salePrice", salePrice);
		return number;
	}
	
	
	@RequestMapping(value="/sale",method=RequestMethod.GET)
	public String showcashierPage(Map<String,Object> map){
		map.put("products", productService.getAll());
		return "sale";
	}
	
	
	@RequestMapping(value="/stock",method=RequestMethod.POST)
	public String save(	String[] productName,
						Integer[] stockNumber,
						Float[] costPrice,
						Float[] salePrice){
		for(int i = 0; i < productName.length; i++){
			//如果存在商品记录，则直接更新库存即可
			if(productService.getProduct(productName[i]) != null){
				Integer id = productService.getProduct(productName[i]).getId();
				System.out.println("Exist product Id: " + id);
				inventoryService.update(stockNumber[i], id);
			}else{
				System.out.println(i);
				Product product = new Product();
				product.setProductName(productName[i]);
				product.setSalePrice(salePrice[i]);
				product.setCostPrice(costPrice[i]);
				productService.save(product);
				Inventory inventory = new Inventory();
				inventory.setProduct(product);
				inventory.setStockNumber(stockNumber[i]);
				inventoryService.save(inventory);
			}
		}
		
		return "success";
	}
	
	@RequestMapping(value="/enterSave",method=RequestMethod.GET)
	public String enterSave(){
		return "Restock";
	}
}
