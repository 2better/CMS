package com.shishuo.cms.shiro;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * 自定义FormAuthenticationFilter
 *
 * @author zyl
 * @create 2016/11/24
 */

public class UserFormAuthenticationFilter extends FormAuthenticationFilter
{

    protected boolean onAccessDenied(ServletRequest request,
                                     ServletResponse response, Object mappedValue) throws Exception {


        HttpSession session = ((HttpServletRequest)request).getSession();
        String captcha = request.getParameter("captcha");
        String kaptcha = (String) session.getAttribute(
                com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
        if (StringUtils.isBlank(captcha)||!captcha.equalsIgnoreCase(kaptcha)) {
            request.setAttribute("shiroLoginFailure", "randomCodeError");
            return true;
        }
        String password = request.getParameter("password");
        String name = request.getParameter("name");

        if (StringUtils.isBlank(name)||StringUtils.isBlank(password) || password.length() < 6) {
            request.setAttribute("shiroLoginFailure", "valueError");
            return true;
        }

        return super.onAccessDenied(request, response, mappedValue);
    }

    @Override
    protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request, ServletResponse response) throws Exception {
        WebUtils.getAndClearSavedRequest(request);
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        httpServletRequest.getSession().setAttribute("sessionUser",subject.getPrincipal());
        WebUtils.redirectToSavedRequest(request,response,"/index.htm");
        return false;
    }

}
