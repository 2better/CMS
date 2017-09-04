package com.shishuo.cms.util;


import org.apache.log4j.jdbc.JDBCAppender;
import org.apache.log4j.spi.ErrorCode;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * log4j数据库连接
 *
 * @author zyl
 * @create 2017/9/4
 */

public class JDBCPoolAppender extends JDBCAppender
{

    public JDBCPoolAppender()
    {
        super();
    }

    @Override
    protected void closeConnection(Connection con)
    {
        try
        {
            if ( con != null && !con.isClosed())
                con.close();
        }
        catch (SQLException e)
        {
            errorHandler.error("Error closing MyJDBCAppender.closeConnection() 's connection",e, ErrorCode.GENERIC_FAILURE);
        }
    }

    @Override
    protected Connection getConnection() throws SQLException
    {
        return DataSourceUtils.getConnection();
    }

}
