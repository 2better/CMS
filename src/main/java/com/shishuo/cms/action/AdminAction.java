/*
 *	Copyright © 2013 Changsha Shishuo Network Technology Co., Ltd. All rights reserved.
 *	长沙市师说网络科技有限公司 版权所有
 *	http://www.shishuo.com
 */

package com.shishuo.cms.action;

import java.awt.image.BufferedImage;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.shishuo.cms.constant.SystemConstant;
import com.shishuo.cms.entity.vo.JsonVo;
import com.shishuo.cms.service.AdminService;
import com.shishuo.cms.util.HttpUtils;

/**
 * @author Herbert
 */

@Controller
@RequestMapping("/admin")
public class AdminAction extends BaseAction {

    /**
     * Kaptcha 验证码
     */
    @Autowired
    private DefaultKaptcha captchaProducer;

    @RequestMapping(value = "/login.htm", method = RequestMethod.GET)
    public String login() {
        return "/manage/login";
    }

    @RequestMapping(value = "/login.json", method = RequestMethod.POST)
    public String adminLogin(@RequestParam(value = "name") String name,
                             @RequestParam(value = "password") String password, ModelMap
                                     modelMap, HttpServletRequest request) {
        String exceptionClassName = (String) request.getAttribute("shiroLoginFailure");
        if(exceptionClassName!=null) {
            if (UnknownAccountException.class.getName().equals(exceptionClassName)) {
                modelMap.put("error", "账号不存在");
            } else if (IncorrectCredentialsException.class.getName().equals(exceptionClassName)) {
                modelMap.put("error", "用户名/密码错误");
            } else if ("randomCodeError".equals(exceptionClassName)) {
                modelMap.put("error", "验证码错误");
            } else if ("valueError".equals(exceptionClassName)) {
                modelMap.put("error", "用户名密码不能为空");
            } else if (ExcessiveAttemptsException.class.getName().equals(exceptionClassName)) {
                modelMap.put("error", "密码重试次数过多,一小时后再试");
            } else {
                System.out.println(exceptionClassName);
                modelMap.put("error", "系统繁忙,请稍后再试");
            }
        }
        modelMap.put("name",name);
        modelMap.put("password",password);
        return login();
    }

    /**
     * 生成验证码
     *
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "captcha.htm", method = RequestMethod.GET)
    public void captcha(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        response.setDateHeader("Expires", 0);
        response.setHeader("Cache-Control",
                "no-store, no-cache, must-revalidate");
        response.addHeader("Cache-Control", "post-check=0, pre-check=0");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("image/jpeg");
        String capText = captchaProducer.createText();
        request.getSession().setAttribute(
                com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY, capText);
        BufferedImage bi = captchaProducer.createImage(capText);
        ServletOutputStream out = response.getOutputStream();
        ImageIO.write(bi, "jpg", out);
        try {
            out.flush();
        } finally {
            out.close();
        }
    }
}
