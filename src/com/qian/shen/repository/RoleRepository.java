package com.qian.shen.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.qian.shen.entity.Permission;
import com.qian.shen.entity.Role;

public interface RoleRepository extends JpaRepository<Role, Integer> {

	Role getByRoleId(Integer roleId);
	
	@Query("SELECT r.permissions FROM Role r WHERE r.roleId = ?1")
	List<Permission> getPermissionsByRoleId(Integer roleId);
	
}
