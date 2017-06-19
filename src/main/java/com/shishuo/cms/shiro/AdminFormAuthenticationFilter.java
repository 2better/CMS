package com.shishuo.cms.shiro;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.AuthenticatingFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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

public class AdminFormAuthenticationFilter extends AuthenticatingFilter
{

    public static final String DEFAULT_ERROR_KEY_ATTRIBUTE_NAME = "shiroLoginFailure";

    public static final String DEFAULT_USERNAME_PARAM = "username";
    public static final String DEFAULT_PASSWORD_PARAM = "password";
    public static final String DEFAULT_REMEMBER_ME_PARAM = "rememberMe";

    private static final Logger log = LoggerFactory.getLogger(AdminFormAuthenticationFilter.class);

    private String usernameParam = DEFAULT_USERNAME_PARAM;
    private String passwordParam = DEFAULT_PASSWORD_PARAM;
    private String rememberMeParam = DEFAULT_REMEMBER_ME_PARAM;
    private String readLoginUrl;

    private String failureKeyAttribute = DEFAULT_ERROR_KEY_ATTRIBUTE_NAME;

    public AdminFormAuthenticationFilter() {
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


            // 校验验证码
            // 从session获取正确的验证码
            HttpSession session = ((HttpServletRequest)request).getSession();
            //页面输入的验证码
            String captcha = request.getParameter("captcha");
            //从session中取出验证码
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

   /* protected boolean onAccessDenied(ServletRequest request,
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
    }*/

    /*@Override
    protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request, ServletResponse response) throws Exception {
        WebUtils.getAndClearSavedRequest(request);
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        httpServletRequest.getSession().setAttribute("SESSION_ADMIN",subject.getPrincipal());
        WebUtils.redirectToSavedRequest(request,response,"/manage/index.htm");
        return false;
    }*/

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
