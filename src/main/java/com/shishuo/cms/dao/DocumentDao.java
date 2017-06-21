package com.shishuo.cms.dao;

import com.shishuo.cms.entity.Document;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author zyl
 * @create 2017/5/31
 */
@Repository
public interface DocumentDao
{
    void add(Document document);

    Document getById(long id);

    void modifyPreviewById(long id, String preview);

    void delete(long id);

    /**
     * 多条件组合查询，并分页
     * @param adminId
     * @param keywords
     * @param offset
     * @param rows
     * @return
     */
     List<Document> findByCondition(@Param("adminId") long adminId, @Param("keywords") String keywords, @Param("column") int column, @Param("offset") int offset, @Param("rows") int rows);

    /**
     * 多条件组合下查找到的结果数
     * @param adminId
     * @param keywords
     * @return
     */
    int allCountByCondition(@Param("adminId") long adminId, @Param("keywords") String keywords, @Param("column") int column);

    List<Document> getBy_Column(@Param("column") int column, @Param("offest") int offest, @Param("rows") int rows);

    int getCountByColumn(int column);

    List<Document> findByColumn(@Param("column") int column, @Param("offset") int offset, @Param("rows") int rows);

    int getAllCount();
}
