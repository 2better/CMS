/*
 *	Copyright © 2013 Changsha Shishuo Network Technology Co., Ltd. All rights reserved.
 *	长沙市师说网络科技有限公司 版权所有
 *	http://www.shishuo.com
 */

package com.shishuo.cms.entity.vo;

import java.util.List;


/**
 * 分页器
 * 
 * @author Herbert
 * 
 * @param <T>
 */
public class PageVo<T> {
	/**
	 * 页码
	 */
	private int pageNum;
	/**
	 * 页码总数
	 */
	private int pageCount;
	/**
	 * 总数
	 */
	private int count;
	/**
	 * 偏移
	 */
	private int offset;
	/**
	 * 数量
	 */
	private int rows;
	/**
	 * 数据
	 */
	private List<T> list;


	public PageVo(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getPageNum() {
		if (this.pageNum <= 0) {
			this.pageNum = 1;
			return 1;
		} else {
			return pageNum;
		}
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getPageCount() {
		this.pageCount = ((this.getCount() - 1) / this.getRows()) + 1;
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getOffset() {
		this.offset = (this.getPageNum() - 1) * this.getRows();
		return offset;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

}
