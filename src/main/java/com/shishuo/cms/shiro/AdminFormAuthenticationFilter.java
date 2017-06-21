package com.shishuo.cms.shiro;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;

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

    private String readLoginUrl;

    @Override
    protected boolean isLoginRequest(ServletRequest request, ServletResponse response) {
        return pathsMatch(getReadLoginUrl(), request);
    }

    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
        if (isLoginRequest(request, response)) {
            HttpSession session = ((HttpServletRequest)request).getSession();
            String captcha = request.getParameter("captcha");
            String kaptcha = (String) session.getAttribute(
                    com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
            /*if (StringUtils.isBlank(captcha)||!captcha.equalsIgnoreCase(kaptcha)) {
                // randomCodeError表示验证码错误
                request.setAttribute("shiroLoginFailure", "randomCodeError");
                //拒绝访问，不再校验账号和密码
                return true;
            }*/
            String password = request.getParameter("password");
            String name = request.getParameter("name");
            if (StringUtils.isBlank(name)||StringUtils.isBlank(password) || password.length() < 6) {
                request.setAttribute("shiroLoginFailure", "valueError");
                return true;
            }

            if (isLoginSubmission(request, response)) {
                return executeLogin(request, response);
            } else {
                return true;
            }
        } else {
            saveRequestAndRedirectToLogin(request, response);
            return false;
        }
    }

    protected boolean onLoginSuccess(AuthenticationToken token, Subject subject,
                                     ServletRequest request, ServletResponse response) throws Exception {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        httpServletRequest.getSession().setAttribute("SESSION_ADMIN",subject.getPrincipal());
        issueSuccessRedirect(request, response);
        return false;
    }

    @Override
    protected AuthenticationToken createToken(ServletRequest request, ServletResponse response) {
        String username = getUsername(request);
        String password = getPassword(request);
        String host = request.getRemoteHost();
        return new AdminToken(username, password, false, host);
    }

    public String getReadLoginUrl() {
        return readLoginUrl;
    }

    public void setReadLoginUrl(String readLoginUrl) {
        this.readLoginUrl = readLoginUrl;
    }
}
