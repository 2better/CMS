/*
 *	Copyright © 2013 Changsha Shishuo Network Technology Co., Ltd. All rights reserved.
 *	长沙市师说网络科技有限公司 版权所有
 *	http://www.shishuo.com
 */
package com.shishuo.cms.dao;

import com.shishuo.cms.entity.Friendlylink;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 管理员
 * 
 * @author Zhangjiale
 */

@Repository
public interface FriendlylinkDao {

	 void addFriendlylink(Friendlylink friendlylink);

	 int deleteFriendlylink(int id);

	 void updateFriendlylinkById(Friendlylink friendlylink);

	void modifySortById(int id,int sort);

	 List<Friendlylink> getAllList();

	 List<Friendlylink> getAllDisplay();

	 Friendlylink getById(int id);

}
