package com.qian.shen.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.qian.shen.entity.Permission;

public interface PermissionRepository extends
		JpaRepository<Permission, Integer> {

	Permission getById(Integer id);
}
