package com.shishuo.cms.dao;

import com.shishuo.cms.entity.Document;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author zyl
 * @create 2017/5/31
 */
@Repository
public interface DocumentDao
{
    int add(Document document);

    List<Document> getDocList();

    Document getById(long id);

    void modifyPreviewById(long id,String preview);

    void delete(long id);
}
