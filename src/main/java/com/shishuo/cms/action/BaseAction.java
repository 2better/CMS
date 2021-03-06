/*
 *	Copyright © 2013 Changsha Shishuo Network Technology Co., Ltd. All rights reserved.
 *	长沙市师说网络科技有限公司 版权所有
 *	http://www.shishuo.com
 */
package com.shishuo.cms.action;

import com.shishuo.cms.util.PageStaticUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.shishuo.cms.service.ArticleService;
import com.shishuo.cms.service.TemplateService;

/**
 * 
 * @author Herbert
 * 
 */
public class BaseAction {

	@Autowired
	protected ArticleService fileService;

	@Autowired
	protected TemplateService themeService;

	@Autowired
	protected PageStaticUtils pageStaticUtils;

	protected final Logger logger = Logger.getLogger(this.getClass());
}
