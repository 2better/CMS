package com.shishuo.cms.dao;

import com.shishuo.cms.entity.Menu;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author zyl
 * @create 2017/6/6
 */
@Repository
public interface MenuDao
{
    long add(Menu menu);
    int delete(long id);
    void update(Menu menu);
    List<Menu> getChildren(long pid);
    List<Menu> getAll();
    List<Menu> getAllDisplay();
    List<Menu> getAllDisplayExceptLeaf();
    Menu getWithChildById(long id);
    void modifySortById(long id,int sort);
    Menu getById(long id);
    int getCountOfChilden(long pid);
    void modifyIsLeaf(@Param("id")long id,@Param("isLeaf")int isLeaf);
}
