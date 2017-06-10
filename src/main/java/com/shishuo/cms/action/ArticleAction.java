/*
 *	Copyright © 2013 Changsha Shishuo Network Technology Co., Ltd. All rights reserved.
 *	长沙市师说网络科技有限公司 版权所有
 *	http://www.shishuo.com
 */

package com.shishuo.cms.action;

import com.shishuo.cms.entity.Article;
import com.shishuo.cms.entity.Menu;
import com.shishuo.cms.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


import java.util.List;

/**
 * @author Herbert
 * 
 */
@Controller
@RequestMapping("/article")
public class ArticleAction extends BaseAction {

	@Autowired
	private MenuService menuService;

	@RequestMapping(value = "/{articleId}.htm", method = RequestMethod.GET)
	public String article(@PathVariable long articleId,
			ModelMap modelMap) {
		try {
			Article article = fileService.getArticleById(articleId);
			List<Menu> menuList = menuService.getAllDisplay();
			Menu menu = menuService.getByid(article.getMenuId());
			List<Menu> menus = menuService.getWithChildById(menu.getPid());
			modelMap.put("menuList",menuList);
			modelMap.put("menus",menus.get(0));
			modelMap.addAttribute("article", article);
			return themeService.getArticleTemplate();
		} catch (Exception e) {
			return themeService.get404();
		}
	}
}
