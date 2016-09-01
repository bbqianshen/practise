package com.qian.shen.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

@Table(name = "Roles")
@Entity
public class Role {

	private Integer roleId;
	private String roleName;
	private String roleDesc;
	private Integer status = 1;
	private Set<Permission> permissions = new HashSet<>();
	private Set<User> users = new HashSet<>();

	@GeneratedValue
	@Id
	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getRoleDesc() {
		return roleDesc;
	}

	public void setRoleDesc(String roleDesc) {
		this.roleDesc = roleDesc;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@JoinTable(name = "ROLE_PERMISSION", joinColumns = { @JoinColumn(name = "ROLE_ID", referencedColumnName = "roleId") }, inverseJoinColumns = { @JoinColumn(name = "PERMISSION_ID", referencedColumnName = "id") })
	@ManyToMany(fetch=FetchType.LAZY)
	public Set<Permission> getPermissions() {
		return permissions;
	}

	public void setPermissions(Set<Permission> permissions) {
		this.permissions = permissions;
	}

	@ManyToMany(mappedBy = "roles",fetch=FetchType.LAZY)
	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}

	@Transient
	public Set<String> getPermissionsName() {
		Set<String> set = new HashSet<>();
		Set<Permission> perlist = getPermissions();
		for (Permission per : perlist) {
			set.add(per.getPermissionName());
		}
		return set;
	}

}
