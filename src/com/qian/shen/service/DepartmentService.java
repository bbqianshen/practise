package com.qian.shen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qian.shen.entity.Department;
import com.qian.shen.repository.DepartmentRepository;

@Service
public class DepartmentService {

	@Autowired
	private DepartmentRepository departmentRepository;
	
	@Transactional
	public List<Department> getAll(){
		return departmentRepository.findAll();
	}
	
	@Transactional
	public Department getByDeptId(Integer deptId){
		return departmentRepository.getByDeptId(deptId);
	}
}
