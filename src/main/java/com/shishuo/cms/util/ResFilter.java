package com.shishuo.cms.util;

import com.shishuo.cms.entity.Admin;
import com.shishuo.cms.entity.User;
import org.apache.log4j.MDC;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;

import javax.servlet.*;
import java.io.IOException;

/**
 * @author zyl
 * @create 2017/9/2
 */

public class ResFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        Subject currentUser = SecurityUtils.getSubject();
        Object obj =  currentUser.getPrincipal();
            if (obj!=null){
                if (obj instanceof Admin) {
                    Admin admin = (Admin) obj;
                    MDC.put("userName", admin.getName());
                }else {
                    User user = (User)obj;
                    MDC.put("userName", user.getName());
                }
            }
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {

    }
}
