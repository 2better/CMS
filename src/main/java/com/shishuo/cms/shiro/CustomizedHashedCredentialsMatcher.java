package com.shishuo.cms.shiro;

import net.sf.ehcache.Element;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;

import java.util.concurrent.atomic.AtomicInteger;

/**
 * @author zyl
 * @create 2017/6/18
 */

public class CustomizedHashedCredentialsMatcher extends HashedCredentialsMatcher
{

    private Cache<String, AtomicInteger> passwordRetryCache;

    public CustomizedHashedCredentialsMatcher(CacheManager cacheManager) {
        passwordRetryCache = cacheManager.getCache("passwordRetryCache");
    }

    @Override
    public boolean doCredentialsMatch(AuthenticationToken token, AuthenticationInfo info) {
        String username = (String)token.getPrincipal();
        AtomicInteger atomicInteger = passwordRetryCache.get(username);
        if(atomicInteger == null) {
            atomicInteger = new AtomicInteger(1);
            passwordRetryCache.put(username,atomicInteger);
        }else {
            if (atomicInteger.incrementAndGet() > 4) {
                throw new ExcessiveAttemptsException();
            }
        }
        boolean matches = super.doCredentialsMatch(token, info);
        if(matches) {
            passwordRetryCache.remove(username);
        }
        return matches;
    }
}
