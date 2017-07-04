package com.shishuo.cms.service;

import com.shishuo.cms.dao.MenuDao;
import com.shishuo.cms.entity.Menu;
import com.shishuo.cms.util.IDUtils;
import com.shishuo.cms.util.PageStaticUtils;
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
        if(createUrl==1)
            menu.setUrl("/article/list.htm?menuId="+id);
        menuDao.add(menu);
        menuDao.modifyIsLeaf(menu.getPid(),0);
        PageStaticUtils.updateTemplate("header");
    }

    @CacheEvict(value = "menu", allEntries = true)
    public void delete(long id)
    {
        Menu menu = menuDao.getById(id);
        int count = menuDao.getCountOfChilden(menu.getPid());
        if(count==0)
            menuDao.modifyIsLeaf(menu.getPid(),1);
        menuDao.delete(id);
        PageStaticUtils.updateTemplate("header");
    }

    public List<Menu> getAll()
    {
        return menuDao.getAll();
    }

    public List<Menu> getChildren()
    {
        return menuDao.getChildren(0);
    }

    public Menu getWithChildById(long id)
    {
        return menuDao.getWithChildById(id);
    }

    @CacheEvict(value = "menu", allEntries = true)
    public void modifySortById(long id,int sort)
    {
        menuDao.modifySortById(id,sort);
        PageStaticUtils.updateTemplate("header");
    }

    public Menu getByid(long id){
        return menuDao.getById(id);
    }

    @CacheEvict(value = "menu", allEntries = true)
    public void update(Menu menu,int createUrl)
    {
        if(createUrl==1)
            menu.setUrl("/article/list.htm?menuId="+menu.getId());
        menuDao.update(menu);
        PageStaticUtils.updateTemplate("header");
    }

    public int getCountOfChilden(long pid)
    {
        return menuDao.getCountOfChilden(pid);
    }

    @Cacheable(value = "menu")
    public List<Menu> getAllDisplay()
    {
        List<Menu> list =  menuDao.getAllDisplay();
        for(Menu first:list)
        {
            for(Menu second:first.getChildren())
            {
                if(second.getIsLeaf()==0)
                    second.setChildren(menuDao.getChildren(second.getId()));
            }
        }
        return list;
    }
}
