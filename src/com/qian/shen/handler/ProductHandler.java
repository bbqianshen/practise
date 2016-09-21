package com.qian.shen.handler;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qian.shen.entity.ProductCategory;
import com.qian.shen.service.ProductManagementService;

@Controller
public class ProductHandler {

	@Autowired
	private ProductManagementService productManagementService;

	@RequestMapping(value="/getJsonTree", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getJsonTree() {
		String jsonString ="[";
		List<ProductCategory> treeList = productManagementService.getAll();
		for(ProductCategory productCategory : treeList){
			jsonString += "{ id: \"" + productCategory.getId() + "\", " +
						 "  parent: \"" + productCategory.getParent() + "\", " +
						 "  text: \"" + productCategory.getText() + "\", " + 
						 "  type: \"default\" },";
		}
		jsonString = jsonString.substring(0, jsonString.length() - 1) + "]";
		System.out.println(jsonString);
		return jsonString;
	}
	
	
	@RequestMapping(value="/deleteTreeNode", method= RequestMethod.POST)
	@ResponseBody
	public boolean deleteTreeNode(@RequestParam(value="id",required = true) Integer nodeId){
		boolean result = true;
		try {
			productManagementService.deleteTreeNodeWithChildNode(nodeId);
		} catch (Exception e) {
			result = false;
		}
		return result;
	}
	
	@RequestMapping(value="/createTreeNode", method= RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String createTreeNode(@RequestParam(value="parentNodeId", required=true) String parentNodeId,
			@RequestParam(value="text", required=true) String text){
		String jsonString = "";
		try {
			ProductCategory productCategory = new ProductCategory(null, text, parentNodeId);
			productManagementService.saveTreeNode(productCategory);
			jsonString = "{ id: \"" + productManagementService.getMaxId() + "\", " +
					"  parent: \"" + parentNodeId + "\", " +
					"  text: \"" + text + "\", " + 
					"  type: \"default\" }";
		} catch (Exception e) {
			jsonString = "false";
		}
		System.out.println(jsonString);
		return jsonString;
	}
	
	
	

//	private String getJson(Integer parentId) {
//		String str = null;
//		// 把顶层的查出来
//		List<ProductCategory> parentCategories = productManagementService.getByParentId(parentId);
//		for (int i = 0; i < parentCategories.size(); i++) {
//			ProductCategory pc = parentCategories.get(i);
//			// 有子节点
//			if (productManagementService.getByParentId(pc.getCategoryId()).size() != 0) {
//				str += "{attributes:{id:\"" + pc.getCategoryId()
//						+ "\"},state:\"open\",data:\"" + pc.getCategoryName() + "\" ,";
//				str += "children:[";
//				// 查出它的子节点
//				List<ProductCategory> list = productManagementService.getByParentId(pc.getCategoryId());
//				// 遍历它的子节点
//				for (int j = 0; j < list.size(); j++) {
//					ProductCategory childPC = list.get(j);
//					// 还有子节点(递归调用)
//					if (productManagementService.getByParentId(pc.getCategoryId()).size() != 0) {
//						this.getJson(childPC.getParentId());
//					} else {
//						str += "{attributes:{id:\"" + childPC.getCategoryId()
//								+ "\"},state:\"open\",data:\"" + childPC.getCategoryName()
//								+ "\" " + " }";
//						if (j < list.size() - 1) {
//							str += ",";
//						}
//					}
//				}
//				str += "]";
//				str += " }";
//				if (i < parentCategories.size() - 1) {
//					str += ",";
//				}
//			}
//		}
//		return str;
//	}
//
//	public String list() {
//		String str = "[";
//		// 从根开始
//		str += this.getJson(0);
//		str += "]";
//		return str;
//	}
}
