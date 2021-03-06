package com.shishuo.cms.service;

import com.shishuo.cms.constant.SystemConstant;
import com.shishuo.cms.dao.DocumentDao;
import com.shishuo.cms.entity.Admin;
import com.shishuo.cms.entity.Document;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.util.IDUtils;
import com.shishuo.cms.util.MediaUtils;
import com.shishuo.cms.util.Office2PDFUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * @author zyl
 * @create 2017/5/31
 */
@Service
public class DocumentService {
    @Autowired
    private DocumentDao documentDao;

    @CacheEvict(value = "document", allEntries = true)
    public void add(MultipartFile file, Admin admin, int column) throws IOException {
        Document document = new Document();
        document.setId(IDUtils.getId());
        document.setCreated(new Date());
        document.setColumn(column);
        String fileName = file.getOriginalFilename();
        if (!file.isEmpty()) {
            document.setName(fileName);
            document.setPath(MediaUtils.save(file));
        }

        document.setType(fileName.substring(fileName.lastIndexOf(".") + 1));
        document.setPreview(null);
        document.setAdminId(admin.getAdminId());
        document.setAdminName(admin.getName());

        documentDao.add(document);
    }

    public Document getById(long id) {
        return documentDao.getById(id);
    }

    public String getPreview(long id) throws Exception {
        String filepath = "upload"+File.separator+"preview"+File.separator;
        Document document = documentDao.getById(id);
        if (document != null) {
            if (document.getPreview() == null || document.getPreview().isEmpty()) {

                String pdfFile = "";
                if (!document.getType().equalsIgnoreCase("pdf")) {
                    pdfFile = filepath + new Date().getTime() + ".pdf";
                    new Office2PDFUtil().office2PDF(SystemConstant.SHISHUO_CMS_ROOT + File.separator + document.getPath(), SystemConstant.SHISHUO_CMS_ROOT + File.separator + pdfFile);
                    pdfFile = pdfFile.replace("\\","/");
                } else {
                    pdfFile = document.getPath();
                }

                documentDao.modifyPreviewById(document.getId(), pdfFile);

                return pdfFile;
            } else {
                return document.getPreview();
            }
        } else {
            throw new FileNotFoundException();
        }
    }

    @CacheEvict(value = "document", allEntries = true)
    public boolean delete(long id) {
        Document document = documentDao.getById(id);
        if (document != null) {
            String filePath = document.getPath();
            File file = new File(SystemConstant.SHISHUO_CMS_ROOT + File.separator + filePath);
            if (file.exists()) {
                file.delete();
            }

            String previewFilePath = document.getPreview();
            if (previewFilePath != null && !previewFilePath.equals("")) {
                File previewFile = new File(SystemConstant.SHISHUO_CMS_ROOT + File.separator + previewFilePath);
                if (previewFile.exists()) {
                    previewFile.delete();
                }
            }

            documentDao.delete(id);

            return true;
        } else {
            return false;
        }
    }

    public PageVo<Document> findByCondition(long adminId, String keywords, int column, int pageNum, int rows) {
        PageVo<Document> pageVo = new PageVo<Document>(pageNum);
        pageVo.setRows(rows);
        pageVo.setCount(documentDao.allCountByCondition(adminId, keywords, column));
        List<Document> articlelist = documentDao.findByCondition(adminId, keywords, column, pageVo.getOffset(), rows);
        pageVo.setList(articlelist);
        return pageVo;
    }

    public int allCountByCondition(long adminId, String keywords, int column) {
        return documentDao.allCountByCondition(adminId, keywords, column);
    }

    public List<Document> findByColumn(int column, int pageNum, int rows) {
        return documentDao.findByColumn(column, (pageNum - 1) * rows, rows);
    }

    @Cacheable(value = "document", key = "#column")
    public int getCountByColumn(int column) {
        return documentDao.getCountByColumn(column);
    }

    public int getPageCount(int count, int rows) {
        return (count + rows - 1) / rows;
    }

    //根据类别查询
    public List<Document> getBy_Column(int column, int offset, int rows) {
        return documentDao.getBy_Column(column, offset, rows);
    }

    public int getAllCount()
    {
        return documentDao.getAllCount();
    }

}
