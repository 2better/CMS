/*
 *	Copyright © 2013 Changsha Shishuo Network Technology Co., Ltd. All rights reserved.
 *	长沙市师说网络科技有限公司 版权所有
 *	http://www.shishuo.com
 */

package com.shishuo.cms.service;

import java.util.Date;
import java.util.List;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shishuo.cms.dao.AdminDao;
import com.shishuo.cms.entity.Admin;
import com.shishuo.cms.entity.vo.PageVo;

/**
 * 管理员
 * 
 * @author Administrator
 * 
 */
@Service
public class AdminService {

	@Autowired
	private AdminDao adminDao;

	// ///////////////////////////////
	// ///// 增加 ////////
	// ///////////////////////////////

	public Admin addAdmin(String name, String password)
	{
		Date now = new Date();
		Admin admin = new Admin();
		admin.setName(name);

		String salt = new SecureRandomNumberGenerator().nextBytes().toHex();
		SimpleHash hash = new SimpleHash("MD5", password, ByteSource.Util.bytes(salt), 1);
		admin.setSalt(salt);
		admin.setPassword(hash.toHex());

		admin.setCreateTime(now);
		adminDao.addAdmin(admin);
		return admin;
	}

	// ///////////////////////////////
	// ///// 刪除 ////////
	// ///////////////////////////////

	/**
	 * 删除管理员
	 * 
	 * @param adminId
	 * @return Integer
	 */
	public int deleteAdmin(long adminId) {
		return adminDao.deleteAdmin(adminId);
	}

	// ///////////////////////////////
	// ///// 修改 ////////
	// ///////////////////////////////

	/**
	 * 修改管理员资料
	 * 
	 * @param adminId
	 * @param name
	 * @param password
	 * @param status
	 * @return Admin
	 */

	public void updateAdminByAmdinId(long adminId, String password)
			{
		String salt = new SecureRandomNumberGenerator().nextBytes().toHex();
		SimpleHash hash = new SimpleHash("MD5", password, ByteSource.Util.bytes(salt), 1);
		adminDao.updateAdminByadminId(adminId, hash.toHex(),salt);
	}

	// ///////////////////////////////
	// ///// 查詢 ////////
	// ///////////////////////////////

	/**
	 * 通过Id获得指定管理员资料
	 */
	public Admin getAdminById(long adminId) {
		return adminDao.getAdminById(adminId);
	}

	public List<Admin> getAllList() {
		return adminDao.getAllList();
	}

	/**
	 * 获得所有管理员的数量
	 *
	 * @return Integer
	 */
	public int getAllListCount() {
		return adminDao.getAllListCount();
	}


	public Admin getAdminByName(String name) {
		return adminDao.getAdminByName(name);
	}

}
