package com.shishuo.cms.entity;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author zyl
 * @create 2017/9/2
 */

public class Log
{
    private String id;
    private String userName;
    private String className;
    private String methodName;
    private Date createTime;
    private String message;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getMethodName() {
        return methodName;
    }

    public void setMethodName(String methodName) {
        this.methodName = methodName;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getCreateTimeView() {
        if(this.createTime == null ) return "";
        DateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        return df.format(this.createTime);
    }
}
