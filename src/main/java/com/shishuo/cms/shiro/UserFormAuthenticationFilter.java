package com.shishuo.cms.shiro;

import com.shishuo.cms.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.AuthenticatingFilter;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

public class UserFormAuthenticationFilter  extends AuthenticatingFilter
{
    @Autowired
    private UserService userService;

    public static final String DEFAULT_ERROR_KEY_ATTRIBUTE_NAME = "shiroLoginFailure";

    public static final String DEFAULT_USERNAME_PARAM = "username";
    public static final String DEFAULT_PASSWORD_PARAM = "password";
    public static final String DEFAULT_REMEMBER_ME_PARAM = "rememberMe";

    private static final Logger log = LoggerFactory.getLogger(UserFormAuthenticationFilter.class);

    private String usernameParam = DEFAULT_USERNAME_PARAM;
    private String passwordParam = DEFAULT_PASSWORD_PARAM;
    private String rememberMeParam = DEFAULT_REMEMBER_ME_PARAM;
    private String readLoginUrl;

    private String failureKeyAttribute = DEFAULT_ERROR_KEY_ATTRIBUTE_NAME;

    public UserFormAuthenticationFilter() {
        setLoginUrl(DEFAULT_LOGIN_URL);
    }

    public String getUsernameParam() {
        return usernameParam;
    }

    public void setUsernameParam(String usernameParam) {
        this.usernameParam = usernameParam;
    }

    public String getPasswordParam() {
        return passwordParam;
    }

    public void setPasswordParam(String passwordParam) {
        this.passwordParam = passwordParam;
    }

    public String getRememberMeParam() {
        return rememberMeParam;
    }

    public void setRememberMeParam(String rememberMeParam) {
        this.rememberMeParam = rememberMeParam;
    }

    public String getFailureKeyAttribute() {
        return failureKeyAttribute;
    }

    public void setFailureKeyAttribute(String failureKeyAttribute) {
        this.failureKeyAttribute = failureKeyAttribute;
    }

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


            if (isLoginSubmission(request, response)) {
                if (log.isTraceEnabled()) {
                    log.trace("Login submission detected.  Attempting to execute login.");
                }
                return executeLogin(request, response);
            } else {
                if (log.isTraceEnabled()) {
                    log.trace("Login page view.");
                }
                //allow them to see the login page ;)
                return true;
            }
        } else {
            if (log.isTraceEnabled()) {
                log.trace("Attempting to access a path which requires authentication.  Forwarding to the " +
                        "Authentication url [" + getLoginUrl() + "]");
            }
            saveRequestAndRedirectToLogin(request, response);
            return false;
        }
    }

    @SuppressWarnings({"UnusedDeclaration"})
    protected boolean isLoginSubmission(ServletRequest request, ServletResponse response) {
        return (request instanceof HttpServletRequest) && WebUtils.toHttp(request).getMethod().equalsIgnoreCase(POST_METHOD);
    }

    protected boolean isRememberMe(ServletRequest request) {
        return WebUtils.isTrue(request, getRememberMeParam());
    }

    protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e,
                                     ServletRequest request, ServletResponse response) {
        setFailureAttribute(request, e);
        //login failed, let request continue back to the login page:
        return true;
    }

    protected void setFailureAttribute(ServletRequest request, AuthenticationException ae) {
        String className = ae.getClass().getName();
        request.setAttribute(getFailureKeyAttribute(), className);
    }

    protected String getUsername(ServletRequest request) {
        return WebUtils.getCleanParam(request, getUsernameParam());
    }

    protected String getPassword(ServletRequest request) {
        return WebUtils.getCleanParam(request, getPasswordParam());
    }

    /*protected boolean onAccessDenied(ServletRequest request,
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
    }*/

    /*@Override
    protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request, ServletResponse response) throws Exception {
        WebUtils.getAndClearSavedRequest(request);
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        httpServletRequest.getSession().setAttribute("sessionUser",subject.getPrincipal());
        WebUtils.redirectToSavedRequest(request,response,"/index.htm");
        return false;
    }*/

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
        Subject subject = getSubject(request, response);
        if(!subject.isAuthenticated() && subject.isRemembered()){
            Session session = subject.getSession(true);
            if(session.getAttribute("sessionUser") == null){
                String username = subject.getPrincipal().toString();
                session.setAttribute("sessionUser",userService.getUserByName(username));
            }
        }
        return subject.isAuthenticated() || subject.isRemembered();
    }

    @Override
    public void setLoginUrl(String loginUrl) {
        String previous = getLoginUrl();
        if (previous != null) {
            this.appliedPaths.remove(previous);
        }
        super.setLoginUrl(loginUrl);
        if (log.isTraceEnabled()) {
            log.trace("Adding login url to applied paths.");
        }
        this.appliedPaths.put(getLoginUrl(), null);
    }


    public String getReadLoginUrl() {
        return readLoginUrl;
    }

    public void setReadLoginUrl(String readLoginUrl) {
        this.readLoginUrl = readLoginUrl;
    }
}
