/*
 *	Copyright © 2013 Changsha Shishuo Network Technology Co., Ltd. All rights reserved.
 *	长沙市师说网络科技有限公司 版权所有
 *	http://www.shishuo.com
 */

package com.shishuo.cms.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.shishuo.cms.util.PageStaticUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.shishuo.cms.dao.ConfigDao;
import com.shishuo.cms.entity.Config;

/**
 * 网站配置
 *
 * @author Zhangjiale
 */
@Service
public class ConfigService {

    @Autowired
    private ConfigDao configDao;

    @CacheEvict(value = "config",allEntries = true)
    public void updagteConfig(Map<String, String> map) {
        for (Map.Entry<String, String> entry : map.entrySet()) {
            configDao.updateConfig(entry.getKey(),entry.getValue());
        }
        PageStaticUtils.updateTemplate("header");
        PageStaticUtils.updateTemplate("footer");
    }

    @Cacheable(value = "config")
    public String getStringByKey(String key) {
        Config config = configDao.getConfigByKey(key);
        if (config == null) {
            return "";
        } else {
            return config.getValue();
        }
    }


    @Cacheable(value = "config")
    public int getIntKey(String key) {
        Config config = configDao.getConfigByKey(key);
        if (config == null) {
            return 0;
        } else {
            return Integer.parseInt(config.getValue());
        }
    }

    public List<Config> findAll() {
        return configDao.findAll();
    }
}
