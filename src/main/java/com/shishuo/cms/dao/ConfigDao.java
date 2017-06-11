/*
 *	Copyright © 2013 Changsha Shishuo Network Technology Co., Ltd. All rights reserved.
 *	长沙市师说网络科技有限公司 版权所有
 *	http://www.shishuo.com
 */

package com.shishuo.cms.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.shishuo.cms.entity.Config;

import java.util.List;

/**
 * 网站配置
 * 
 * @author Zhangjiale
 * 
 */

@Repository
public interface ConfigDao {
	 int updateConfig(@Param("key") String key,@Param("value") String value);
	 Config getConfigByKey(@Param("key") String key);
	 List<Config> findAll();
}
