/*
 *	Copyright © 2013 Changsha Shishuo Network Technology Co., Ltd. All rights reserved.
 *	长沙市师说网络科技有限公司 版权所有
 *	http://www.shishuo.com
 */

package com.shishuo.cms.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.shishuo.cms.entity.Menu;
import com.shishuo.cms.util.IDUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.shishuo.cms.constant.ArticleConstant;
import com.shishuo.cms.dao.ArticleDao;
import com.shishuo.cms.entity.Article;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.exception.ArticleNotFoundException;

/**
 * 
 * 文章服务
 * 
 * @author Zhangjiale
 * 
 */
@Service
public class ArticleService {

	@Autowired
	private ArticleDao articleDao;

	@Autowired
	private MenuService menuService;


	// ///////////////////////////////
	// ///// 增加 ////////
	// ///////////////////////////////


	@CacheEvict(value = "article", allEntries = true)
	public Article addArticle(long menuId, long adminId, String title,
			String adminName, ArticleConstant.Status status,String content,
			String createTime){
		Article article = new Article();
		Menu menu = menuService.getByid(menuId);
		article.setArticleId(IDUtils.getId());
		article.setAdminId(adminId);
		article.setMenuId(menuId);
		article.setMenuName(menu.getName());
		article.setAdminName(adminName);
		article.setTitle(title);
		article.setContent(content);
		article.setStatus(status);
		Date now = new Date();
		if (StringUtils.isBlank(createTime)) {
			article.setCreateTime(now);
		} else {
			SimpleDateFormat sdf = new SimpleDateFormat(
					"yyyy-MM-dd");
			Date date;
			try {
				date = sdf.parse(createTime);
			} catch (ParseException e) {
				date = now;
			}
			article.setCreateTime(date);
		}
		articleDao.addArticle(article);
		return articleDao.getArticleById(article.getArticleId());
	}

	// ///////////////////////////////
	// ///// 刪除 ////////
	// ///////////////////////////////


	@CacheEvict(value = "article", allEntries = true)
	public boolean deleteArticleById(long articleId) {
		return articleDao.deleteArticleById(articleId);
	}

	// ///////////////////////////////
	// ///// 修改 ////////
	// ///////////////////////////////

	/**
	 * 修改文件
	 *
	 */
	@CacheEvict(value = "article", allEntries = true)
	public Article updateArticle(long articleId, long menuId,
			String title,String content, ArticleConstant.Status status,
			String time){
		Date now = new Date();
		Article article = articleDao.getArticleById(articleId);
		Menu menu = menuService.getByid(menuId);
		article.setTitle(title);
		article.setMenuId(menuId);
		article.setMenuName(menu.getName());
		article.setContent(content);
		article.setStatus(status);
		if (StringUtils.isBlank(time)) {
			article.setCreateTime(now);
		} else {
			SimpleDateFormat sdf = new SimpleDateFormat(
					"yyyy-MM-dd");
			Date date;
			try {
				date = sdf.parse(time);
			} catch (ParseException e) {
				date = now;
			}
			article.setCreateTime(date);
		}
		articleDao.updateArticle(article);
		return article;
	}

	// ///////////////////////////////
	// ///// 查詢 ////////
	// ///////////////////////////////


	@Cacheable(value = "article", key = "'getArticleById_'+#articleId")
	public Article getArticleById(long articleId)
			throws ArticleNotFoundException {
		Article articleVo = articleDao.getArticleById(articleId);
		if (articleVo == null) {
			throw new ArticleNotFoundException(articleId
					+ " 文件，不存在");
		} else {
			return articleVo;
		}
	}

	@Cacheable(value = "article", key = "#menuId+'_'+#status")
	public int getArticleCountByMenuId(long menuId,String status)
	{
		return articleDao.getArticleCountByMenuId(menuId,status);
	}

	public List<Article> getArticleByMenuId(long menuId,int pageNum, int rows)
	{
		return articleDao.getArticleByMenuId(menuId,(pageNum - 1) * rows,rows);
	}

	public int getPageCount(int count,int rows) {
		return (count + rows  - 1) / rows;
	}

	public PageVo<Article> findByCondition(long menuId,long adminId,String status,String keywords,int pageNum, int rows)
	{
		PageVo<Article> pageVo = new PageVo<Article>(pageNum);
		pageVo.setRows(rows);
		pageVo.setCount(articleDao.allCountByCondition(menuId,adminId,status,keywords));
		List<Article> articlelist = articleDao.findByCondition(menuId,adminId,status,keywords,pageVo.getOffset(),rows);
		pageVo.setList(articlelist);
		return pageVo;
	}

	public int allCountByCondition(long menuId,long adminId,String status,String keywords)
	{
		return articleDao.allCountByCondition(menuId,adminId,status,keywords);
	}


}
