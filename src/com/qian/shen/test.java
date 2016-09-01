package com.qian.shen;

import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.qian.shen.entity.Inventory;
import com.qian.shen.entity.Product;
import com.qian.shen.entity.User;
import com.qian.shen.repository.InventoryRepository;
import com.qian.shen.repository.ProductRepository;
import com.qian.shen.repository.UserRepository;
import com.qian.shen.service.UserService;

public class test {

	private ApplicationContext ctx = null;
	private InventoryRepository inventoryRepository;
	private ProductRepository productRepository;
	private UserRepository userRepository;
	private UserService userService;
	
	{
		ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		inventoryRepository = ctx.getBean(InventoryRepository.class);
		productRepository = ctx.getBean(ProductRepository.class);
		userRepository = ctx.getBean(UserRepository.class);
		userService = ctx.getBean(UserService.class);
	}
	
	@Test
	public void testUser(){
		User user = userService.getByUserId(19);
		System.out.println(user.getUserName());
		System.out.println(user.getPassword());
	}
	
	@Test
	public void testInventory(){
		Product product = new Product();
		product.setProductName("iphone6S");
		product.setCostPrice(7000);
		product.setSalePrice(8000);
		Inventory inventory = new Inventory();
		inventory.setProduct(product);
		inventory.setStockNumber(10);
		productRepository.save(product);
		inventoryRepository.save(inventory);
	}
	
	
	@Test
	public void testDataSource() throws SQLException {
		DataSource dataSource = ctx.getBean(DataSource.class);
		System.out.println(dataSource.getConnection());
	}

}
