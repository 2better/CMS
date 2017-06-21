package com.shishuo.cms.action.manage;


import com.shishuo.cms.service.DocumentService;
import com.shishuo.cms.service.EventService;
import com.shishuo.cms.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author lqq
 * @author 进入网站后台首页
 */

@Controller
@RequestMapping("/manage")
public class ManageAction extends ManageBaseAction {

    @Autowired
    private UserService userService;
    @Autowired
    private DocumentService documentService;
    @Autowired
    private EventService eventService;

    @RequestMapping(value = "/index.htm", method = RequestMethod.GET)
    public String index(ModelMap modelMap) {

        modelMap.put("articleCount", articleService.getAllCount());
        modelMap.put("documentCount",documentService.getAllCount());
        modelMap.put("eventCount", eventService.getAllCount());
        modelMap.put("userCount",userService.getAllCount());
        modelMap.put("eventTop10",eventService.getTop10());
        modelMap.put("articleTop10",articleService.getTop10());

        return "manage/index";
    }

}
