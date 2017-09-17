package com.shishuo.cms.util;

import com.shishuo.cms.constant.SystemConstant;
import com.shishuo.cms.entity.Article;
import com.shishuo.cms.entity.Menu;
import com.shishuo.cms.exception.ArticleNotFoundException;
import com.shishuo.cms.service.*;
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
    @Autowired
    private FriendlylinkService friendlylinkService;
    @Autowired
    private PictureService pictureService;
    @Autowired
    protected ArticleService fileService;

    private static String basePath = File.separator+"WEB-INF"+File.separator+"static"+File.separator+"template"+File.separator+"blog"+File.separator+"staticPage"+File.separator;
    private static String basePath1 = File.separator+"WEB-INF"+File.separator+"static"+File.separator+"template"+File.separator+"blog"+File.separator+"article"+File.separator;

    private final Logger logger = Logger.getLogger(this.getClass());

    public void headerAndFooterStaticPage(HttpServletRequest request) {

        String headerHtmlPath = basePath+"header.html";
        String footerHtmlPath = basePath+"footer.html";
        String root = request.getSession().getServletContext().getRealPath("/");
        File headerHtmlFile = new File(root + headerHtmlPath);
        File footerHtmlFile = new File(root + footerHtmlPath);
        if (!headerHtmlFile.exists()) {
            List<Menu> menuList = menuService.getAllDisplay();
            String BASE_PATH = HttpUtils.getBasePath(request);
            Map<String, Object> data = new HashMap<String, Object>();
            data.put("menuList", menuList);
            data.put("index_title", configService.getStringByKey("index_title"));
            data.put("seo_description", configService.getStringByKey("seo_description"));
            data.put("TEMPLATE_BASE_PATH", BASE_PATH + File.separator+"static"+File.separator+"template"+File.separator+"blog");
            data.put("BASE_PATH", BASE_PATH);
            //加载轮播图
            data.put("pictures", pictureService.getAllByType(1));
            //小图
            data.put("pics", pictureService.getAllByType(0));
            createHtml(headerHtmlFile, "header", data);
        }
        if (!footerHtmlFile.exists()) {
            Map<String, Object> data = new HashMap<String, Object>();
            data.put("linkList", friendlylinkService.getAllDisplay());
            data.put("copyright", configService.getStringByKey("copyright"));
            data.put("phonenum", configService.getStringByKey("phonenum"));
            createHtml(footerHtmlFile, "footer", data);
        }

        logger.info("页面静态化");
    }

    public static void updateTemplate(String theme) {
        File htmlFile = new File(SystemConstant.SHISHUO_CMS_ROOT + basePath + theme + ".html");
        if (htmlFile.exists())
            htmlFile.delete();
    }

    public static void updateArticleTemplate(String theme) {
        File htmlFile = new File(SystemConstant.SHISHUO_CMS_ROOT + basePath1 + theme + ".html");
        if (htmlFile.exists())
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
            Template template = freeMarkerConfigurer.getConfiguration().getTemplate("template"+File.separator+"blog"+File.separator + theme + ".ftl", "utf-8");
            //生成文件（这里是我们是生成html）
            template.process(data, out);
            out.flush();
        } catch (IOException e) {
            logger.error(e.getMessage(),e);
        } catch (TemplateException e) {
            logger.error(e.getMessage(),e);
        } finally {
            try {
                if (out != null)
                    out.close();
            } catch (IOException e) {
                logger.error(e.getMessage(),e);
            }
        }
    }

    //文章静态化
    public void articleStaticPage(HttpServletRequest request, Long articleId) throws ArticleNotFoundException {
        String articleHtml = basePath1 + articleId + ".html";
        String root = request.getSession().getServletContext().getRealPath("/");
        File articleHtmlFile = new File(root + articleHtml);
        if (!articleHtmlFile.exists()) {
            Map<String, Object> data = new HashMap<String, Object>();
            Article article = fileService.getArticleById(articleId);
            Menu menus = null;
            if(article.getMenu().getPid()!=0)
                menus = menuService.getWithChildById(article.getMenu().getPid());
            data.put("menus", menus);
            data.put("article", article);
            createHtml(articleHtmlFile, "article" + "", data);
        }
    }
}