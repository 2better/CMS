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

	// ///////////////////////////////
	// ///// 增加 ////////
	// ///////////////////////////////

	/**
	 * 增加文件
	 * 
	 * @return Integer
	 */
	public void addArticle(Article article);

	// ///////////////////////////////
	// ///// 刪除 ////////
	// ///////////////////////////////

	/**
	 * 删除文件
	 * 
	 * @return boolean
	 */
	public boolean deleteArticleById(@Param("articleId") long articleId);

	// ///////////////////////////////
	// ///// 修改 ////////
	// ///////////////////////////////

	/**
	 * 修改文件
	 * 
	 * @param article
	 * @return Integer
	 */
	public int updateArticle(Article article);


	// ///////////////////////////////
	// ///// 查詢 ////////
	// ///////////////////////////////

	/**
	 * 得到文件
	 * 
	 * @param articleId
	 * @return File
	 */
	public Article getArticleById(@Param("articleId") long articleId);


	/**
	 * 得到某种显示的文件的列表
	 * 
	 * @param foderId
	 * @return List<FileVo>
	 */
	public List<Article> getArticleListByAdminId(
			@Param("adminId") long adminId,
			@Param("offset") long offset, @Param("rows") long rows);

	/**
	 * @param firstFolderId
	 * @param secondFolderId
	 * @param thirdFolderId
	 * @param fourthFolderId
	 * @return
	 */
	public int getArticleCountByAdminId(@Param("adminId") long adminId);

	/**
	 * @param adminId
	 * @param path
	 * @return
	 */
	public int getArticleCountByMenuId(@Param("menuId") long menuId);

	public List<Article> getArticleListByMenuId(
			@Param("menuId") long menuId,
			@Param("offset") long offset, @Param("rows") long rows);

	public List<Article> findByCondition(@Param("menuId") long menuId,@Param("adminId") long adminId,@Param("status") String status,@Param("keywords") String keywords,@Param("offset") int offset, @Param("rows") int rows);

	int allCountByCondition(@Param("menuId") long menuId,@Param("adminId") long adminId,@Param("status") String status,@Param("keywords") String keywords);

}
