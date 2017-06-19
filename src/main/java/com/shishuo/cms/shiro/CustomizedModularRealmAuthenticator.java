package com.shishuo.cms.shiro;

import org.apache.shiro.authc.*;
import org.apache.shiro.authc.pam.ModularRealmAuthenticator;
import org.apache.shiro.authc.pam.UnsupportedTokenException;
import org.apache.shiro.realm.Realm;

import java.util.Collection;

/**
 * @author zyl
 * @create 2017/6/18
 */

public class CustomizedModularRealmAuthenticator extends ModularRealmAuthenticator
{
    @Override
    protected AuthenticationInfo doMultiRealmAuthentication(Collection<Realm> realms, AuthenticationToken token) {

        for (Realm realm : realms) {
            if (realm.supports(token)) {
                AuthenticationInfo info = realm.getAuthenticationInfo(token);
                if (info == null) {
                    throw new UnknownAccountException();
                }
                return info;
            }
        }
        throw new UnsupportedTokenException();
    }
}
