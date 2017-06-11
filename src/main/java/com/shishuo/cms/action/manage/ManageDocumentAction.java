package com.shishuo.cms.action.manage;

import com.shishuo.cms.constant.SystemConstant;
import com.shishuo.cms.entity.Admin;
import com.shishuo.cms.entity.Document;
import com.shishuo.cms.entity.vo.JsonVo;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.exception.UploadException;
import com.shishuo.cms.service.ConfigService;
import com.shishuo.cms.service.DocumentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.ConnectException;
import java.util.List;

/**
 * @author zyl
 * @create 2017/5/31
 */
@Controller
@RequestMapping("/manage/preview")
public class ManageDocumentAction {
    @Autowired
    private DocumentService documentService;
    @Autowired
    private ConfigService configService;

    @RequestMapping(value = "/listPage.htm", method = RequestMethod.GET)
    public String listPage(HttpServletRequest request, ModelMap modelMap) {
        int count = documentService.allCountByCondition(-1, "");
        modelMap.put("count", count);

        return "manage/preview/list";
    }

    @RequestMapping(value = "/list.json", method = RequestMethod.POST)
    @ResponseBody
    public PageVo<Document> list(
            @RequestParam(value = "p", defaultValue = "1") int pageNum,
            @RequestParam(value = "adminId", defaultValue = "-1") long adminId,
            @RequestParam(value = "keywords", defaultValue = "") String keywords) {
        int num = configService.getIntKey("pagination_num");
        PageVo<Document> pageVo = documentService.findByCondition(adminId, keywords, pageNum, num);
        return pageVo;
    }

    @RequestMapping(value = "/add.htm", method = RequestMethod.GET)
    public String add() {
        return "manage/preview/add";
    }

    @ResponseBody
    @RequestMapping(value = "/add.json", method = RequestMethod.POST)
    public JsonVo<Document> add(HttpServletRequest request,
                                @RequestParam(value = "file", required = false) MultipartFile file)
            throws UploadException {
        JsonVo<Document> json = new JsonVo<Document>();
        try {
            documentService.add(file, (Admin) request.getSession().getAttribute(SystemConstant.SESSION_ADMIN));
            json.setResult(true);
            return json;
        } catch (IOException e) {
            e.printStackTrace();
            json.setResult(false);
            return json;
        }
    }

    /**
     * 文件下载
     *
     * @param response
     * @return
     * @Description:
     */
    @RequestMapping(value = "/download.htm", method = RequestMethod.GET)
    public String downloadFile(@RequestParam("id") Long id, HttpServletResponse response) {
        if (id != null) {
            Document document = documentService.getById(id);
            if (document != null) {
                String realPath = SystemConstant.SHISHUO_CMS_ROOT + "/" + document.getPath();
                File file = new File(realPath);
                if (file.exists()) {
                    response.setContentType("application/force-download");// 设置强制下载不打开
                    response.addHeader("Content-Disposition",
                            "attachment;fileName=" + document.getName());// 设置文件名
                    byte[] buffer = new byte[1024];
                    FileInputStream fis = null;
                    BufferedInputStream bis = null;
                    try {
                        fis = new FileInputStream(file);
                        bis = new BufferedInputStream(fis);
                        OutputStream os = response.getOutputStream();
                        int i = bis.read(buffer);
                        while (i != -1) {
                            os.write(buffer, 0, i);
                            i = bis.read(buffer);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (bis != null) {
                            try {
                                bis.close();
                            } catch (IOException e) {
                                e.printStackTrace();
                            }
                        }
                        if (fis != null) {
                            try {
                                fis.close();
                            } catch (IOException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                }
            }
        }
        return null;
    }


    @RequestMapping(value = "/previewPage.htm", method = RequestMethod.GET)
    public String previewPage(@RequestParam(value = "pdfFilePath") String pdfFilePath, ModelMap modelmap) {
        modelmap.put("pdfFilePath", pdfFilePath);
        return "manage/preview/preview";
    }

    @ResponseBody
    @RequestMapping(value = "/preview.json", method = RequestMethod.POST)
    public JsonVo<String> preview(@RequestParam(value = "id") Long id) {
        JsonVo<String> json = new JsonVo<String>();
        if (id != null) {
            try {
                String pdfFilePath = documentService.getPreview(id);
                json.setResult(true);
                json.setT(pdfFilePath);
            } catch (FileNotFoundException e) {
                json.setResult(false);
                json.setMsg("找不到该文档");
            } catch (ConnectException e) {
                e.printStackTrace();
                json.setResult(false);
                json.setMsg("系统繁忙，请重试");
            } catch (Exception e) {
                e.printStackTrace();
                json.setResult(false);
                json.setMsg("系统繁忙，请重试");
            }
        }else {
            json.setResult(false);
            json.setMsg("找不到该文档");
        }
        return json;

    }

    @ResponseBody
    @RequestMapping(value = "/delete.json", method = RequestMethod.POST)
    public JsonVo<String> deleteFile(
            @RequestParam(value = "id") long id) {
        JsonVo<String> json = new JsonVo<String>();
        // 删除文件系统
        boolean b = documentService.delete(id);

        json.setResult(b);
        return json;
    }

}