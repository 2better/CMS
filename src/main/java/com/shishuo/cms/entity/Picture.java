package com.shishuo.cms.entity;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by labber on 2017/6/15.
 */
public class Picture implements Serializable{

    private static final long serialVersionUID = -3556914912312334759L;
    private Integer id;
    private String name;
    private String picUrl;
    private Date createTime;
    private Integer type;//0是轮播图 1是重要活动 2主任致辞
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
        switch (this.type){
            case 0:
                return "轮播图";
            case 1:
                return "重要活动";
            default:
                return "主任致辞";
        }

    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }
}
