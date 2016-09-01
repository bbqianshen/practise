package com.qian.shen.entity;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

@Table(name = "USERS")
@Entity
public class User {

	private Integer userId;
	private String userName;
	private String password = "123456";
	private Set<Role> roles = new HashSet<>();
	private Set<Permission> userPermissions = new HashSet<>();
	private Department dept;
	private String chineseName;
	private Integer sex;
	private String address;
	private String phone;
	private String email;
	private String comments;
	private Date lastLogTime;
	private Integer status = 1;

	@GeneratedValue
	@Id
	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	@Column(unique = true)
	@JoinColumn(name = "USER_NAME")
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@JoinColumn(name = "DEPT_ID")
	@ManyToOne
	public Department getDept() {
		return dept;
	}

	public void setDept(Department dept) {
		this.dept = dept;
	}

	public String getChineseName() {
		return chineseName;
	}

	public void setChineseName(String chineseName) {
		this.chineseName = chineseName;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Temporal(TemporalType.TIMESTAMP)
	public Date getLastLogTime() {
		return lastLogTime;
	}

	public void setLastLogTime(Date lastLogTime) {
		this.lastLogTime = lastLogTime;
	}

	@JoinTable(name = "USER_ROLE", joinColumns = { @JoinColumn(name = "USER_ID", referencedColumnName = "userId") }, inverseJoinColumns = { @JoinColumn(name = "ROLE_ID", referencedColumnName = "roleId") })
	@ManyToMany(fetch=FetchType.LAZY)
	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}
	
	
	@JoinTable(name = "USER_PERMISSION", joinColumns = { @JoinColumn(name = "USER_ID", referencedColumnName = "userId") }, inverseJoinColumns = { @JoinColumn(name = "PERMISSION_ID", referencedColumnName = "id") })
	@ManyToMany
	public Set<Permission> getUserPermissions() {
		return userPermissions;
	}

	public void setUserPermissions(Set<Permission> userPermissions) {
		this.userPermissions = userPermissions;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}


	public User(String userName, Department dept, String chineseName,
			Integer sex, String address, String phone, String email,
			String comments) {
		super();
		this.userName = userName;
		this.dept = dept;
		this.chineseName = chineseName;
		this.sex = sex;
		this.address = address;
		this.phone = phone;
		this.email = email;
		this.comments = comments;
	}

	public User() {
		super();
	}

	@Transient
	public Set<String> getRolesName() {
		Set<Role> roles = getRoles();
		Set<String> set = new HashSet<String>();
		for (Role role : roles) {
			set.add(role.getRoleName());
		}
		return set;
	}

}
