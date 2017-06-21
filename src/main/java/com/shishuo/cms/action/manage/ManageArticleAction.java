/*
 *	Copyright © 2013 Changsha Shishuo Network Technology Co., Ltd. All rights reserved.
 *	长沙市师说网络科技有限公司 版权所有
 *	http://www.shishuo.com
 */

package com.shishuo.cms.action.manage;

import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shishuo.cms.constant.SystemConstant;
import com.shishuo.cms.entity.Menu;
import com.shishuo.cms.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shishuo.cms.action.ArticleAction;
import com.shishuo.cms.constant.ArticleConstant;
import com.shishuo.cms.constant.MediaConstant;
import com.shishuo.cms.entity.Admin;
import com.shishuo.cms.entity.Article;
import com.shishuo.cms.entity.Media;
import com.shishuo.cms.entity.vo.JsonVo;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.exception.ArticleNotFoundException;
import com.shishuo.cms.util.SSUtils;

/**
 * @author 文件action
 * 
 */
@Controller
@RequestMapping("/manage/article")
public class ManageArticleAction extends ManageBaseAction {

	@Autowired
	private ArticleAction articleAction;
	@Autowired
	private MenuService menuService;

	@RequestMapping(value = "/add.htm", method = RequestMethod.GET)
	public String add(ModelMap modelMap)
	{
		List<Menu> menus = menuService.getAllDisplay();
		modelMap.put("menus", menus);
		return "manage/article/add";
	}

	@ResponseBody
	@RequestMapping(value = "/add.json", method = RequestMethod.POST)
	public JsonVo<Article> add(
			@RequestParam("menuId") long menuId,
			@RequestParam("title") String title,
			@RequestParam("content") String content,
			@RequestParam(value = "createTime", required = false) String createTime,
			@RequestParam("status") ArticleConstant.Status status,
			HttpServletRequest request)
	{
		JsonVo<Article> json = new JsonVo<Article>();
		try {
			Article article = articleService.addArticle(menuId,
					this.getAdmin(request).getAdminId(),
					SSUtils.toText(title.trim()),
					this.getAdmin(request).getName(),
					status, content,
					createTime);
			json.setT(article);
			json.setResult(true);
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			json.setResult(false);
			return json;
		}
	}

	@RequestMapping(value = "/listPage.htm", method = RequestMethod.GET)
	public String listPage(HttpServletRequest request,ModelMap modelMap)
	{
		List<Menu> menus = menuService.getAllDisplay();
		Admin admin = this.getAdmin(request);
		int allCount = articleService.allCountByCondition(-1,-1,"all","");
		int admidArtCount = articleService.allCountByCondition(-1,admin.getAdminId(),"all","");
		modelMap.put("menus", menus);
		modelMap.put("allCount", allCount);
		modelMap.put("admidArtCount", admidArtCount);

		return "manage/article/list";
	}

	@RequestMapping(value = "/list.json", method = RequestMethod.POST)
	@ResponseBody
	public PageVo<Article> list(
			@RequestParam(value = "p", defaultValue = "1") int pageNum,
			@RequestParam(value = "menuId", defaultValue = "-1") long menuId,
			@RequestParam(value = "adminId", defaultValue = "-1") long adminId,
			@RequestParam(value = "status", defaultValue = "all") ArticleConstant.Status status,
			@RequestParam(value = "keywords", defaultValue = "") String keywords)
	{
		int num = configService.getIntKey("pagination_num");
		PageVo<Article> pageVo = articleService.findByCondition(menuId,adminId,status.toString(),keywords,pageNum,num);
		return pageVo;
	}

	/**
	 * @author 进入修改文章页面
	 * @throws Exception
	 * 
	 */
	@RequestMapping(value = "/update.htm", method = RequestMethod.GET)
	public String update(
			@RequestParam(value = "articleId", defaultValue = "1") long articleId,
			ModelMap modelMap) throws Exception {

		Article article = articleService.getArticleById(articleId);
		List<Menu> menus = menuService.getAllDisplay();
		Menu menu = menuService.getByid(article.getMenuId());
		modelMap.put("menus", menus);
		modelMap.put("Menu", menu);
		modelMap.put("article", article);
		return "manage/article/update";
	}


	@ResponseBody
	@RequestMapping(value = "/update.json", method = RequestMethod.POST)
	public JsonVo<Article> update(
			@RequestParam("articleId") long articleId,
			@RequestParam("menuId") long menuId,
			@RequestParam("title") String title,
			@RequestParam(value = "createTime", required = false) String createTime,
			@RequestParam("content") String content,
			@RequestParam("status") ArticleConstant.Status status,
			HttpServletRequest request)
			throws ParseException {
		JsonVo<Article> json = new JsonVo<Article>();
		try {
			Article article = articleService.updateArticle(articleId,
					menuId, SSUtils.toText(title.trim()),
					content, status,createTime);
			json.setT(article);
			json.setResult(true);
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			json.setResult(false);
			return json;
		}
	}

	@ResponseBody
	@RequestMapping(value = "/delete.json", method = RequestMethod.POST)
	public JsonVo<String> deleteFile(
			@RequestParam(value = "articleId") long articleId)
			throws ArticleNotFoundException {
		JsonVo<String> json = new JsonVo<String>();
		// 删除文件系统
		articleService.deleteArticleById(articleId);
		List<Media> attachmentList = attachmentService.getMediaPageByKindId(
				articleId, MediaConstant.Kind.article, 1000, 1).getList();
		for (Media attachment : attachmentList) {
			attachmentService.deleteMedia(attachment.getMediaId(),
					attachment.getPath());
		}
		json.setResult(true);
		return json;
	}


	@RequestMapping(value = "/preview.htm", method = RequestMethod.GET)
	public String preview(@RequestParam(value = "articleId") long articleId, HttpServletRequest request) {
		return articleAction.article(articleId,request);
	}
}
