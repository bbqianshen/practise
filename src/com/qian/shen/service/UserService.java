package com.qian.shen.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qian.shen.entity.Permission;
import com.qian.shen.entity.SearchCondition;
import com.qian.shen.entity.User;
import com.qian.shen.repository.UserRepository;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;
	
	@Transactional(readOnly=true)
	public User getByUserName(String username){
		return userRepository.getByUserName(username);
	}
	
	@Transactional(readOnly=true)
	public User getByUserId(Integer userId){
		return userRepository.getByUserId(userId);
	}
	
	@Transactional(readOnly=true)
	public Page<User> getPage(int pageNo,int pageSize){
		PageRequest pageable = new PageRequest(pageNo -1, pageSize);
		return userRepository.findAll(pageable);
	}
	
	@Transactional(readOnly=true)
	public Page<User> getPage(Pageable pageable,final SearchCondition condition){
		
		//通常使用Specification 的匿名内部类
		Specification<User> specification = new Specification<User>() {
			
			@Override
			public Predicate toPredicate(Root<User> root,  
				     CriteriaQuery<?> query, CriteriaBuilder cb) {
				List<Predicate> list = new ArrayList<>();
				if(condition.getUserName() != null){
					list.add(cb.like(root.get("userName").as(String.class), "%" + condition.getUserName() + "%"));
				}
				Predicate[] predicates = new Predicate[list.size()];
				predicates = list.toArray(predicates);
				return cb.and(predicates);
				
				//root = query.from(User.class); 
//				Path<String> path = root.get("userName");
//				Predicate predicate = cb.like(path, "%" + userName + "%");
//				return predicate;
				
//				root = query.from(User.class);  
//                Path<String> nameExp = root.get("userName");  
//                return cb.like(nameExp, "%" + userName + "%"); 

//				Path<String> namePath = root.get("userName");  
//			    query.where(cb.like(namePath, "%qian%"));
//			    return null;
				
//				Predicate p1 = cb.like(root.get("userName").as(String.class), "%"+ condition.getUserName() +"%");  
//			    query.where(p1);  
//			    return query.getRestriction();
			}
		};
		return userRepository.findAll(specification,pageable);
	}
	
	@Transactional
	public void updateUserLastLogTime(String username, Date date){
		userRepository.updateUserLastLogTime(date, username);
	}
	
	@Transactional
	public void saveUser(User user){
		userRepository.saveAndFlush(user);
	}
	
	@Transactional
	public void deleteUser(Integer userId){
		userRepository.delete(userId);
	}
	
	@Transactional
	public List<Permission> getPermissionByUserId(Integer userId){
		return userRepository.getPermissionByUserId(userId);
	}
	
	
}


 