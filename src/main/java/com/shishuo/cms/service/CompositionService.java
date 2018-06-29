package com.shishuo.cms.service;

import com.shishuo.cms.dao.CompositionDao;
import com.shishuo.cms.dao.EventDao;
import com.shishuo.cms.entity.Composition;
import com.shishuo.cms.entity.Event;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.util.MediaUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
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
public class CompositionService {

    private final Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private CompositionDao compositionDao;
    @Autowired
    private MediaUtils mediaUtils;

    public void add(String title, String content,  String createTime, String picUrl) {
        Composition composition = new Composition();
        composition.setTitle(title);
        composition.setContent(content);
        composition.setPicUrl(picUrl);
        Date now = new Date();
        if (StringUtils.isBlank(createTime)) {
            composition.setCreateTime(now);
        } else {
            SimpleDateFormat sdf = new SimpleDateFormat(
                    "yyyy-MM-dd");
            Date date;
            try {
                date = sdf.parse(createTime);
            } catch (ParseException ee) {
                logger.error("",ee);
                date = now;
            }
            composition.setCreateTime(date);
        }
        compositionDao.add(composition);
    }

    public void update(Integer id,String title, String content,  String createTime, String picUrl) {
        Composition composition = getById(id);
        if(composition != null && composition.getId() != null) {
            composition.setTitle(title);
            composition.setPicUrl(picUrl);
            composition.setContent(content);
            Date now = new Date();
            if (StringUtils.isBlank(createTime)) {
                composition.setCreateTime(now);
            } else {
                SimpleDateFormat sdf = new SimpleDateFormat(
                        "yyyy-MM-dd");
                Date date;
                try {
                    date = sdf.parse(createTime);
                } catch (ParseException ee) {
                    logger.error("",ee);
                    date = now;
                }
                composition.setCreateTime(date);
            }
            compositionDao.update(composition);
        }
    }

    public Composition getById(Integer id) {
        return compositionDao.getById(id);
    }

    public PageVo<Composition> getByPage(int pageNum, int rows) {
        PageVo<Composition> pv = new PageVo<Composition>(pageNum);
        pv.setCount(compositionDao.getCount());
        pv.setRows(rows);
        List<Composition> compositions = compositionDao.getByPage(pv.getOffset(), rows);
        pv.setList(compositions);
        return pv;
    }

    public void delete(Integer id, String picUrl) {
        if (StringUtils.isNotBlank(picUrl))
            mediaUtils.deleteFile(picUrl);
        compositionDao.delete(id);
    }

}

