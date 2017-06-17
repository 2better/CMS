/*
 *	Copyright © 2013 Changsha Shishuo Network Technology Co., Ltd. All rights reserved.
 *	长沙市师说网络科技有限公司 版权所有
 *	http://www.shishuo.com
 */

package com.shishuo.cms.service;

import com.shishuo.cms.dao.FriendlylinkDao;
import com.shishuo.cms.entity.Friendlylink;
import com.shishuo.cms.util.PageStaticUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class FriendlylinkService {

	@Autowired
	private FriendlylinkDao friendlylinkDao;


	public void addFriendlylink(Friendlylink friendlylink) {
		friendlylink.setSort(1);
		friendlylinkDao.addFriendlylink(friendlylink);
		PageStaticUtils.updateTemplate("footer");
	}

	
	public int deleteFriendlylink(int id) {
		PageStaticUtils.updateTemplate("footer");
		return friendlylinkDao.deleteFriendlylink(id);
	}
	

	public void updateFriendlylinkByFriendlylinkId(Friendlylink friendlylink)
	{
		friendlylinkDao.updateFriendlylinkById(friendlylink);
		PageStaticUtils.updateTemplate("footer");
	}
	
	public Friendlylink getFriendlylinkById(int id) {
		return friendlylinkDao.getById(id);
	}

	public List<Friendlylink> getAllList()
	{
		return friendlylinkDao.getAllList();
	}

	public List<Friendlylink> getAllDisplay()
	{
		return friendlylinkDao.getAllDisplay();
	}

	public void modifySortById(int id,int sort)
	{
		friendlylinkDao.modifySortById(id,sort);
		PageStaticUtils.updateTemplate("footer");
	}

}
