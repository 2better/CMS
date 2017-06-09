package com.shishuo.cms.entity.vo;

import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.shishuo.cms.entity.Article;

public class ArticleVo extends Article {

	private String pictureUrl;

	public String getPictureUrl() {
		if (StringUtils.isBlank(this.getPicture())) {
			return "upload/blank.jpg";
		} else {
			return this.getPicture();
		}
	}

}
