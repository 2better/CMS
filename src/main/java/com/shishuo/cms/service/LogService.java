package com.shishuo.cms.service;

import com.shishuo.cms.constant.SystemConstant;
import com.shishuo.cms.dao.LogDao;
import com.shishuo.cms.entity.Log;
import com.shishuo.cms.entity.vo.PageVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.Date;
import java.util.List;

/**
 * @author zyl
 * @create 2017/9/2
 */
@Service
public class LogService {
    @Autowired
    private LogDao logDao;

    public PageVo<Log> findAll(Date begin, Date end, int offset, int rows){
        PageVo<Log> pageVo = new PageVo<Log>(offset);
        pageVo.setRows(rows);
        pageVo.setCount(logDao.count(begin,end));
        List<Log> articlelist = logDao.findAll(begin, end, pageVo.getOffset(), rows);
        pageVo.setList(articlelist);
        return pageVo;
    }

    public int count(Date begin,Date end)
    {
        return logDao.count(begin,end);
    }

    public void clean()
    {
        logDao.clean();
        String path = SystemConstant.SHISHUO_CMS_ROOT+File.separator+"WEB-INF"+File.separator+"log";
        File file = new File(path);
        if (file.exists()) {
            String[] tempList = file.list();
            File temp = null;
            for (int i = 0; i < tempList.length; i++) {
                    temp = new File(path + File.separator + tempList[i]);
                if (temp.isFile()) {
                    temp.delete();
                }
            }
        }
    }

    public Log getById(String id)
    {
        return logDao.getById(id);
    }

}
