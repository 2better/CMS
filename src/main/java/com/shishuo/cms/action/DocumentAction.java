package com.shishuo.cms.action;

import com.shishuo.cms.action.manage.ManageDocumentAction;
import com.shishuo.cms.constant.SystemConstant;
import com.shishuo.cms.entity.Document;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.service.ConfigService;
import com.shishuo.cms.service.DocumentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by labber on 2017/6/12.
 */
@Controller
@RequestMapping("/paper")
public class DocumentAction extends BaseAction{

    @Autowired
    private DocumentService documentService ;
    @Autowired
    private ConfigService configService;

    @RequestMapping(value = "/download/{id}", method = RequestMethod.GET)
    public String download(@PathVariable(value = "id") Long id, HttpServletResponse response) {
        if (id != null) {
            Document document = documentService.getById(id);
            if (document != null) {
                String realPath = SystemConstant.SHISHUO_CMS_ROOT + "/" + document.getPath();
                File file = new File(realPath);
                if (file.exists()) {
                    response.setContentType("application/force-download");// 设置强制下载不打开
                    String fileName = document.getName();
                    byte[] buffer = new byte[1024];
                    FileInputStream fis = null;
                    BufferedInputStream bis = null;
                    try {
                        response.addHeader("Content-Disposition",
                                "attachment;fileName=" + URLEncoder.encode(fileName,"utf-8"));// 设置文件名
                        fis = new FileInputStream(file);
                        bis = new BufferedInputStream(fis);
                        OutputStream os = response.getOutputStream();
                        int i = bis.read(buffer);
                        while (i != -1) {
                            os.write(buffer, 0, i);
                            i = bis.read(buffer);
                        }
                    } catch (Exception e) {
                        logger.error(e.getMessage(),e);
                    } finally {
                        if (bis != null) {
                            try {
                                bis.close();
                            } catch (IOException e) {
                                logger.error(e.getMessage(),e);
                            }
                        }
                        if (fis != null) {
                            try {
                                fis.close();
                            } catch (IOException e) {
                                logger.error(e.getMessage(),e);
                            }
                        }
                    }
                }
            }
        }
        return null;
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public List<Document> getPapers() {
        return documentService.getBy_Column(2,0,6);
    }


    @RequestMapping("/thinkTtank.htm")
    public String thinkTtankPage(ModelMap modelMap, HttpServletRequest request)
    {
        return documentPage(modelMap,request,1);
    }

    //学术论文列表
    @RequestMapping("/scholar.htm")
    public String scholarPage(ModelMap modelMap, HttpServletRequest request)
    {
        return documentPage(modelMap,request,2);
    }

    @ResponseBody
    @RequestMapping(value="/thinkTtank.json",method = RequestMethod.POST)
    public Map<String,Object> think_tank(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum
                    ,@RequestParam(value = "column", defaultValue = "1") int column) {
        Map<String,Object> map = new HashMap<String,Object>();
        int rows = configService.getIntKey("pagination_num");
        map.put("list",documentService.findByColumn(column, pageNum, rows));
        map.put("pageNum",pageNum);
        return map;
    }

    @ResponseBody
    @RequestMapping(value="/scholar.json",method = RequestMethod.POST)
    public Map<String,Object> scholarList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
        Map<String,Object> map = new HashMap<String,Object>();
        int rows = configService.getIntKey("pagination_num");
        map.put("list",documentService.findByColumn(2, pageNum, rows));
        map.put("pageNum",pageNum);
        return map;
    }

    //封装一下下这个方法
    private String documentPage(ModelMap modelMap, HttpServletRequest request,int column) {
        int count = documentService.getCountByColumn(column);
        int rows = configService.getIntKey("pagination_num");
        int pageCount = documentService.getPageCount(count,rows);

        modelMap.put("count",count);
        modelMap.put("pageCount",pageCount);
        pageStaticUtils.headerAndFooterStaticPage(request);
        String page = "document_list";
        if(column == 2) {
            page = "scholar_download_list";
        }
        return "template/blog/" + page;
    }
}
