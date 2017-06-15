package com.shishuo.cms.action.manage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by labber on 2017/6/12.
 */
@Controller
@RequestMapping("/manage/result")
public class ManageResultAction extends ManageBaseAction {


    @RequestMapping(value = "/listPage.htm", method = RequestMethod.GET)
    public String listPage() {
        return "/manage/result";
    }

}
