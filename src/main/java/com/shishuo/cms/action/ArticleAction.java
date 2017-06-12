/*
 *	Copyright © 2013 Changsha Shishuo Network Technology Co., Ltd. All rights reserved.
 *	长沙市师说网络科技有限公司 版权所有
 *	http://www.shishuo.com
 */

package com.shishuo.cms.action;

import com.shishuo.cms.entity.Article;
import com.shishuo.cms.entity.Menu;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.service.ConfigService;
import com.shishuo.cms.service.MenuService;
import com.shishuo.cms.util.PageStaticUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;


import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Herbert
 * 
 */
@Controller
@RequestMapping("/article")
public class ArticleAction extends BaseAction {

	@Autowired
	private MenuService menuService;
	@Autowired
	private ConfigService configService;
	@Autowired
	private PageStaticUtils pageStaticUtils;

	@RequestMapping(value = "/{articleId}.htm", method = RequestMethod.GET)
	public String article(@PathVariable long articleId,
						  ModelMap modelMap, HttpServletRequest request) {
		try {
			Article article = fileService.getArticleById(articleId);
			List<Menu> menus = menuService.getWithChildById(article.getMenu().getPid());
			modelMap.put("menus",menus.get(0));
			modelMap.addAttribute("article", article);

			pageStaticUtils.headerStaticPage(request);
			return themeService.getArticleTemplate();
		} catch (Exception e) {
			e.printStackTrace();
			return themeService.get404();
		}
	}

	@RequestMapping(value = "/list.htm", method = RequestMethod.GET)
	public String list(@RequestParam(value = "menuId") long menuId,ModelMap modelMap,HttpServletRequest request) {
		try {

			Menu menu = menuService.getByid(menuId);
			List<Menu> menus = menuService.getWithChildById(menu.getPid());
			int count = fileService.getArticleCountByMenuId(menuId,"display");
			int rows = configService.getIntKey("pagination_num");
			int pageCount = fileService.getPageCount(count,rows);


			modelMap.put("Menu",menu);
			modelMap.put("menus",menus.get(0));
			modelMap.put("count",count);
			modelMap.put("pageCount",pageCount);

			pageStaticUtils.headerStaticPage(request);
			return "template/blog/article_list";
		} catch (Exception e) {
			e.printStackTrace();
			return themeService.get404();
		}
	}

	@RequestMapping(value = "/listJson.json", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> listJson(@RequestParam(value = "menuId") long menuId,
								 @RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
		Map<String,Object> map = new HashMap<String,Object>();
		int rows = configService.getIntKey("pagination_num");
		map.put("list",fileService.getArticleByMenuId(menuId,pageNum,rows));
		map.put("pageNum",pageNum);
		return map;
	}
}
