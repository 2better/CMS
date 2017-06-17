
package com.shishuo.cms.action;

import java.awt.image.BufferedImage;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shishuo.cms.entity.User;
import com.shishuo.cms.entity.User;
import com.shishuo.cms.exception.ValidateException;
import com.shishuo.cms.service.UserService;
import com.shishuo.cms.util.SSUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
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
import com.shishuo.cms.service.UserService;
import com.shishuo.cms.util.HttpUtils;

/**
 * @author Herbert
 */

@Controller
@RequestMapping("/user")
public class UserAction extends BaseAction {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/login.htm", method = RequestMethod.GET)
    public String login() {
        return "/manage/user/login";
    }

    @RequestMapping(value = "/login.json", method = RequestMethod.POST)
    public String userLogin(@RequestParam(value = "name") String name,
                             @RequestParam(value = "password") String password, ModelMap
                                     modelMap, HttpServletRequest request) {
        String exceptionClassName = (String) request.getAttribute("shiroLoginFailure");
        if (UnknownAccountException.class.getName().equals(exceptionClassName)) {
            modelMap.put("error", "账号不存在");
        } else if (IncorrectCredentialsException.class.getName().equals(exceptionClassName)) {
            modelMap.put("error", "用户名/密码错误");
        } else if ("randomCodeError".equals(exceptionClassName)) {
            modelMap.put("error", "验证码错误");
        } else if ("valueError".equals(exceptionClassName)) {
            modelMap.put("error", "用户名密码不能为空");
        } else if (ExcessiveAttemptsException.class.getName().equals(exceptionClassName)) {
            modelMap.put("error", "密码重试次数过多");
        } else {
            System.out.println(exceptionClassName);
            modelMap.put("error", "系统繁忙,请稍后再试");
        }
        modelMap.put("name",name);
        modelMap.put("password",password);
        return login();
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
    public JsonVo<String> updateUser(
            @RequestParam(value = "password") String password,
            HttpServletRequest request) {
        JsonVo<String> json = new JsonVo<String>();
        try {
            if (StringUtils.isBlank(password)) {
                json.getErrors().put("password", "密码不能为空");
            }
            if (password.length() < 6) {
                json.getErrors().put("password", "密码不能小于6位数");
            }
            if (password.length() > 16) {
                json.getErrors().put("password", "密码不能大于18位数");
            }
            
            if (json.getErrors().size() > 0) {
                json.setResult(false);
                throw new ValidateException("有错误发生");
            } else {
                json.setResult(true);
            }
            SSUtils.toText(password);
            User sessionUser = (User) request.getSession().getAttribute("sessionUser");
            userService.updateUserByUserId(sessionUser.getUserId(),
                    SSUtils.toText(password));
            json.setResult(true);
        } catch (Exception e) {
            json.setResult(false);
            json.setMsg(e.getMessage());
        }
        return json;
    }

}
