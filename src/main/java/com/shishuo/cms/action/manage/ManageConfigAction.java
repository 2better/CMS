/*
 *	Copyright © 2013 Changsha Shishuo Network Technology Co., Ltd. All rights reserved.
 *	长沙市师说网络科技有限公司 版权所有
 *	http://www.shishuo.com
 */

package com.shishuo.cms.action.manage;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.shishuo.cms.entity.Config;
import com.shishuo.cms.service.ConfigService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shishuo.cms.constant.SystemConstant;
import com.shishuo.cms.entity.vo.JsonVo;
import com.shishuo.cms.util.SSUtils;

/**
 * 网站配置action
 *
 * @author Herbert
 */
@Controller
@RequestMapping("/manage/config")
public class ManageConfigAction extends ManageBaseAction {

    @RequestMapping(value = "/basic.htm", method = RequestMethod.GET)
    public String basic(ModelMap modelMap) {
        List<Config> configs = configService.findAll();
        modelMap.put("configs", configs);
        return "manage/config/basic";
    }

    /**
     * 修改网站配置
     *
     * @author Administrator
     */
    @ResponseBody
    @RequestMapping(value = "/basic.json", method = RequestMethod.POST)
    public JsonVo<String> basicSubmit(@RequestParam Map<String, String> map) {
        JsonVo<String> json = new JsonVo<String>();
        try {
            for (Map.Entry<String, String> entry : map.entrySet()) {
                if (StringUtils.isBlank(entry.getValue())) {
                    json.getErrors().put(entry.getKey(), "参数值不能为空");
                }
            }
            // 检测校验结果
            validate(json);
           configService.updagteConfig(map);
            json.setResult(true);
        } catch (Exception e) {
            json.setResult(false);
            json.setMsg(e.getMessage());
        }
        return json;

    }

}
