package com.shishuo.cms.dao;

import com.shishuo.cms.entity.Picture;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by labber on 2017/6/15.
 */
@Repository
public interface PictureDao {
    //添加
    void add(Picture t);

    //查询
    Picture getById(Integer id);

    //删除
    void delete(Integer id);

    List<Picture> getPictureList(@Param("type") Integer type, @Param("offest")Integer offest, @Param("rows")Integer rows);

    int getCount(Integer type);

    List<Picture> getAllByType(Integer type);
}
