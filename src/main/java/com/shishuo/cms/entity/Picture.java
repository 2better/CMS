package com.shishuo.cms.entity;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by labber on 2017/6/15.
 */
public class Picture implements Serializable{

    private Integer id;
    private String name;
    private String picUrl;
    private Date createTime;
    private Integer type;//0是轮播图 1是大图
    private int size;

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPicUrl() {
        return picUrl;
    }

    public void setPicUrl(String picUrl) {
        this.picUrl = picUrl;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getCreateTimeView() {
        if(this.createTime == null ) return "";
        DateFormat df = new SimpleDateFormat("yyyy年MM月dd日");
        return df.format(this.createTime);
    }

    public String getPicType() {
        if (this.type == 1)return "是";
        return "否";
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }
}
