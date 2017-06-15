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

public class AdminFormAuthenticationFilter extends FormAuthenticationFilter
{

    protected boolean onAccessDenied(ServletRequest request,
                                     ServletResponse response, Object mappedValue) throws Exception {

        // 校验验证码
        // 从session获取正确的验证码
        HttpSession session = ((HttpServletRequest)request).getSession();
        //页面输入的验证码
        String captcha = request.getParameter("captcha");
        //从session中取出验证码
        String kaptcha = (String) session.getAttribute(
                com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
        if (StringUtils.isBlank(captcha)||!captcha.equalsIgnoreCase(kaptcha)) {
            // randomCodeError表示验证码错误
            request.setAttribute("shiroLoginFailure", "randomCodeError");
            //拒绝访问，不再校验账号和密码
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
        httpServletRequest.getSession().setAttribute("SESSION_ADMIN",subject.getPrincipal());
        WebUtils.redirectToSavedRequest(request,response,"/manage/index.htm");
        return false;
    }
    @Override
    protected AuthenticationToken createToken(ServletRequest request, ServletResponse response) {
        String username = getUsername(request);
        String password = getPassword(request);
        String host = request.getRemoteHost();
        return new AdminToken(username, password, false, host);
    }

}
