package com.shishuo.cms.shiro;

import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;


import java.util.concurrent.atomic.AtomicInteger;

/**
 * @author zyl
 * @create 2017/6/18
 */

public class CustomizedHashedCredentialsMatcher extends HashedCredentialsMatcher
{

    private Cache passwordRetryCache;

    public CustomizedHashedCredentialsMatcher(CacheManager cacheManager) {
        passwordRetryCache = cacheManager.getCache("passwordRetryCache");
    }

    @Override
    public boolean doCredentialsMatch(AuthenticationToken token, AuthenticationInfo info) {
        String username = (String)token.getPrincipal();
        AtomicInteger atomicInteger = null;
        Cache.ValueWrapper valueWrapper = passwordRetryCache.get(username);
        if(valueWrapper == null) {
            atomicInteger = new AtomicInteger(1);
            passwordRetryCache.put(username,atomicInteger);
        }else {
            atomicInteger = (AtomicInteger) valueWrapper.get();
            if (atomicInteger.incrementAndGet() > 4) {
                throw new ExcessiveAttemptsException();
            }
        }
        boolean matches = super.doCredentialsMatch(token, info);
        if(matches) {
            passwordRetryCache.evict(username);
        }
        return matches;
    }
}
