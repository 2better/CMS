/*
 *	Copyright © 2013 Changsha Shishuo Network Technology Co., Ltd. All rights reserved.
 *	长沙市师说网络科技有限公司 版权所有
 *	http://www.shishuo.com
 */
package com.shishuo.cms.dao;

import com.shishuo.cms.entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 管理员
 * 
 * @author Zhangjiale
 */

@Repository
public interface UserDao {

	 void addUser(User user);

	 int deleteUser(@Param("userId") long userId);

	 void updateUserByuserId(@Param("userId") long userId,
                                     @Param("password") String password, @Param("salt") String salt);

	 List<User> getAllList(@Param("offset") long offset,
                                  @Param("rows") long rows);

	 int getAllListCount();

	 User getUserById(@Param("userId") long userId);

	 User getUserByName(@Param("name") String name);

}
