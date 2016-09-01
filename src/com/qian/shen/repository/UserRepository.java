package com.qian.shen.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.qian.shen.entity.Permission;
import com.qian.shen.entity.User;

public interface UserRepository extends JpaRepository<User, Integer>,
		PagingAndSortingRepository<User, Integer>,
		JpaSpecificationExecutor<User> {

	User getByUserId(Integer userId);
	
	User getByUserName(String username);
	
	@Query("SELECT u.userPermissions FROM User u WHERE u.userId = ?1")
	List<Permission> getPermissionByUserId(Integer userId);

	@Modifying
	@Query(value = "UPDATE users u SET u.last_log_time = ?1 WHERE user_name = ?2", nativeQuery = true)
	void updateUserLastLogTime(Date date, String username);
}
