/*
 *	Copyright © 2013 Changsha Shishuo Network Technology Co., Ltd. All rights reserved.
 *	长沙市师说网络科技有限公司 版权所有
 *	http://www.shishuo.com
 */

package com.shishuo.cms.service;

import com.shishuo.cms.dao.UserDao;
import com.shishuo.cms.entity.User;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.util.IDUtils;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
@Service
public class UserService {

	@Autowired
	private UserDao userDao;


	public void addUser(String name, String password) {
		Date now = new Date();
		User user = new User();
		user.setUserId(IDUtils.getId());
		user.setName(name);

		String salt = new SecureRandomNumberGenerator().nextBytes().toHex();
		SimpleHash hash = new SimpleHash("MD5", password, ByteSource.Util.bytes(salt), 1);
		user.setSalt(salt);
		user.setPassword(hash.toHex());

		user.setCreateTime(now);
		userDao.addUser(user);
	}

	
	public int deleteUser(long userId) {
		return userDao.deleteUser(userId);
	}
	

	public void updateUserByUserId(long userId, String password)
			{
		String salt = new SecureRandomNumberGenerator().nextBytes().toHex();
		SimpleHash hash = new SimpleHash("MD5", password, ByteSource.Util.bytes(salt), 1);
				userDao.updateUserByuserId(userId, hash.toHex(),salt);
	}
	
	public User getUserById(long userId) {
		return userDao.getUserById(userId);
	}


	public PageVo<User> getAllListPage(int pageNum,int rows) {
		PageVo<User> pageVo = new PageVo<User>(pageNum);
		pageVo.setRows(rows);
		List<User> list = userDao.getAllList(pageVo.getOffset(),rows);
		pageVo.setList(list);
		pageVo.setCount(userDao.getAllListCount());
		return pageVo;
	}

	public User getUserByName(String name) {
		return userDao.getUserByName(name);
	}

	public int getAllCount(){
		return userDao.getAllListCount();
	}

	public boolean checkPwd(long id,String pwd)
	{
		User user = userDao.getUserById(id);
		SimpleHash hash = new SimpleHash("MD5", pwd, ByteSource.Util.bytes(user.getSalt()), 1);
		return user.getPassword().equals(hash.toHex());
	}
}
