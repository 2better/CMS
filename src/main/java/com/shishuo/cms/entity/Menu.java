package com.shishuo.cms.entity;

import com.shishuo.cms.constant.FolderConstant;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * @author zyl
 * @create 2017/6/6
 */

public class Menu implements Serializable
{
    private static final long serialVersionUID = -4873761410301711375L;
    private long id;
    private String name;
    private String url;
    private long pid;
    private int sort;
    private FolderConstant.status status;
    private int isLeaf;

    private List<Menu> children = new ArrayList<Menu>();

    public long getId() {
        return id;
    }

    public void setId(long id) {
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

    public long getPid() {
        return pid;
    }

    public void setPid(long pid) {
        this.pid = pid;
    }

    public List<Menu> getChildren() {
        return children;
    }

    public void setChildren(List<Menu> children) {
        this.children = children;
    }

    public int getSort() {
        return sort;
    }

    public void setSort(int sort) {
        this.sort = sort;
    }

    public FolderConstant.status getStatus() {
        return status;
    }

    public void setStatus(FolderConstant.status status) {
        this.status = status;
    }

    public int getIsLeaf() {
        return isLeaf;
    }

    public void setIsLeaf(int isLeaf) {
        this.isLeaf = isLeaf;
    }
}
