package com.shishuo.cms.dao;

import com.shishuo.cms.entity.Event;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by labber on 2017/6/12.
 */
//活动、著作、学者共用信息的DAO
public interface InformationDao<T> {

    //添加
    void add(T t);

    //查询
    T getById(Integer id);

    //删除
    void delete(Integer id);

    //修改
    void update(T t);

    //分页
    List<T> getByPage(@Param("offest") int offest, @Param("rows") int rows);

    //获取总数
    Integer getCount();
}
