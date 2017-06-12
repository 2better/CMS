package com.shishuo.cms.entity;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author zyl
 * @create 2017/5/31
 */

public class Document
{
    private long id;
    private long adminId;
    private String adminName;
    private String name;
    private String type;
    private String path;
    private String preview;
    private int column;//所属栏目
    private Date created;

    private static Map<Integer,String> columnMap = new HashMap<Integer,String>();
    static{
        columnMap.put(1,"智库专报");
        columnMap.put(2,"学术论文");
    }

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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getPreview() {
        return preview;
    }

    public void setPreview(String preview) {
        this.preview = preview;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public long getAdminId() {
        return adminId;
    }

    public void setAdminId(long adminId) {
        this.adminId = adminId;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getCreatedView() {
        if(this.created == null ) return "";
        DateFormat df = new SimpleDateFormat("yyyy年MM月dd日");
        return df.format(this.created);
    }

    public int getColumn() {
        return column;
    }

    public void setColumn(int column) {
        this.column = column;
    }

    public String getColumnView()
    {
        return columnMap.get(this.column);
    }
}
