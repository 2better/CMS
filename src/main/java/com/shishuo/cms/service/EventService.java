package com.shishuo.cms.service;

import com.shishuo.cms.dao.EventDao;
import com.shishuo.cms.entity.Event;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.util.MediaUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by labber on 2017/6/12.
 */
@Service
public class EventService {

    @Autowired
    private EventDao eventDao;

    public void add(String name, String content,  String createTime, int important) {
        Event e = new Event();
        e.setImportant(important);
        e.setName(name);
        e.setContent(content);
        e.setCreateTime(e.setTime(createTime));
        eventDao.add(e);
    }

    public void update(Integer id,String name, String content,  String createTime, int important) {
        Event event = getById(id);
        if(event != null && event.getId() != null) {
            event.setImportant(important);
            event.setContent(content);
            event.setCreateTime(event.setTime(createTime));
            eventDao.update(event);
        }
    }

    public Event getById(Integer id) {
        return eventDao.getById(id);
    }

    public PageVo<Event> getByPage(int pageNum, int rows) {
        PageVo<Event> pv = new PageVo<Event>(pageNum);
        pv.setCount(eventDao.getCount());
        pv.setRows(rows);
        List<Event> events = eventDao.getByPage(pv.getOffset(), rows);
        pv.setList(events);
        return pv;
    }

    public void delete(Integer id) {
        eventDao.delete(id);
    }

    //按重要性查询
    public PageVo<Event> getByPageByImportant(int offest, int rows, Integer important) {
        PageVo<Event> pv = new PageVo<Event>(offest);
        if(important == 1) {
            pv.setList(eventDao.getByPageByImportant(offest, rows, important));
        }
        else {
            pv.setCount(eventDao.getCountByImportant(important));
            pv.setRows(rows);
            List<Event> events = eventDao.getByPageByImportant(pv.getOffset(), rows, important);
            pv.setList(events);
        }
        return pv;
    }

    public int getAllCount()
    {
        return eventDao.getAllCount();
    }

    public List<Event> getTop10()
    {
        return eventDao.getTop10();
    }
}

