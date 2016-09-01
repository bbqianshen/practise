package com.qian.shen.handler;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.qian.shen.entity.Permission;
import com.qian.shen.entity.Role;
import com.qian.shen.entity.SearchCondition;
import com.qian.shen.entity.User;
import com.qian.shen.service.DepartmentService;
import com.qian.shen.service.PermissionService;
import com.qian.shen.service.RoleService;
import com.qian.shen.service.UserService;

@Controller
public class UserHandler {

	@Autowired
	private UserService userService;

	@Autowired
	private DepartmentService departmentService;
	
	@Autowired
	private PermissionService permissionService;
	
	@Autowired
	private RoleService roleService;
	
	private User user;

	@RequestMapping("/search")
	public String searchUser(@RequestParam(value="path", required = false) String path,
							@RequestParam(value="userName", required = false) String userName,
							@RequestParam(value = "pageNo", required = false, defaultValue = "0") String pageNoStr,
							Map<String, Object> map){
		System.out.println("=========================");
		SearchCondition condition = new SearchCondition(null, userName, null, null);
		int pageNo = 0;
		try {
			pageNo = Integer.parseInt(pageNoStr);
			if (pageNo < 1) {
				pageNo = 0;
			}
		} catch (NumberFormatException e) {
		}
		
		if(pageNo < 0 ) pageNo = 0;
		System.out.println(pageNo);
		Pageable pageable = new PageRequest(pageNo,5);
		Page<User> page = userService.getPage(pageable, condition);
		
		map.put("condition", condition);
		map.put("page", page);
		return path;
	}
	
	@ModelAttribute
	public void getUser(@RequestParam(value="userId",required=false) Integer userId,
			Map<String, Object> map){
		if(userId != null){
			this.user = userService.getByUserId(userId);
			map.put("user", this.user);
			System.out.println("@ModelAttribute");
		}else{
			User user = new User();
			map.put("user", user);
		}
	}

	@RequestMapping(value="/userAddPage")
	public String userAdd(Map<String, Object> map) {
		map.put("department", departmentService.getAll());
		return "userAdd";
	}
	
	@RequestMapping(value={"/updateUserPermission","/updateRolePermission"})
	public String showPermission(@RequestParam(value="userId",required=false) Integer userId,
			@RequestParam(value="roleId",required=false) Integer roleId,
			Map<String, Object> map) {
		if(userId != null){
			List<Permission> permissions = userService.getPermissionByUserId(userId);
			map.put("setPermission", permissions);
			permissions = permissionService.getAll();
			map.put("permission", permissions);
			map.put("title", "用户权限设置");
			map.put("backPath", "search?path=userPermissions");
		}
		if(roleId != null){
			Role role = roleService.getByRoleId(roleId);
			map.put("role", role);
			List<Permission> permissions = roleService.getPermissionByRoleId(roleId);
			map.put("setPermission", permissions);
			permissions = permissionService.getAll();
			map.put("permission", permissions);
			map.put("title", "角色权限设置");
			map.put("backPath", "showRole");
		}
		return "permission";
	}
	
	@RequestMapping(value="/savePermission",method=RequestMethod.POST)
	public String updatePermission(@RequestParam(value="setPermissions",required=false) List<Integer> permissionIds,
			@RequestParam(value="userId",required=false) Integer userId,
			@RequestParam(value="roleId",required=false) Integer roleId,
			Map<String,Object> map){
		if(userId != null){
			User user = userService.getByUserId(userId);
			Set<Permission> userPermission = new HashSet<>();
			if(permissionIds != null){
				for(Integer permissionId:permissionIds){
					userPermission.add(permissionService.getById(permissionId));
				}
			}
			user.setUserPermissions(userPermission);
			userService.saveUser(user);
			return "redirect:/search?path=userPermissions";
		}
		if(roleId != null){
			Role role = roleService.getByRoleId(roleId);
			Set<Permission> rolePermission = new HashSet<>();
			if(permissionIds != null){
				for(Integer permissionId:permissionIds){
					rolePermission.add(permissionService.getById(permissionId));
				}
			}
			role.setPermissions(rolePermission);
			roleService.save(role);
			return "redirect:/showRole";
		}
		
		return null;
	}
	
	@RequestMapping(value="/showRole")
	public String showRoles(Map<String,Object> map){
		List<Role> roles = roleService.getAll();
		map.put("role", roles);
		return "userRole";
	}
	
	@RequestMapping("/updateUserRole")
	public String showUserRole(Map<String,Object> map){
		map.put("setRole",this.user.getRoles());
		map.put("role", roleService.getAll());
		return "assignRoles";
	}
	
	@RequestMapping(value="/saveRole",method=RequestMethod.POST)
	public String updateUserRole(@RequestParam(value="setRoles",required=false) List<Integer> roleIds){
		Set<Role> userRoles = new HashSet<>();
		if(roleIds != null){
			for(Integer roleId:roleIds){
				userRoles.add(roleService.getByRoleId(roleId));
			}
		}
		this.user.setRoles(userRoles);
		userService.saveUser(this.user);
		
		return "redirect:/search?path=userRoleManagement";
	}
	

	@ResponseBody
	@RequestMapping("/userValidate")
	public Boolean userValidate(
			@RequestParam(value = "userName", required = true) String userName) {
		User user = userService.getByUserName(userName);
		if (user == null) {
			return false;
		}
		return true;
	}

	@RequestMapping(value = "/userSave", method = RequestMethod.POST)
	public String userSave(User user) {
		try {
			userService.saveUser(user);
		} catch (Exception e) {
			return "error";
		}
		return "success";
	}
	
	@RequestMapping(value = "/userSave", method = RequestMethod.PUT)
	public String userUpdate(User user) {
		try {
			userService.saveUser(user);
		} catch (Exception e) {
			return "error";
		}
		return "success";
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(@RequestParam(value="userId",required=true) Integer userId){
		
		try {
			userService.deleteUser(userId);
		} catch (Exception e) {
			return "error";
		}
		return "success";
	}
	
	
//	@RequestMapping(value = "/update", method = RequestMethod.GET)
//	public String update(@RequestParam(value="userId",required=true) Integer userId){
//		
//		try {
//			User
//			userService.deleteUser(userId);
//		} catch (Exception e) {
//			return "error";
//		}
//		return "success";
//	}
	
	
	@RequestMapping(value="/viewUser",method = RequestMethod.POST)
	public @ResponseBody Map<String,Object> viewUser(
			@RequestParam(value = "userId", required = true) Integer userId) {
		User user = new User();
		user.setUserId(this.user.getUserId());
		user.setUserName(this.user.getUserName());
		user.setChineseName(this.user.getChineseName());
		user.setSex(this.user.getSex());
		user.setDept(this.user.getDept());
		user.setEmail(this.user.getEmail());
		user.setPhone(this.user.getPhone());
		user.setAddress(this.user.getAddress());
		user.setComments(this.user.getComments());
		
		Map<String,Object> map = new HashMap<String,Object>();
		Gson gson = new Gson(); //创建一个转换器
		String json = gson.toJson(user);//将任意对象转成Json
		System.out.println(json);
		map.put("viewUser", json);
		return map;
	}
	

}
