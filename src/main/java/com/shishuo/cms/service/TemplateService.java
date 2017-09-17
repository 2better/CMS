/*
 *	Copyright © 2013 Changsha Shishuo Network Technology Co., Ltd. All rights reserved.
 *	长沙市师说网络科技有限公司 版权所有
 *	http://www.shishuo.com
 */

package com.shishuo.cms.service;

import java.io.File;


import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.shishuo.cms.constant.SystemConstant;
import com.shishuo.cms.exception.TemplateNotFoundException;

/**
 * 模板工具类
 * 
 * @author Herbert
 * 
 */
@Service
public class TemplateService {

	private static String FILE_TEMPLATE_PREFIX = "article";

	protected final Logger logger = Logger.getLogger(this.getClass());

	/**
	 * @return
	 */
	public String get404() {
		return this.getTemplatePath("404");
	}

	/**
	 * @return
	 */
	public String get500() {
		return this.getTemplatePath("500");
	}

	public String getRefuse() {
		return this.getTemplatePath("refuse");
	}

	/**
	 * 得到首页（默认页）模板
	 * 
	 * @return
	 * @throws TemplateNotFoundException
	 */
	public String getDefaultTemplate() throws TemplateNotFoundException {
		if (this.isExist("index")) {
			return this.getTemplatePath("index");
		}
		throw new TemplateNotFoundException("模板文件：index 不存在！！");
	}


	/**
	 * 得到文件模板
	 *
	 * @return
	 * @throws TemplateNotFoundException
	 */
	public String getArticleTemplate()
			throws TemplateNotFoundException{

			if (this.isExist(FILE_TEMPLATE_PREFIX)) {
				return this.getTemplatePath(FILE_TEMPLATE_PREFIX);
			}

		throw new TemplateNotFoundException("模板文件："
				+ this.getTemplatePath(FILE_TEMPLATE_PREFIX) + " 不存在！！");
	}

	/**
	 * 得到当前请求需要渲染的模板相对路径
	 * 
	 * @param
	 * @return
	 */
	private String getTemplatePath(String template) {
		return File.separator+"template"+File.separator+"blog"+ File.separator + template;
	}

	/**
	 * 模板物理地址是否存在
	 * 
	 * @param theme
	 * @return
	 */
	@Cacheable("default")
	public Boolean isExist(String theme) {
		String themePath = File.separator+"WEB-INF"+File.separator+"static"+File.separator+"template"+File.separator+"blog"+ File.separator + theme + ".ftl";
		File file = new File(SystemConstant.SHISHUO_CMS_ROOT + themePath);
		if (file.exists()) {
			//logger.info("尝试使用模板：" + themePath+"【存在】");
			return true;
		} else {
			//logger.info("尝试使用模板：" + themePath+"【不存在】");
			return false;
		}
	}

}
