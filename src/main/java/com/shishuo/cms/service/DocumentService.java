package com.shishuo.cms.service;

import com.shishuo.cms.constant.SystemConstant;
import com.shishuo.cms.dao.DocumentDao;
import com.shishuo.cms.entity.Document;
import com.shishuo.cms.util.MediaUtils;
import com.shishuo.cms.util.Office2PDFUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * @author zyl
 * @create 2017/5/31
 */
@Service
public class DocumentService
{
    @Autowired
    private DocumentDao documentDao;

    public Document add(MultipartFile file) throws IOException
    {
        Document document = new Document();
        document.setCreated(new Date());
        String fileName = file.getOriginalFilename();
        if (!file.isEmpty()) {
            document.setName(fileName);
            document.setPath(MediaUtils.save(file));
        }

        document.setType(fileName.substring(fileName.lastIndexOf(".")+1));
        document.setPreview(null);

        long id = documentDao.add(document);
        return documentDao.getById(id);
    }

    public List<Document> getDocList()
    {
        return documentDao.getDocList();
    }

    public Document getById(long id)
    {
       return documentDao.getById(id);
    }

    public String getPreview(long id) throws Exception {
        String filepath = "upload/preview/";
        Document document = documentDao.getById(id);
        if(document!=null)
        {
            if(document.getPreview()==null||document.getPreview().isEmpty()) {

                String pdfFile = "";
                if (!document.getType().equalsIgnoreCase("pdf")) {
                    pdfFile = filepath + new Date().getTime() + ".pdf";
                    int i = new Office2PDFUtil().office2PDF(SystemConstant.SHISHUO_CMS_ROOT + "/" +document.getPath(),SystemConstant.SHISHUO_CMS_ROOT + "/" +pdfFile);
                    if(i!=0) {
                        System.out.println(i);
                        return null;
                    }
                }else{
                    pdfFile = document.getPath();
                }

                documentDao.modifyPreviewById(document.getId(),pdfFile);

                return pdfFile;
            }else{
                return document.getPreview();
            }
        }else{
            return null;
        }
    }

    public boolean delete(long id)
    {
        Document document = documentDao.getById(id);
        if(document!=null)
        {
            String filePath = document.getPath();
            File file = new File(SystemConstant.SHISHUO_CMS_ROOT + "/" +filePath);
            if (file.exists()){
                file.delete();
            }

            String previewFilePath = document.getPreview();
            if(previewFilePath!=null&&!previewFilePath.equals(""))
            {
                File previewFile = new File(SystemConstant.SHISHUO_CMS_ROOT + "/" +previewFilePath);
                if (previewFile.exists()){
                    previewFile.delete();
                }
            }

            documentDao.delete(id);

            return true;
        }else{
            return false;
        }
    }


}
