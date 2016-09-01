package com.qian.shen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qian.shen.entity.Permission;
import com.qian.shen.entity.Role;
import com.qian.shen.repository.RoleRepository;

@Service
public class RoleService {

	@Autowired
	private RoleRepository roleRepository;
	
	@Transactional(readOnly=true)
	public List<Role> getAll(){
		return roleRepository.findAll();
	}
	
	@Transactional(readOnly=true)
	public List<Permission> getPermissionByRoleId(Integer roleId){
		return roleRepository.getPermissionsByRoleId(roleId);
	}
	
	@Transactional(readOnly=true)
	public Role getByRoleId(Integer roleId){
		return roleRepository.getByRoleId(roleId);
	}
	
	@Transactional
	public void save(Role role){
		roleRepository.saveAndFlush(role);
	}
}
