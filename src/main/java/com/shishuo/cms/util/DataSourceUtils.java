package com.shishuo.cms.util;

import com.alibaba.druid.pool.DruidDataSourceFactory;

import javax.sql.DataSource;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

/**
 * @author zyl
 * @create 2017/9/4
 */

public class DataSourceUtils
{
    private static DataSource dataSource = null;

    static{
        try{
            InputStream in = DataSourceUtils.class.getClassLoader().getResourceAsStream("shishuocms.properties");
            Properties prop = new Properties();
            prop.load(in);

            Properties result = new Properties();
            result.put("url",prop.getProperty("jdbc.url"));
            result.put("username",prop.getProperty("jdbc.username"));
            result.put("password",prop.getProperty("jdbc.password"));

            result.put("maxActive","10");
            result.put("minIdle","3");
            result.put("initialSize","3");
            result.put("dbType","mysql");

            dataSource = DruidDataSourceFactory.createDataSource(result);
        }catch (Exception e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    public static Connection getConnection() throws SQLException{
        return dataSource.getConnection();
    }

}
