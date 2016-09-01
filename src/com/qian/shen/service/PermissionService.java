package com.qian.shen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qian.shen.entity.Permission;
import com.qian.shen.repository.PermissionRepository;

@Service
public class PermissionService {

	@Autowired
	private PermissionRepository permissionRepository;

	@Transactional
	public List<Permission> getAll() {
		return permissionRepository.findAll();
	}
	
	@Transactional
	public Permission getById(Integer id) {
		return permissionRepository.getById(id);
	}
}
