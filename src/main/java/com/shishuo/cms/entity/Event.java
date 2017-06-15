package com.shishuo.cms.entity;

/**
 * Created by labber on 2017/6/12.
 */
public class Event extends Information{
    private Integer important;//1是重要活动，0不是
    private String name;

    public Integer getImportant() {
        return important == 1 ? 1 : 0;
    }

    public void setImportant(Integer important) {
        this.important = important;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImportance() {
        return this.important == 1 ? "是" : "否";
    }
}
