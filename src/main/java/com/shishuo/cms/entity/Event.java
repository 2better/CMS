package com.shishuo.cms.entity;

/**
 * Created by labber on 2017/6/12.
 */
public class Event extends Information{
    private static final long serialVersionUID = 625983197908319422L;
    private Integer important;//1是重要活动，0不是
    private String name;
    private String link;

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

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }
}
