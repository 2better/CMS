package com.shishuo.cms.shiro;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.apache.shiro.web.util.WebUtils;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

/**
 * @author zyl
 * @create 2017/6/13
 */

public class UserLogin extends AccessControlFilter {

    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
        return false;
    }

    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
        // 获取当前网页地址
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        httpServletRequest.getRequestURI();
        Subject subject = getSubject(request, response);
        if (!subject.isAuthenticated() && !subject.isRemembered()) {
            WebUtils.issueRedirect(request, response, getLoginUrl());
            return false;
        }
        return true;
    }
}
