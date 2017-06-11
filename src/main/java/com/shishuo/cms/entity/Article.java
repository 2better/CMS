/*
 *	Copyright © 2013 Changsha Shishuo Network Technology Co., Ltd. All rights reserved.
 *	长沙市师说网络科技有限公司 版权所有
 *	http://www.shishuo.com
 */

package com.shishuo.cms.entity;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.shishuo.cms.constant.ArticleConstant;

/**
 * 文件实体
 * 
 * @author zsy
 * 
 */

public class Article {

	private long articleId;
	private long menuId;
	private String menuName;
	private String adminName;
	private long adminId;
	private String title;
	private String content;
	private ArticleConstant.Status status;
	private Date createTime;

	private Menu menu = new Menu();

	public long getArticleId() {
		return articleId;
	}

	public void setArticleId(long articleId) {
		this.articleId = articleId;
	}

	public long getAdminId() {
		return adminId;
	}

	public void setAdminId(long adminId) {
		this.adminId = adminId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}


	public ArticleConstant.Status getStatus() {
		return status;
	}

	public void setStatus(ArticleConstant.Status status) {
		this.status = status;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public long getMenuId() {
		return menuId;
	}

	public void setMenuId(long menuId) {
		this.menuId = menuId;
	}

	public String getAdminName() {
		return adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

	public String getCreateTimeView() {
		if(this.createTime == null ) return "";
		DateFormat df = new SimpleDateFormat("yyyy年MM月dd日");
		return df.format(this.createTime);
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public Menu getMenu() {
		return menu;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}
}
