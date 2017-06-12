/*
 *	Copyright © 2013 Changsha Shishuo Network Technology Co., Ltd. All rights reserved.
 *	长沙市师说网络科技有限公司 版权所有
 *	http://www.shishuo.com
 */

package com.shishuo.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.shishuo.cms.entity.Article;


/**
 * 文件服务
 * 
 * @author Harbored
 * 
 */
@Repository
public interface ArticleDao {

	/**
	 * 增加文件
	 * 
	 * @return Integer
	 */
	 void addArticle(Article article);

	/**
	 * 删除文件
	 * 
	 * @return boolean
	 */
	 boolean deleteArticleById(@Param("articleId") long articleId);

	/**
	 * 修改文件
	 * 
	 * @param article
	 * @return Integer
	 */
	 int updateArticle(Article article);

	/**
	 * 得到文件
	 * 
	 * @param articleId
	 * @return File
	 */
	 Article getArticleById(@Param("articleId") long articleId);

	int getArticleCountByMenuId(@Param("menuId") long menuId,@Param("status") String status);

	List<Article> getArticleByMenuId(@Param("menuId") long menuId,@Param("offset") int offset, @Param("rows") int rows);

	/**
	 * 多条件组合查询，并分页
	 * @param menuId
	 * @param adminId
	 * @param status
	 * @param keywords
	 * @param offset
	 * @param rows
	 * @return
	 */
	public List<Article> findByCondition(@Param("menuId") long menuId,@Param("adminId") long adminId,@Param("status") String status,@Param("keywords") String keywords,@Param("offset") int offset, @Param("rows") int rows);

	/**
	 * 多条件组合下查找到的结果数
	 * @param menuId
	 * @param adminId
	 * @param status
	 * @param keywords
	 * @return
	 */
	int allCountByCondition(@Param("menuId") long menuId,@Param("adminId") long adminId,@Param("status") String status,@Param("keywords") String keywords);


	//按时间排序查找目录下的文章
	List<Article> getArticeByMenuIdByTime(@Param("menuId") long menuId, @Param("num") int num);

}
