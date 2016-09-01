package com.qian.shen.handler;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class NavigationHandler {

	@RequestMapping("/stockManager")
	public String stockManager(){
		return "stockManager";
	}
	
	@RequestMapping("/backlog")
	public String backlog(){
		return "backlog";
	}
	
	@RequestMapping("/inDos")
	public String inDos(){
		return "inDos";
	}
	
	@RequestMapping("/complete")
	public String complete(){
		return "complete";
	}
	
	@RequestMapping("/productCategory")
	public String productCategory(){
		return "productCategory";
	}
	
	@RequestMapping("/productInformation")
	public String productInformation(){
		return "productInformation";
	}
	
	@RequestMapping("/stockInquiry")
	public String stockInquiry(){
		return "stockInquiry";
	}
	
	@RequestMapping("/stockTransfer")
	public String stockTransfer(){
		return "stockTransfer";
	}
	
	@RequestMapping("/saleOrder")
	public String saleOrder(){
		return "saleOrder";
	}
	
	@RequestMapping("/saleReturn")
	public String saleReturn(){
		return "saleReturn";
	}
	
	@RequestMapping("/reportManager")
	public String reportManager(){
		return "reportManager";
	}
	
	@RequestMapping("/fingerClient")
	public String fingerClient(){
		return "fingerClient";
	}
	
	@RequestMapping("/userRole")
	public String userRole(){
		return "userRole";
	}
	
	@RequestMapping("/userPermissions")
	public String userPermissions(){
		return "userPermissions";
	}
	
}
