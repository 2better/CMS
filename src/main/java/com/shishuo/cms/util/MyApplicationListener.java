package com.shishuo.cms.util;

import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.ServletContext;
import java.io.File;

/**
 * Created by labber on 2017/6/26.
 */
@Component
public class MyApplicationListener implements ApplicationListener<ContextRefreshedEvent>{

    public static String path = "";

    @Override
    public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {
        ApplicationContext applicationContext = contextRefreshedEvent.getApplicationContext();
        WebApplicationContext webApplicationContext = (WebApplicationContext)applicationContext;
        ServletContext servletContext = webApplicationContext.getServletContext();
        path = servletContext.getRealPath("/");
        System.out.println("path:" + path);
    }
}
