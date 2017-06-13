package com.shishuo.cms.shiro;

import com.shishuo.cms.entity.Admin;
import com.shishuo.cms.entity.User;
import com.shishuo.cms.service.AdminService;
import com.shishuo.cms.service.UserService;
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

public class CustomizedRealm extends AuthorizingRealm
{

    @Autowired
    private AdminService adminService;
    @Autowired
    private UserService userService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {

        SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
        Object obj =  principals.getPrimaryPrincipal();
        if (obj instanceof Admin) {
            simpleAuthorizationInfo.addRole("admin");
        }else {
            simpleAuthorizationInfo.addRole("user");
        }
        return simpleAuthorizationInfo;

    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String name = (String) token.getPrincipal();
        String[] str  = name.split("#-@");

        if(str.length<2)
            throw new UnknownAccountException("账号不存在");

        name = str[0];
        SimpleAuthenticationInfo simpleAuthenticationInfo = null;

        if(str[1].equals("yh")){
            User user = null;
            try {
                user  = userService.getUserByName(name);
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (user == null) {
                throw new UnknownAccountException("账号不存在");
            }

            simpleAuthenticationInfo = new SimpleAuthenticationInfo(user, user.getPassword(),getName());
            simpleAuthenticationInfo.setCredentialsSalt(ByteSource.Util.bytes(user.getSalt()));

        }else if(str[1].equals("gl"))
        {
            Admin admin = null;
            try {
                admin = adminService.getAdminByName(name);
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (admin == null) {
                throw new UnknownAccountException("账号不存在");
            }
            simpleAuthenticationInfo  = new SimpleAuthenticationInfo(admin, admin.getPassword(),getName());
            simpleAuthenticationInfo.setCredentialsSalt(ByteSource.Util.bytes(admin.getSalt()));
        }else
        {
            throw new UnknownAccountException("账号不存在");
        }

        return simpleAuthenticationInfo;
    }
}
