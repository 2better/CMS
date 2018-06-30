
package com.shishuo.cms.action;

import com.shishuo.cms.exception.TemplateNotFoundException;
import com.shishuo.cms.service.ConfigService;
import com.shishuo.cms.service.PictureService;
import com.shishuo.cms.util.PageStaticUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

/**
 * 首页
 * 
 * @author Herbert
 */
@Controller
public class IndexAction extends BaseAction {

	@Autowired
	private PageStaticUtils pageStaticUtils;
	@Autowired
	private PictureService pictureService;
	@Autowired
	private ConfigService configService;

	/**
	 * 首页
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String defalut(HttpServletRequest request,ModelMap m) {
		return home(request,m);
	}

	/**
	 * 首页
	 *
	 * @return
	 */
	@RequestMapping(value = "/index.htm", method = RequestMethod.GET)
	public String home(HttpServletRequest request,ModelMap m) {
		try {
			pageStaticUtils.headerAndFooterStaticPage(request);
			m.put("pic",pictureService.getAllByType(2));
			m.put("introduction", configService.getStringByKey("brief_introduction"));
			return themeService.getDefaultTemplate();
		} catch (TemplateNotFoundException e) {
			logger.error(e.getMessage(),e);
			return themeService.get404();
		}
	}

	/**
	 * 404
	 * 
	 * @return
	 */
	@RequestMapping(value = "/404.htm", method = RequestMethod.GET)
	public String pageNotFound() {
		return themeService.get404();
	}

	/**
	 * 500
	 * 
	 * @return
	 */
	@RequestMapping(value = "/500.htm", method = RequestMethod.GET)
	public String error() {
		return themeService.get500();
	}

	/**
	 * refuse
	 *
	 * @return
	 */
	@RequestMapping(value = "/refuse.htm", method = RequestMethod.GET)
	public String refuse() {
		return themeService.getRefuse();
	}
}
