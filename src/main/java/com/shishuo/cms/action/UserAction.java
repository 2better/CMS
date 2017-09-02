
package com.shishuo.cms.action;

import javax.servlet.http.HttpServletRequest;


import com.shishuo.cms.entity.Admin;
import com.shishuo.cms.entity.User;

import com.shishuo.cms.exception.ValidateException;
import com.shishuo.cms.service.UserService;
import com.shishuo.cms.util.SSUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import com.shishuo.cms.entity.vo.JsonVo;

import java.util.HashMap;
import java.util.Map;


/**
 * @author Herbert
 */

@Controller
@RequestMapping("/user")
public class UserAction extends BaseAction {

    @Autowired
    private UserService userService;

    @ResponseBody
    @RequestMapping(value = "/login.json", method = RequestMethod.POST)
    public Map<String, String> userLogin(HttpServletRequest request) {
        String exceptionClassName = (String) request.getAttribute("shiroLoginFailure");
        String error = "";
        if (exceptionClassName != null) {
            if (UnknownAccountException.class.getName().equals(exceptionClassName)) {
                error = "账号不存在";
            } else if (IncorrectCredentialsException.class.getName().equals(exceptionClassName)) {
                error = "用户名/密码错误";
            } else if ("randomCodeError".equals(exceptionClassName)) {
                error = "验证码错误";
            } else if ("valueError".equals(exceptionClassName)) {
                error = "用户名密码不能为空";
            } else if (ExcessiveAttemptsException.class.getName().equals(exceptionClassName)) {
                error = "密码重试次数过多,一小时后再试";
            } else {
                System.out.println(exceptionClassName);
                error = "系统繁忙,请稍后再试";
            }
        }
        Map<String, String> map = new HashMap<String, String>(2);
        map.put("error", error);
        return map;
    }

    @RequestMapping(value = "/update.htm", method = RequestMethod.GET)
    public String update(ModelMap modelMap, HttpServletRequest request) {
        User sessionUser = (User) request.getSession().getAttribute("sessionUser");
        User user = userService.getUserById(sessionUser.getUserId());
        modelMap.put("user", user);
        return "manage/user/update";
    }

    @ResponseBody
    @RequestMapping(value = "/update.json", method = RequestMethod.POST)
    public Map<String, String> updateUser(
            @RequestParam(value = "password") String password,
            @RequestParam(value = "newpwd") String newpwd,
            HttpServletRequest request) {
        String error = "";
        User sessionUser = (User) request.getSession().getAttribute("sessionUser");
       try {
           if (StringUtils.isBlank(newpwd)) {
               error = "密码不能为空";
           } else if (password.length() < 6) {
               error = "密码不能小于6位数";
           } else if (password.length() > 16) {
               error = "密码不能大于16位数";
           } else if (!userService.checkPwd(sessionUser.getUserId(), SSUtils.toText(password))) {
               error = "密码错误";
           } else {
               userService.updateUserByUserId(sessionUser.getUserId(),
                       SSUtils.toText(newpwd));
               error = "修改成功";
           }
       }catch (Exception e)
       {
           logger.error(e.getMessage(),e);
           error = "修改失败";
       }
        Map<String, String> map = new HashMap<String, String>(2);
        map.put("error", error);
        return map;
    }

    @ResponseBody
    @RequestMapping(value = "/isLogin.json", method = RequestMethod.POST)
    public boolean isLogin() {
        Subject currentUser = SecurityUtils.getSubject();
        return currentUser.isAuthenticated() || currentUser.isRemembered();
    }

    @RequestMapping(value = "/toLogin.htm", method = RequestMethod.GET)
    public String toLogin() {
        return "template/blog/login-tip";
    }

    @ResponseBody
    @RequestMapping(value = "/currentUser.json", method = RequestMethod.POST)
    public String currentUser() {
        Subject currentUser = SecurityUtils.getSubject();
        if (currentUser.getPrincipal() == null)
            return "未登录";
        else if (currentUser.getPrincipal() instanceof Admin)
            return "未登录";
        return ((User) currentUser.getPrincipal()).getName();
    }

}
