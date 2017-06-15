package com.shishuo.cms.service;

import com.shishuo.cms.dao.CompositionDao;
import com.shishuo.cms.dao.ScholarDao;
import com.shishuo.cms.entity.Composition;
import com.shishuo.cms.entity.Scholar;
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
public class ScholarService {

    @Autowired
    private ScholarDao scholarDao;

    public void add(String name, String content,  String createTime, String picUrl) {
        Scholar scholar = new Scholar();
        scholar.setName(name);
        scholar.setContent(content);
        scholar.setPicUrl(picUrl);
        scholar.setCreateTime(scholar.setTime(createTime));
        scholarDao.add(scholar);
    }

    public void update(Integer id,String name, String content,  String createTime, String picUrl) {
        Scholar scholar = getById(id);
        if(scholar != null && scholar.getId() != null) {
            scholar.setName(name);
            scholar.setPicUrl(picUrl);
            scholar.setContent(content);
            scholar.setCreateTime(scholar.setTime(createTime));
            scholarDao.update(scholar);
        }
    }

    public Scholar getById(Integer id) {
        return scholarDao.getById(id);
    }

    public PageVo<Scholar> getByPage(int pageNum, int rows) {
        PageVo<Scholar> pv = new PageVo<Scholar>(pageNum);
        pv.setCount(scholarDao.getCount());
        pv.setRows(rows);
        List<Scholar> scholars = scholarDao.getByPage(pv.getOffset(), rows);
        pv.setList(scholars);
        return pv;
    }

    public void delete(Integer id, String picUrl) {
        if (StringUtils.isNotBlank(picUrl))
            MediaUtils.deleteFile(picUrl);
        scholarDao.delete(id);
    }

}

