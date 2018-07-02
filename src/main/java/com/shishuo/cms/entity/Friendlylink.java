package com.shishuo.cms.entity;

import com.shishuo.cms.constant.ArticleConstant;

import java.io.Serializable;

/**
 * @author zyl
 * @create 2017/6/15
 */

public class Friendlylink implements Serializable
{
    private static final long serialVersionUID = -2180152511028055777L;
    private int id;
    private String name;
    private String url;
    private int sort;
    private ArticleConstant.Status status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getSort() {
        return sort;
    }

    public void setSort(int sort) {
        this.sort = sort;
    }

    public ArticleConstant.Status getStatus() {
        return status;
    }

    public void setStatus(ArticleConstant.Status status) {
        this.status = status;
    }
}
