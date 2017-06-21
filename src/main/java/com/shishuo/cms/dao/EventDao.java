package com.shishuo.cms.dao;

import com.shishuo.cms.entity.Event;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by labber on 2017/6/12.
 */
@Repository
public interface EventDao extends InformationDao<Event>{

    List<Event> getByPageByImportant(@Param("offest") int offest, @Param("rows") int rows, @Param("important") Integer important);

    Integer getCountByImportant(@Param("important") Integer important);

    int getAllCount();

    List<Event> getTop10();
}
