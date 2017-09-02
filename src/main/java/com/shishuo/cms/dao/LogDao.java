package com.shishuo.cms.dao;

import com.shishuo.cms.entity.Log;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

/**
 * @author zyl
 * @create 2017/9/2
 */
@Repository
public interface LogDao {

    void clean();

    List<Log> findAll(@Param("begin") Date begin, @Param("end") Date end,@Param("offset") int offset, @Param("rows") int rows);

    int count(@Param("begin") Date begin, @Param("end") Date end);

    Log getById(String id);
}
