package com.shishuo.cms.shiro;

import com.shishuo.cms.entity.Admin;
import com.shishuo.cms.service.AdminService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;


/**
 * 学生Realm
 *
 * @author zyl
 * @create 2016/11/24
 */

public class AdminRealm extends AuthorizingRealm {

    @Autowired
    private AdminService adminService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
        Object obj =  principals.getPrimaryPrincipal();
        if (obj instanceof Admin) {
            simpleAuthorizationInfo.addRole("admin");
        }
        return simpleAuthorizationInfo;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String name = (String) token.getPrincipal();

        Admin admin = null;
        try {
            admin = adminService.getAdminByName(name);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (admin == null) {
            throw new UnknownAccountException("账号不存在");
        }
        SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(admin, admin.getPassword(), getName());
        simpleAuthenticationInfo.setCredentialsSalt(ByteSource.Util.bytes(admin.getSalt()));

        return simpleAuthenticationInfo;
    }

    @Override
    public Class getAuthenticationTokenClass() {
        //支持的Token类的class
        return AdminToken.class;
    }

    //是否支持该token
    //Realm支持的类可以是token的子类或相同
    @Override
    public boolean supports(AuthenticationToken token) {
        return token != null && getAuthenticationTokenClass().isAssignableFrom(token.getClass());
    }

}
