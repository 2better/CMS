package com.shishuo.cms.shiro;

import com.shishuo.cms.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.beans.factory.annotation.Autowired;

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

public class UserFormAuthenticationFilter  extends FormAuthenticationFilter
{
    @Autowired
    private UserService userService;

    private String readLoginUrl;


    @Override
    protected boolean isLoginRequest(ServletRequest request, ServletResponse response) {
        return pathsMatch(getReadLoginUrl(), request);
    }

    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
        if (isLoginRequest(request, response)) {

            HttpSession session = ((HttpServletRequest)request).getSession();
            String captcha = request.getParameter("captcha");
            String kaptcha = (String) session.getAttribute("captcha");
            if (StringUtils.isBlank(captcha)||!captcha.equalsIgnoreCase(kaptcha)) {
                request.setAttribute("shiroLoginFailure", "randomCodeError");
                return true;
            }
            String password = request.getParameter("password");
            String name = request.getParameter("name");

            if (StringUtils.isBlank(name)||StringUtils.isBlank(password)) {
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
        httpServletRequest.getSession().setAttribute("sessionUser",subject.getPrincipal());
        issueSuccessRedirect(request, response);
        return false;
    }

    @Override
    protected AuthenticationToken createToken(ServletRequest request, ServletResponse response) {
        String username = getUsername(request);
        String password = getPassword(request);
        boolean rememberMe = isRememberMe(request);
        String host = getHost(request);
        return new UserToken(username, password, rememberMe, host);
    }

    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {

        Subject subject = this.getSubject(request, response);
        if (isLoginRequest(request, response))
        {
            if (isLoginSubmission(request, response))
            {
                if (subject.getPrincipal() != null)
                {
                    subject.logout();
                }
            }
        }

        if(!subject.isAuthenticated() && subject.isRemembered()){
            Session session = subject.getSession(true);
            if(session.getAttribute("sessionUser") == null){
                String username = subject.getPrincipal().toString();
                session.setAttribute("sessionUser",userService.getUserByName(username));
            }
        }
        return subject.isAuthenticated() || subject.isRemembered();
    }


    public String getReadLoginUrl() {
        return readLoginUrl;
    }

    public void setReadLoginUrl(String readLoginUrl) {
        this.readLoginUrl = readLoginUrl;
    }
}
