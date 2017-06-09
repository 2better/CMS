package com.shishuo.cms.action.manage;

import com.shishuo.cms.constant.SystemConstant;
import com.shishuo.cms.entity.Document;
import com.shishuo.cms.entity.vo.JsonVo;
import com.shishuo.cms.exception.UploadException;
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
import java.util.List;

/**
 * @author zyl
 * @create 2017/5/31
 */
@Controller
@RequestMapping("/manage/preview")
public class ManagePreviewAction {
    @Autowired
    private DocumentService documentService;

    @RequestMapping(value = "/list.htm", method = RequestMethod.GET)
    public String list(HttpServletRequest request, ModelMap modelMap) {
        List<Document> list = documentService.getDocList();
        modelMap.put("list", list);

        return "manage/preview/list";
    }

    @RequestMapping(value = "/add.htm", method = RequestMethod.GET)
    public String add() {
        return "manage/preview/add";
    }

    @ResponseBody
    @RequestMapping(value = "/add.json", method = RequestMethod.POST)
    public JsonVo<Document> add(
            @RequestParam(value = "file", required = false) MultipartFile file)
            throws UploadException {
        JsonVo<Document> json = new JsonVo<Document>();
        try {
            Document document = documentService.add(file);
            json.setT(document);
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
    public String downloadFile(@RequestParam("id") Long id,HttpServletResponse response) {
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


    @RequestMapping(value = "/preview.htm", method = RequestMethod.GET)
    public String preview(@RequestParam(value = "id") Long id, ModelMap modelmap) throws Exception {
        if(id!=null) {
            String pdfFilePath = documentService.getPreview(id);
            modelmap.put("pdfFilePath",pdfFilePath);
            return "manage/preview/preview";
        }
        return null;
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