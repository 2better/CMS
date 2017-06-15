package com.shishuo.cms.util;

import com.shishuo.cms.constant.SystemConstant;
import com.shishuo.cms.entity.Menu;
import com.shishuo.cms.service.ConfigService;
import com.shishuo.cms.service.MenuService;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 页面静态化工具类
 *
 * @author zyl
 * @create 2017/6/12
 */

public class PageStaticUtils {
    @Autowired
    private FreeMarkerConfigurer freeMarkerConfigurer;
    @Autowired
    private MenuService menuService;
    @Autowired
    private ConfigService configService;

    private final Logger logger = Logger.getLogger(this.getClass());

    public void headerStaticPage(HttpServletRequest request) {
        String htmlPath = "/WEB-INF/static/template/blog/staticPage/header.html";
        File htmlFile = new File(request.getSession().getServletContext().getRealPath("/") + htmlPath);
        if (htmlFile.exists()) {
            logger.info("使用静态化页面");
            return;
        }
        List<Menu> menuList = menuService.getAllDisplay();
        String BASE_PATH = HttpUtils.getBasePath(request);
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("menuList", menuList);
        data.put("index_title", configService.getStringByKey("index_title"));
        data.put("seo_description", configService.getStringByKey("seo_description"));
        data.put("TEMPLATE_BASE_PATH",BASE_PATH  + "/static/template/blog");
        data.put("BASE_PATH", BASE_PATH);
        createHtml(htmlFile, "header", data);

    }

    public static void updateTemplate(String theme)
    {
        File htmlFile = new File(SystemConstant.SHISHUO_CMS_ROOT+"/WEB-INF/static/template/blog/staticPage/" + theme + ".html");
        if(htmlFile.exists())
            htmlFile.delete();
    }

    private void createHtml(File htmlFile, String theme, Map<?, ?> data) {

        Writer out = null;
        try {
            if (!htmlFile.getParentFile().exists()) {
                htmlFile.getParentFile().mkdirs();
            }
            htmlFile.createNewFile();
            out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(htmlFile), "UTF-8"));
            //获得模板
            Template template = freeMarkerConfigurer.getConfiguration().getTemplate("template/blog/" + theme + ".ftl", "utf-8");
            //生成文件（这里是我们是生成html）
            template.process(data, out);
            out.flush();
        } catch (IOException e) {
            logger.error(e);
        } catch (TemplateException e) {
            logger.error(e);
        } finally {
            try {
                if (out != null)
                    out.close();
            } catch (IOException e) {
                logger.error(e);
            }
        }
    }

}