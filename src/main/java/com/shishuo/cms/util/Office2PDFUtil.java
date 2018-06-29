package com.shishuo.cms.util;

import com.aspose.words.Document;
import com.aspose.words.License;
import com.aspose.words.SaveFormat;
import org.apache.log4j.Logger;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;


public class Office2PDFUtil {

    private static Logger logger = Logger.getLogger(Office2PDFUtil.class);

    private static InputStream is = Office2PDFUtil.class.getClassLoader().getResourceAsStream("license.xml");

    /*public static boolean getLicense() {
        boolean result = false;
        try {
            //InputStream is = Office2PDFUtil.class.getClassLoader().getResourceAsStream("license.xml"); //  license.xml应放在..\WebRoot\WEB-INF\classes路径下
            License aposeLic = new License();
            aposeLic.setLicense(is);
            result = true;
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
        }
        return result;
    }*/

    public static void office2PDF(String sourceFile, String destFile) throws Exception {

        try {
            new License().setLicense(is);
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
        }

        File file = new File(destFile);  //新建一个空白pdf文档
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }
        FileOutputStream os = new FileOutputStream(file);
        Document doc = new Document(sourceFile);                    //将要被转化的word文档
        doc.save(os, SaveFormat.PDF);//全面支持DOC, DOCX, OOXML, RTF HTML, OpenDocument, PDF, EPUB, XPS, SWF 相互转换
    }
}



