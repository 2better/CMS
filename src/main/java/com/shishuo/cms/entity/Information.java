package com.shishuo.cms.entity;

import org.apache.commons.lang3.StringUtils;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by labber on 2017/6/12.
 */
//活动、学者、著作的共同信息
public class Information implements Serializable{
    private Integer id;
    private String content;
    private String picUrl;
    private Date createTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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

    public Date setTime(String createTime) {
        Date date = new Date();
        if (!StringUtils.isBlank(createTime)) {
            SimpleDateFormat sdf = new SimpleDateFormat(
                    "yyyy-MM-dd");
            try {
                date = sdf.parse(createTime);
            } catch (ParseException ee) {
                return date;
            }
        }
        return date;
    }
}
