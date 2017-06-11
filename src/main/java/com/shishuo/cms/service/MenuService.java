package com.shishuo.cms.service;

import com.shishuo.cms.dao.MenuDao;
import com.shishuo.cms.entity.Menu;
import com.shishuo.cms.util.IDUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author zyl
 * @create 2017/6/6
 */
@Service
public class MenuService
{
    @Autowired
    private MenuDao menuDao;

    @CacheEvict(value = "menu", allEntries = true)
    public void add(Menu menu,int createUrl)
    {
        long id = IDUtils.getId();
        menu.setId(id);
        menu.setSort(1);
        if(createUrl!=0)
            menu.setUrl("/manage/article/list.htm?menuId="+id);
        menuDao.add(menu);
    }

    @CacheEvict(value = "menu", allEntries = true)
    public void delete(long id)
    {
        menuDao.delete(id);
    }

    public List<Menu> getAll()
    {
        return menuDao.getAll();
    }

    public List<Menu> getAllParents()
    {
        return menuDao.getAllParents();
    }

    public List<Menu> getWithChildById(long id)
    {
        return menuDao.getWithChildById(id);
    }

    @CacheEvict(value = "menu", allEntries = true)
    public void modifySortById(long id,int sort)
    {
        menuDao.modifySortById(id,sort);
    }

    public Menu getByid(long id){
        return menuDao.getById(id);
    }

    @CacheEvict(value = "menu", allEntries = true)
    public void update(Menu menu,int createUrl)
    {
        if(createUrl!=0)
            menu.setUrl("/manage/article/list.htm?menuId="+menu.getId());
        menuDao.update(menu);
    }

    public int getCountOfChilden(long pid)
    {
        return menuDao.getCountOfChilden(pid);
    }

    @Cacheable(value = "menu")
    public List<Menu> getAllDisplay()
    {
        return menuDao.getAllDisplay();
    }
}
