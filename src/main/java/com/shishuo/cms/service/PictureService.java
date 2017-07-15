package com.shishuo.cms.service;

import com.shishuo.cms.dao.PictureDao;
import com.shishuo.cms.entity.Composition;
import com.shishuo.cms.entity.Picture;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.util.MediaUtils;
import com.shishuo.cms.util.PageStaticUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class PictureService {

    @Autowired
    private PictureDao pictureDao;

    public void add(String name, String picUrl,int size, Integer type) {
        Picture picture = new Picture();
        picture.setName(name);
        picture.setPicUrl(picUrl);
        picture.setSize(size);
        picture.setType(type);
        picture.setCreateTime(new Date());
        pictureDao.add(picture);
        PageStaticUtils.updateTemplate("header");
    }

    public Picture getById(Integer id) {
        return pictureDao.getById(id);
    }

    public void delete(Integer id, String picUrl) {
        if (StringUtils.isNotBlank(picUrl))
            MediaUtils.deleteFile("/" + picUrl);
        pictureDao.delete(id);
        PageStaticUtils.updateTemplate("header");
    }

    public PageVo<Picture> getByPage(Integer p, Integer rows) {
        PageVo<Picture> pv = new PageVo<Picture>(p);
        pv.setRows(rows);
        pv.setCount(pictureDao.getCount());
        pv.setList(pictureDao.getPictureList(pv.getOffset(),rows));
        return pv;
    }

    public List<Picture> getAllByType(Integer type) {
        return pictureDao.getAllByType(type);
    }
}

