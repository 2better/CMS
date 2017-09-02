package com.shishuo.cms.action.manage;

import com.shishuo.cms.constant.SystemConstant;
import com.shishuo.cms.entity.Log;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author zyl
 * @create 2017/9/2
 */
@Controller
@RequestMapping("/manage/log")
public class ManageLogAction extends ManageBaseAction {
    @Autowired
    private LogService logService;

    @RequestMapping(value = "/listPage.htm", method = RequestMethod.GET)
    public String listPage() {
        return "manage/log/list";
    }

    @RequestMapping(value = "/list.json", method = RequestMethod.POST)
    @ResponseBody
    public PageVo<Log> list(
            @RequestParam(value = "p", defaultValue = "1") int pageNum,
            @RequestParam(value = "begin", required = false) String beginStr,
            @RequestParam(value = "end", required = false) String endStr) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            Date begin = null;
            if (!"".equals(beginStr))
                begin = sdf.parse(beginStr);
            Date end = null;
            if (!"".equals(endStr))
                end = sdf.parse(endStr);
            return logService.findAll(begin, end, pageNum, 10);
        } catch (ParseException e) {
            logger.error(e.getMessage(), e);
        }
        return null;
    }

    @ResponseBody
    @RequestMapping(value = "/clean.json", method = RequestMethod.POST)
    public void clean() {
        logService.clean();
    }

    @RequestMapping(value = "/detail.htm", method = RequestMethod.GET)
    public String detail(String id, ModelMap model) {
        Log log = logService.getById(id);
        model.put("log", log);
        return "manage/log/detail";
    }

    @RequestMapping(value = "/download/{name}", method = RequestMethod.GET)
    public String download(@PathVariable(value = "name") String name, HttpServletResponse response) {
        if (name != null&&!name.equals("")) {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            String now = format.format(new Date());
            String realPath = SystemConstant.SHISHUO_CMS_ROOT+"/WEB-INF/log/";
            File file = null;
            if(now.equals(name)){
              file = new File(realPath+"error.log");
            }else{
                file = new File(realPath+"error.log_"+name+".log");
            }
                if (file.exists()) {
                    response.setContentType("application/force-download");// 设置强制下载不打开
                    String fileName = name+".log";
                    byte[] buffer = new byte[1024];
                    FileInputStream fis = null;
                    BufferedInputStream bis = null;
                    try {
                        response.addHeader("Content-Disposition",
                                "attachment;fileName=" + fileName);// 设置文件名
                        fis = new FileInputStream(file);
                        bis = new BufferedInputStream(fis);
                        OutputStream os = response.getOutputStream();
                        int i = bis.read(buffer);
                        while (i != -1) {
                            os.write(buffer, 0, i);
                            i = bis.read(buffer);
                        }
                    } catch (Exception e) {
                        logger.error(e.getMessage(), e);
                    } finally {
                        if (bis != null) {
                            try {
                                bis.close();
                            } catch (IOException e) {
                                logger.error(e.getMessage(), e);
                            }
                        }
                        if (fis != null) {
                            try {
                                fis.close();
                            } catch (IOException e) {
                                logger.error(e.getMessage(), e);
                            }
                        }
                    }
                }
        }
        return null;
    }

}
